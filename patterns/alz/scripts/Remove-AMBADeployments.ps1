# Copyright (c) Microsoft Corporation.
# Licensed under the MIT License.

# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:

# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.

# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

<#
.SYNOPSIS
    This script cleans up the deployment entries at the management group hierarchy level performed by the AMBA-ALZ automation.

.DESCRIPTION
    This script cleans up the deployment entries at the management group hierarchy level performed by the AMBA-ALZ automation.

.NOTES
    This script will only removes deployment names whose name starts with 'amba-'All other deployment entries will be left in place.

.LINK
    https://github.com/Azure/azure-monitor-baseline-alerts

.EXAMPLE
    ./Remove-AMBADeployments.ps1 -pseudoRootManagementGroup Contoso -WhatIf
    # show output of what would happen if deletes executed.

.EXAMPLE
    ./Remove-AMBADeployments.ps1 -pseudoRootManagementGroup Contoso
    # execute the script and will ask for confirmation before taking the configured action.

.EXAMPLE
    ./Remove-AMBADeployments.ps1 -pseudoRootManagementGroup Contoso -Confirm:$false
    # execute the script without asking for confirmation before taking the configured action.

#>

[CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'High')]
param(
    # the pseudo managemnt group to start from
    [Parameter(Mandatory = $True,
        ValueFromPipeline = $false)]
        [string]$pseudoRootManagementGroup
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

Write-Host "Found '$($managementGroups.Count)' management group(s) (including the parent one) which are part of the '$pseudoRootManagementGroup' management group hierarchy, to be queried for AMBA-ALZ deployments."

If ($managementGroups.count -eq 0) {
    Write-Error "The command 'Get-AzManagementGroups' returned '0' groups. This script needs to run with Owner permissions on the Azure Landing Zones intermediate root management group to effectively query all the AMBA-ALZ deployment records."
}

# get AMBA-ALZ deployments to delete
$allDeployments = @()
ForEach ($mg in $managementGroups) {
    $deployments = Get-AzManagementGroupDeployment -ManagementGroupId "$mg" | where { $_.DeploymentName.StartsWith("amba-") }
    $allDeployments += $deployments
}

Write-Host "- Found '$($allDeployments.Count)' deployments for AMBA-ALZ pattern with name starting with 'amba-' performed on the '$pseudoRootManagementGroup' Management Group hierarchy."

If ($allDeployments.Count -gt 0) {
    If ($PSCmdlet.ShouldProcess($pseudoRootManagementGroup, "Delete AMBA-ALZ deployments performed on the '$pseudoRootManagementGroup' Management Group hierarchy ..." )) {
        # overriding confirmation behavior using local copy of $ConfirmPreference
        $ConfirmPreference = 'None'

        # delete AMBA-ALZ deployments
        Write-Host "-- Deleting AMBA-ALZ deployments performed on the '$pseudoRootManagementGroup' Management Group hierarchy ..."
        $allDeployments | ForEach-Object -Parallel { Remove-AzManagementGroupDeployment -InputObject $_ } -throttlelimit 100
    }
}

Write-Host "=== Script execution completed. ==="
