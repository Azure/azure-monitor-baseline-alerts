<#
.SYNOPSIS
    This script cleans up the deployment entries at the management group hierarchy level performed by the ALZ-Monitor automation.

.DESCRIPTION
    This script cleans up the deployment entries at the management group hierarchy level performed by the ALZ-Monitor automation.

.NOTES
    This script will only removes deployment names whose name starts with 'amba-'All other deployment entries will be left in place.

.LINK
    https://github.com/Azure/azure-monitor-baseline-alerts

.EXAMPLE
    ./Remove-AMBADeployments.ps1 -pseudoManagementGroup Contoso -ReportOnly
    # generate a list of the deployments which would be deleted by this script

.EXAMPLE
    ./Remove-AMBADeployments.ps1 -pseudoManagementGroup Contoso -WhatIf
    # show output of what would happen if deletes executed

.EXAMPLE
    ./Remove-AMBADeployments.ps1 -pseudoManagementGroup Contoso -Force
    # delete all deployments entries for deployments performed by the ALZ-Monitor IaC without prompting for confirmation
#>

[CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'High')]
param(
    # the pseudo managemnt group to start from
    [Parameter(Mandatory=$True,
      ValueFromPipeline=$false)]
      [string]$pseudoRootManagementGroup,
    # output a list of the resources to be deleted
    [Parameter(Mandatory=$False,
      ValueFromPipeline=$false)]
      [switch]$reportOnly,
    # if not specified, delete will prompt for confirmation
    [Parameter(Mandatory=$False,
      ValueFromPipeline=$false)]
      [switch]$force
)

Function Iterate-ManagementGroups($mg) {

  $script:managementGroups += $mg.Name
  if ($mg.Children) {
      foreach ($child in $mg.Children) {
          if ($child.Type -eq 'Microsoft.Management/managementGroups') {
          Iterate-ManagementGroups $child
          }
      }
  }
}

$ErrorActionPreference = 'Stop'

If (-NOT(Get-Module -ListAvailable Az.ResourceGraph)) {
    Write-Warning "This script requires the Az.ResourceGraph module."

    $response = Read-Host "Would you like to install the 'Az.ResourceGraph' module now? (y/n)"
    If ($response -match '[yY]') { Install-Module Az.ResourceGraph -Scope CurrentUser }
}

# get all management groups -- used in graph query scope
$managementGroups = @()
$allMgs = Get-AzManagementGroup -GroupName $pseudoRootManagementGroup -Expand -Recurse
ForEach ($mg in $allMgs) {
    Iterate-ManagementGroups $mg
}

Write-Host "Found '$($managementGroups.Count)' management groups to query for ALZ-Monitor deployments."


If ($managementGroups.count -eq 0) {
    Write-Error "The command 'Get-AzManagementGroups' returned '0' groups. This script needs to run with Owner permissions on the Azure Landing Zones intermediate root management group to effectively clean up Policies and all related resources."
}

# get AMBA deployments to delete
$allDeployments = @()
ForEach ($mg in $managementGroups) {
    $deployments = Get-AzManagementGroupDeployment -ManagementGroupId "$mg" | where {$_.DeploymentName.StartsWith("amba-")}
    $allDeployments += $deployments
}

Write-Host "Found '$($allDeployments.Count)' for ALZ-Monitor deployments with name starting 'amba-'."

If (!$reportOnly.IsPresent) {

    Write-Warning "This script will delete the AMBA deployments discovered above."

    If (!$force.IsPresent) {
        While ($prompt -notmatch '[yYnN]') {
            $prompt = Read-Host -Prompt 'Would you like to proceed with the deletion? (y/n)'
        }
        If ($prompt -match '[yY]') {
            $force = $true
        }
        Else {
            Write-Host "Exiting script..."
            return
        }
    }

    # delete alert processing rules
    Write-Host "Deleting AMBA deployments..."
    $allDeployments | ForEach-Object -Parallel { Remove-AzManagementGroupDeployment -InputObject $_ }

    Write-Host "AMBA deployments cleanup complete."
}
Else {
    $resourceToBeDeleted = $allDeployments.Name

    return $resourceToBeDeleted
}
