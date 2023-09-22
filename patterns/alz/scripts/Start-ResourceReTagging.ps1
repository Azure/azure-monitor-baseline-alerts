<#
.SYNOPSIS
    This script perform the re-tagging operation for resources deployed by the ALZ-Monitor automation, including alerts, policy assignments, policy definitions, and policy assignment role assignments.
.DESCRIPTION

.NOTES
    In order for this script to function the deployed resources must have a tag _deployed_by_alz_monitor with a value of true and Policy resources must have metadata property
    named _deployed_by_alz_monitor with a value of True. These tags and metadata are included in the automation, but if they are subsequently removed, there may be orphaned
    resources after this script executes.

    This script leverages the Azure Resource Graph to find object to delete. Note that the Resource Graph lags behind ARM by a couple minutes.
.LINK
    https://github.com/Azure/azure-monitor-baseline-alerts

.EXAMPLE
    ./Start-ResourceReTagging.ps1 -ReportOnly
    # generate a list of the resource IDs which would be deleted by this script

.EXAMPLE
    ./Start-ResourceReTagging.ps1 -WhatIf
    # show output of what would happen if deletes executed

.EXAMPLE
    ./Start-ResourceReTagging.ps1 -Force
    # delete all resources deployed by the ALZ-Monitor IaC without prompting for confirmation
#>

[CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'High')]
param(
    # output a list of the resources to be deleted
    [switch]$reportOnly,
    # if not specified, delete will prompt for confirmation
    [switch]$force
)

Function Search-AzGraphRecursive {
    # ensure query results with more than 100 resources and/or over more than 10 management groups are returned
    param($query, $managementGroupNames, $skipToken)

    $optionalParams = @{}
    If ($skipToken) {
        $optionalParams += @{skipToken = $skipToken }
    }

    # ARG will only query 10 management groups at a time--implement batching
    If ($managementGroupNames.count -gt 10) {
        $managementGroupBatches = @()

        For ($i=0;$i -le $managementGroupNames.count;$i=$i+10) {
            $batchGroups = $managementGroupNames[$i..($i+9)]
            $managementGroupBatches += ,@($batchGroups)

            If ($batchGroups.count -lt 10) {
                continue
            }
        }

        $result = @()
        ForEach ($managementGroupBatch in $managementGroupBatches) {
            $batchResult = Search-AzGraph -Query $query -ManagementGroup $managementGroupBatch -Verbose:$false @optionalParams

            # resource graph returns pages of 100 resources, if there are more than 100 resources in a batch, recursively query for more
            If ($batchResult.count -eq 100 -and $batchResult.SkipToken) {
                $result += $batchResult
                Search-AzGraphRecursive -query $query -managementGroupNames $managementGroupNames -skipToken $batchResult.SkipToken
            }
            else {
                $result += $batchResult
            }
        }
    }
    Else {
        $result = Search-AzGraph -Query $query -ManagementGroup $managementGroupNames -Verbose:$false @optionalParams

        If ($result.count -eq 100 -and $result.SkipToken) {
            Search-AzGraphRecursive -query $query -managementGroupNames $managementGroupNames -skipToken $result.SkipToken
        }
    }

    $result
}

$ErrorActionPreference = 'Stop'

If (-NOT(Get-Module -ListAvailable Az.ResourceGraph)) {
    Write-Warning "This script requires the Az.ResourceGraph module."

    $response = Read-Host "Would you like to install the 'Az.ResourceGraph' module now? (y/n)"
    If ($response -match '[yY]') { Install-Module Az.ResourceGraph -Scope CurrentUser }
}

# get all management groups -- used in graph query scope
$managementGroups = Get-AzManagementGroup
Write-Host "Found '$($managementGroups.Count)' management groups to query for ALZ-Monitor resources."

If ($managementGroups.count -eq 0) {
    Write-Error "The command 'Get-AzManagementGroups' returned '0' groups. This script needs to run with Owner permissions on the Azure Landing Zones intermediate root management group to effectively clean up Policies and all related resources."
}

# get alert resources to retag
$alertResourceIds = Search-AzGraphRecursive -Query "Resources | where type in~ ('Microsoft.Insights/metricAlerts','Microsoft.Insights/activityLogAlerts', 'Microsoft.Insights/scheduledQueryRules') and tags['_deployed_by_alz_monitor'] =~ 'True' | project id" -ManagementGroupNames $managementGroups.Name |
Select-Object -ExpandProperty Id
Write-Host "Found '$($alertResourceIds.Count)' metric, activity log and log alerts with tag '_deployed_by_alz_monitor=True' to be retagged with '_deployed_by_amba=True'."

# get resource group to retag
$resourceGroupIds = Search-AzGraphRecursive -Query "ResourceContainers | where type =~ 'microsoft.resources/subscriptions/resourcegroups' and tags['_deployed_by_alz_monitor'] =~ 'True' | project id" -ManagementGroupNames $managementGroups.Name |
Select-Object -ExpandProperty Id
Write-Host "Found '$($resourceGroupIds.Count)' resource groups with tag '_deployed_by_alz_monitor=True' to be retagged with '_deployed_by_amba=True'."

# get Action Groups group to retag
$actionGroupIds = Search-AzGraphRecursive -Query "resources | where type =~ 'microsoft.insights/actiongroups' and tags['_deployed_by_alz_monitor'] =~ 'True' | project id" -ManagementGroupNames $managementGroups.Name | Select-Object -ExpandProperty Id
Write-Host "Found '$($actionGroupIds.Count)' action groups with tag '_deployed_by_alz_monitor=True' to be retagged with '_deployed_by_amba=True'."

# get Action Rules group to retag
$actionRuleIds = Search-AzGraphRecursive -Query "resources | where type =~ 'microsoft.alertsmanagement/actionrules' and tags['_deployed_by_alz_monitor'] =~ 'True' | project id" -ManagementGroupNames $managementGroups.Name | Select-Object -ExpandProperty Id
Write-Host "Found '$($actionRuleIds.Count)' action rules with tag '_deployed_by_alz_monitor=True' to be retagged with '_deployed_by_amba=True'."

If (!$reportOnly.IsPresent) {

    Write-Warning "This script will re-tag the resources discovered above."

    If (!$force.IsPresent) {
        While ($prompt -notmatch '[yYnN]') {
            $prompt = Read-Host -Prompt 'Would you like to proceed with the re-tagging? (y/n)'
        }
        If ($prompt -match '[yY]') {
            $force = $true
        }
        Else {
            Write-Host "Exiting script..."
            return
        }
    }

    $ambaTag = @{"_deployed_by_amba"="True";}

    # retag alert resources
    Write-Host "Re-tagging alert resources..."
    $alertResourceIds | Foreach-Object { Update-AzTag -ResourceId $_ -Tag $ambaTag -Operation Replace -Confirm:(!$force) | Out-Null}

    # retag resource groups
    Write-Host "Re-tagging resource groups..."
    $resourceGroupIds | ForEach-Object { Update-AzTag -ResourceId $_ -Tag $ambaTag -Operation Replace -Confirm:(!$force) | Out-Null }

    # retag action groups  resources
    Write-Host "Re-tagging action groups..."
    $actionGroupIds | Foreach-Object { Update-AzTag -ResourceId $_ -Tag $ambaTag -Operation Replace -Confirm:(!$force) | Out-Null}

    # retag action rules
    Write-Host "Re-tagging action rules..."
    $actionRuleIds | ForEach-Object { Update-AzTag -ResourceId $_ -Tag $ambaTag -Operation Replace -Confirm:(!$force) | Out-Null }

}
Else {
    $resourceToReTagged = $alertResourceIds + $resourceGroupIds+$actionGroupIds+$actionRuleIds

    return $resourceToReTagged
}
