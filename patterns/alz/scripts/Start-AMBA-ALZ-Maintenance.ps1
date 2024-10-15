# The below copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.

# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

<#
.DESCRIPTION
    This script is intended to consolidate previous maintenance scripts. It allow customers to:
    - remove ALL resources deployed by the AMBA-ALZ pattern (alerts, policy assignments, policy initiatives, policy definitions, and policy assignment role assignments)
    - remove ONLY the deployment entries of AMBA-ALZ happening at the pseudo root management group level
    - remove ONLY the notification assets (AGs and APRs) deployed by AMBA-ALZ
    - remove ONLY alerts deployed by the AMBA-ALZ pattern
    - remove ONLY policy assignments and role assignment created by the AMBA-ALZ deployment
    - remove ONLY policy definitions and policy initiatives created by the AMBA-ALZ deployment
    - remove ONLY orphaned alerts deployed by the AMBA-ALZ pattern

    In order for this script to function the deployed resources must have a tag _deployed_by_amba with a value of true and Policy resources must have metadata property
    named _deployed_by_amba with a value of True. These tags and metadata are included in the automation, but if they are subsequently removed, there may be orphaned
    resources after this script executes.

    The Role Assignments associated with Policy assignment identities and including _deployed_by_amba in the description field will also be deleted.

    This script leverages the Azure Resource Graph to find object to delete. Note that the Resource Graph lags behind ARM by a couple minutes.

.LINK
    https://github.com/Azure/azure-monitor-baseline-alerts

.PARAMETER pseudoRootManagementGroup
    Required. The pseudo root management group to start the cleanup from. This is the management group that is the parent of all the management groups that are part of the AMBA-ALZ deployment.  This is the management group that the AMBA-ALZ deployment was initiated from.

.PARAMETER cleanItems
    Required. The item type we want the script to clean up. The options are:
        - Amba-Alz
        - Deployments
        - NotificationAssets
        - Alerts
        - PolicyAssignments
        - PolicyDefinitions
        - OrphanedAlerts

.EXAMPLE
    ./Start-AMBA-ALZ-Maintenance.ps1 -pseudoRootManagementGroup $pseudoRootManagementGroup -cleanItems Amba-Alz -WhatIf
    # show output of what would happen if deletes executed.

.EXAMPLE
    ./Start-AMBA-ALZ-Maintenance.ps1 -pseudoRootManagementGroup $pseudoRootManagementGroup -cleanItems Amba-Alz
    # execute the script and will ask for confirmation before taking the configured action.

.EXAMPLE
    ./Start-AMBA-ALZ-Maintenance.ps1 -pseudoRootManagementGroup $pseudoRootManagementGroup -cleanItems Amba-Alz -Confirm:$false
    # execute the script without asking for confirmation before taking the configured action.
#>

[CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'High')]
param(
    # the pseudo managemnt group to start from
    [Parameter(Mandatory = $True,
        ValueFromPipeline = $false)]
        [string]$pseudoRootManagementGroup,

    # the items to be cleaned-up
    [Parameter(Mandatory = $True,
        ValueFromPipeline = $false)]
        [ValidateSet("Amba-Alz", "Deployments", "NotificationAssets", "OrphanedAlerts", "Alerts", "PolicyAssignments", "PolicyDefinitions", IgnoreCase = $true)]
        [string]$cleanItems
)

#region general functions
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

        For ($i = 0; $i -le $managementGroupNames.count; $i = $i + 10) {
            $batchGroups = $managementGroupNames[$i..($i + 9)]
            $managementGroupBatches += , @($batchGroups)

            If ($batchGroups.count -lt 10) {
                continue
            }
        }

        $result = [System.Collections.ArrayList]::new()
        ForEach ($managementGroupBatch in $managementGroupBatches) {
            $batchResult = Search-AzGraph -Query $query -ManagementGroup $managementGroupBatch -Verbose:$false @optionalParams

            # resource graph returns pages of 100 resources, if there are more than 100 resources in a batch, recursively query for more
            If ($batchResult.count -eq 100 -and $batchResult.SkipToken) {
                [void]$result.Add($batchResult)
                Search-AzGraphRecursive -query $query -managementGroupNames $managementGroupNames -skipToken $batchResult.SkipToken
            }
            else {
                [void]$result.Add($batchResult)
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

Function Iterate-ManagementGroups($mg) {

    [void]$script:managementGroups.Add($mg.Name)
    if ($mg.Children) {
        foreach ($child in $mg.Children) {
            if ($child.Type -eq 'Microsoft.Management/managementGroups') {
                Iterate-ManagementGroups $child
            }
        }
    }
}

#endregion

#region Get functions
Function Get-ALZ-Alerts {
    # get alert resources to delete
    $query = "Resources | where type in~ ('Microsoft.Insights/metricAlerts','Microsoft.Insights/activityLogAlerts', 'Microsoft.Insights/scheduledQueryRules') and tags['_deployed_by_amba'] =~ 'True' | project id"
    $alertResourceIds = Search-AzGraphRecursive -Query $query -ManagementGroupNames $managementGroups | Select-Object -ExpandProperty Id | Sort-Object | Get-Unique
    Write-Host "- Found '$($alertResourceIds.Count)' metric, activity log and log alerts with tag '_deployed_by_amba=True' to be deleted." -ForegroundColor Cyan

    # Returning items
    $alertResourceIds
}

Function Get-ALZ-OrphanedAlerts {

    # get AMBA-ALZ alert resources
    $query = "Resources | where type in~ ('Microsoft.Insights/metricAlerts','Microsoft.Insights/activityLogAlerts', 'Microsoft.Insights/scheduledQueryRules') and tags['_deployed_by_amba'] =~ 'True' | project id, scope = tostring(properties.scopes)"
    $alertResources = Search-AzGraphRecursive -Query $query -ManagementGroupNames $managementGroups

    # get alerts without scoped resource existent
    If ($alertResources.count -gt 0) {
        $tempArrayList = [System.Collections.ArrayList]::new()
        $orphanedAlerts = [System.Collections.ArrayList]::Synchronized($tempArrayList)
        <#ForEach ($alert in $alertResources) {
            $scope = $($alert.scope.replace('"]', '')).replace('["', '')
            $query = "Resources | where id =~ '$scope' | project id"
            $resourceId = Search-AzGraphRecursive -Query $query -ManagementGroupNames $managementGroups | Select-Object -ExpandProperty Id

            If (-NOT $resourceId) {
                $orphanedAlerts.add($alert.id)
            }
        }#>

        $alertResources | ForEach-Object -Parallel {
            $arr = $using:orphanedAlerts
            $scope = $($_.scope.replace('"]', '')).replace('["', '')

            # Filtering out alerts targeted at the subscriptions and the resource groups
            if (($scope -split '/').count -gt 5) {
                $resourceId = Get-AzResource -ResourceId $scope -ErrorAction SilentlyContinue

                if (-not $resourceId) {
                    [void]$arr.Add($_.id)
                }
            }
        }
    }

    Write-Host "- Found '$($orphanedAlerts.Count)' orphaned metric, activity log and log alerts with tag '_deployed_by_amba=True' to be deleted." -ForegroundColor Cyan

    # Returning items
    $orphanedAlerts
}

Function Get-ALZ-ResourceGroups {
    # get resource group to delete
    $query = "ResourceContainers | where type =~ 'microsoft.resources/subscriptions/resourcegroups' and tags['_deployed_by_amba'] =~ 'True' | project id"
    $resourceGroupIds = Search-AzGraphRecursive -Query $query -ManagementGroupNames $managementGroups | Select-Object -ExpandProperty Id | Sort-Object | Get-Unique
    Write-Host "- Found '$($resourceGroupIds.Count)' resource groups with tag '_deployed_by_amba=True' to be deleted." -ForegroundColor Cyan

    # Returning items
    $resourceGroupIds
}

Function Get-ALZ-PolicyAssignments {
    # get policy assignments to delete
    $query = "policyresources | where type =~ 'microsoft.authorization/policyAssignments' | project name,metadata=parse_json(properties.metadata),type,identity,id | where metadata._deployed_by_amba =~ 'true'"
    $policyAssignmentIds = Search-AzGraphRecursive -Query $query -ManagementGroupNames $managementGroups | Select-Object -ExpandProperty Id | Sort-Object | Get-Unique
    Write-Host "- Found '$($policyAssignmentIds.Count)' policy assignments with metadata '_deployed_by_amba=True' to be deleted." -ForegroundColor Cyan

    # Returning items
    $policyAssignmentIds
}

Function Get-ALZ-PolicySetDefinitions {
    # get policy set definitions to delete
    $query = "policyresources | where type =~ 'microsoft.authorization/policysetdefinitions' | project name,metadata=parse_json(properties.metadata),type,id | where metadata._deployed_by_amba =~ 'true' | project id"
    $policySetDefinitionIds = Search-AzGraphRecursive -Query $query -ManagementGroupNames $managementGroups | Select-Object -ExpandProperty Id | Sort-Object | Get-Unique
    Write-Host "- Found '$($policySetDefinitionIds.Count)' policy set definitions with metadata '_deployed_by_amba=True' to be deleted." -ForegroundColor Cyan

    # Returning items
    $policySetDefinitionIds
}

Function Get-ALZ-PolicyDefinitions {
    # get policy definitions to delete
    $query = "policyresources | where type =~ 'microsoft.authorization/policyDefinitions' | project name,metadata=parse_json(properties.metadata),type,id | where metadata._deployed_by_amba =~ 'true' | project id"
    $policyDefinitionIds = Search-AzGraphRecursive -Query $query -ManagementGroupNames $managementGroups | Select-Object -ExpandProperty Id | Sort-Object | Get-Unique
    Write-Host "- Found '$($policyDefinitionIds.Count)' policy definitions with metadata '_deployed_by_amba=True' to be deleted." -ForegroundColor Cyan

    # Returning items
    $policyDefinitionIds

}

Function Get-ALZ-UserAssignedManagedIdentities {
    # get user assigned managed identities to delete
    $query = "Resources | where type =~ 'Microsoft.ManagedIdentity/userAssignedIdentities' and tags['_deployed_by_amba'] =~ 'True' | project id, name, principalId = properties.principalId, tenantId, subscriptionId, resourceGroup"
    $UamiIds = Search-AzGraphRecursive -Query $query -ManagementGroupNames $managementGroups | Sort-Object -Property id | Get-Unique -AsString
    Write-Host "- Found '$($UamiIds.Count)' user assigned managed identities with tag '_deployed_by_amba=True' to be deleted." -ForegroundColor Cyan

    # Returning items
    $UamiIds
}

Function Get-ALZ-RoleAssignments {
    # get role assignments to delete
    $query = "authorizationresources | where type =~ 'microsoft.authorization/roleassignments' and properties.description == '_deployed_by_amba' | project roleDefinitionId = properties.roleDefinitionId, objectId = properties.principalId, scope = properties.scope, id"
    $roleAssignments = Search-AzGraphRecursive -Query $query -ManagementGroupNames $managementGroups | Sort-Object -Property id | Get-Unique -AsString
    Write-Host "- Found '$($roleAssignments.Count)' role assignments with description '_deployed_by_amba' to be deleted." -ForegroundColor Cyan

    # Returning items
    $roleAssignments
}

Function Get-ALZ-Deployments {
    # get deployments to delete
    $allDeployments = @()
    ForEach ($mg in $managementGroups) {
        $deployments = Get-AzManagementGroupDeployment -ManagementGroupId "$mg" -WarningAction silentlyContinue | where { $_.DeploymentName.StartsWith("amba-") }
        $allDeployments += $deployments
    }
    Write-Host "- Found '$($allDeployments.Count)' deployments for AMBA-ALZ pattern with name starting with 'amba-' performed on the '$pseudoRootManagementGroup' Management Group hierarchy." -ForegroundColor Cyan

    # Returning items
    $allDeployments
}

Function Get-ALZ-AlertProcessingRules {
    # get alert processing rules to delete
    #$query = "resources | where type =~ 'Microsoft.AlertsManagement/actionRules' | where tags['_deployed_by_amba'] =~ 'True'| project id"
    $query = "resources | where type =~ 'Microsoft.AlertsManagement/actionRules' | where name startswith 'apr-AMBA-' and properties.description startswith 'AMBA Notification Assets - ' and tags['_deployed_by_amba'] =~ 'True'| project id"
    $alertProcessingRuleIds = Search-AzGraphRecursive -Query $query -ManagementGroupNames $managementGroups | Select-Object -ExpandProperty Id | Sort-Object | Get-Unique
    Write-Host "- Found '$($alertProcessingRuleIds.Count)' alert processing rule(s) with tag '_deployed_by_amba=True' to be deleted." -ForegroundColor Cyan

    # Returning items
    $alertProcessingRuleIds
}

Function Get-ALZ-ActionGroups {
    # get action groups to delete
    $query = "resources | where type =~ 'Microsoft.Insights/actionGroups' | where tags['_deployed_by_amba'] =~ 'True' | project id"
    $actionGroupIds = Search-AzGraphRecursive -Query $query -ManagementGroupNames $managementGroups | Select-Object -ExpandProperty Id | Sort-Object | Get-Unique
    Write-Host "- Found '$($actionGroupIds.Count)' action group(s) with tag '_deployed_by_amba=True' to be deleted." -ForegroundColor Cyan

    # Returning items
    $actionGroupIds
}

#endregion

#region Delete functions
Function Delete-ALZ-Alerts($fAlertsToBeDeleted)
{
    # delete alert resources
    Write-Host "`n-- Deleting alerts ..." -foregroundcolor Yellow
    $fAlertsToBeDeleted | Foreach-Object -Parallel { Remove-AzResource -ResourceId $_ -Force } | Out-Null
    Write-Host "---- Done deleting alerts ..." -ForegroundColor Cyan
}

Function Delete-ALZ-ResourceGroups($fRgToBeDeleted)
{
    # delete resource groups
    Write-Host "`n-- Deleting resource groups ..." -foregroundcolor Yellow
    $fRgToBeDeleted | ForEach-Object { Remove-AzResourceGroup -ResourceGroupId $_ -Confirm:$false } | Out-Null
    Write-Host "---- Done deleting resource groups ..." -foregroundcolor Cyan
}

Function Delete-ALZ-PolicyAssignments($fPolicyAssignmentsToBeDeleted)
{
    # delete policy assignments
    Write-Host "`n-- Deleting policy assignments ..." -foregroundcolor Yellow
    $fPolicyAssignmentsToBeDeleted | ForEach-Object -Parallel { Remove-AzPolicyAssignment -Id $_ -Confirm:$false -ErrorAction Stop } | Out-Null
    Write-Host "---- Done policy assignments ..." -foregroundcolor Cyan
}
Function Delete-ALZ-PolicySetDefinitions($fPolicySetDefinitionsToBeDeleted)
{
    # delete policy set definitions
    Write-Host "`n-- Deleting policy set definitions ..." -foregroundcolor Yellow
    $fPolicySetDefinitionsToBeDeleted | ForEach-Object -Parallel { Remove-AzPolicySetDefinition -Id $_ -Force } | Out-Null
    Write-Host "---- Done deleting policy set definitions ..." -foregroundcolor Cyan
}

Function Delete-ALZ-PolicyDefinitions($fPolicyDefinitionsToBeDeleted)
{
    # delete policy definitions
    Write-Host "`n-- Deleting policy definitions ..." -foregroundcolor Yellow
    $fPolicyDefinitionsToBeDeleted | ForEach-Object -Parallel { Remove-AzPolicyDefinition -Id $_ -Force } | Out-Null
    Write-Host "---- Done deleting policy definitions ..." -foregroundcolor Cyan
}

Function Delete-ALZ-RoleAssignments($fRoleAssignmentsToBeDeleted)
{
    # delete role assignments
    Write-Host "`n-- Deleting role assignments ..." -foregroundcolor Yellow
    $fRoleAssignmentsToBeDeleted | Select-Object -Property objectId, roleDefinitionId, scope | ForEach-Object -Parallel { Remove-AzRoleAssignment @psItem -Confirm:$false } | Out-Null
    Write-Host "---- Done deleting role assignments ..." -foregroundcolor Cyan
}

Function Delete-ALZ-UserAssignedManagedIdentities($fUamiToBeDeleted)
{
    # delete user assigned managed identities
    Write-Host "`n-- Deleting user assigned managed identities ..." -foregroundcolor Yellow
    $fUamiToBeDeleted | ForEach-Object -Parallel { Remove-AzUserAssignedIdentity -ResourceGroupName $_.resourceGroup -Name $_.name -SubscriptionId $_.subscriptionId -Confirm:$false } | Out-Null
    Write-Host "---- Done deleting user assigned managed identities ..." -foregroundcolor Cyan
}

Function Delete-ALZ-AlertProcessingRules($fAprToBeDeleted)
{
    # delete alert processing rules
    Write-Host "`n-- Deleting alert processing rules ..." -foregroundcolor Yellow
    $fAprToBeDeleted | Foreach-Object -Parallel { Remove-AzResource -ResourceId $_ -Force } | Out-Null
    Write-Host "---- Done deleting alert processing rules ..." -foregroundcolor Cyan
}

Function Delete-ALZ-ActionGroups($fAgToBeDeleted)
{
    # delete action groups
    Write-Host "`n-- Deleting action groups ..." -foregroundcolor Yellow
    $fAgToBeDeleted | Foreach-Object -Parallel { Remove-AzResource -ResourceId $_ -Force } | Out-Null
    Write-Host "---- Done deleting action groups ..." -foregroundcolor Cyan
}

Function Delete-ALZ-Deployments($fDeploymentsToBeDeleted)
{
    # delete deployments
    Write-Host "`n-- Deleting deployments ..." -foregroundcolor Yellow
    $fDeploymentsToBeDeleted | ForEach-Object -Parallel { Remove-AzManagementGroupDeployment -InputObject $_ -WarningAction silentlyContinue } -throttlelimit 100 | Out-Null
    Write-Host "---- Done deleting deployments ..." -foregroundcolor Cyan
}

#endregion

$ErrorActionPreference = 'Stop'

If (-NOT(Get-Module -ListAvailable Az.Resources)) {
    Write-Warning "This script requires the Az.Resources module."

    $response = Read-Host "Would you like to install the 'Az.Resources' module now? (y/n)"
    If ($response -match '[yY]') { Install-Module Az.Resources -Scope CurrentUser }
}

If (-NOT(Get-Module -ListAvailable Az.ResourceGraph)) {
    Write-Warning "This script requires the Az.ResourceGraph module."

    $response = Read-Host "Would you like to install the 'Az.ResourceGraph' module now? (y/n)"
    If ($response -match '[yY]') { Install-Module Az.ResourceGraph -Scope CurrentUser }
}

If (-NOT(Get-Module -ListAvailable Az.ManagedServiceIdentity)) {
    Write-Warning "This script requires the Az.ManagedServiceIdentity module."

    $response = Read-Host "Would you like to install the 'Az.ManagedServiceIdentity' module now? (y/n)"
    If ($response -match '[yY]') { Install-Module Az.ManagedServiceIdentity -Scope CurrentUser }
}

# get all management groups -- used in graph query scope
$managementGroups = [System.Collections.ArrayList]::new()
$allMgs = Get-AzManagementGroup -GroupName $pseudoRootManagementGroup -Expand -Recurse
foreach ($mg in $allMgs) {
    Iterate-ManagementGroups $mg
}

Write-Host "`nFound '$($managementGroups.Count)' management group(s) (including the parent one) which are part of the '$pseudoRootManagementGroup' management group hierarchy, to be queried for AMBA-ALZ resources.`n"

If ($managementGroups.count -eq 0) {
    Write-Error "The command 'Get-AzManagementGroups' returned '0' groups. This script needs to run with Owner permissions on the Azure Landing Zones intermediate root management group to effectively clean up Policies and all related resources deployed by AMBA-ALZ."
}

Switch ($cleanItems)
{
    "Amba-Alz"
    {
        # Invoking function to retrieve alerts
        $alertsToBeDeleted = Get-ALZ-Alerts

        # Invoking function to retrieve resource groups
        $rgToBeDeleted = Get-ALZ-ResourceGroups

        # Invoking function to retrieve policy assignments
        $policyAssignmentToBeDeleted = Get-ALZ-PolicyAssignments

        # Invoking function to retrieve policy set definitions
        $policySetDefinitionsToBeDeleted = Get-ALZ-PolicySetDefinitions

        # Invoking function to retrieve policy definitions
        $policyDefinitionsToBeDeleted = Get-ALZ-PolicyDefinitions

        # Invoking function to retrieve role assignments
        $roleAssignmentsToBeDeleted = Get-ALZ-RoleAssignments

        # Invoking function to retrieve user assigned managed identities
        $uamiToBeDeleted = Get-ALZ-UserAssignedManagedIdentities

        # Invoking function to retrieve alert processing rules
        $aprToBeDeleted = Get-ALZ-AlertProcessingRules

        # Invoking function to retrieve action groups
        $agToBeDeleted = Get-ALZ-ActionGroups

        If (($alertsToBeDeleted.count -gt 0) -or ($policyAssignmentToBeDeleted.count -gt 0) -or ($policySetDefinitionsToBeDeleted.count -gt 0) -or ($policyDefinitionsToBeDeleted.count -gt 0) -or ($roleAssignmentsToBeDeleted.count -gt 0) -or ($uamiToBeDeleted.count -gt 0) -or ($aprToBeDeleted.count -gt 0) -or ($agToBeDeleted.count -gt 0)) {
            If ($PSCmdlet.ShouldProcess($pseudoRootManagementGroup, "Delete alerts, policy assignments, policy initiatives, policy definitions, policy role assignments, user assigned managed identities, alert processing rules and action groups deployed by AMBA-ALZ on the '$pseudoRootManagementGroup' Management Group hierarchy ..." )) {

                # Invoking function to delete alerts
                If ($alertsToBeDeleted.count -gt 0) { Delete-ALZ-Alerts -fAlertsToBeDeleted $alertsToBeDeleted }

                # Invoking function to delete policy assignments
                If ($policyAssignmentToBeDeleted.count -gt 0) { Delete-ALZ-PolicyAssignments -fPolicyAssignmentsToBeDeleted $policyAssignmentToBeDeleted }

                # Invoking function to delete policy set definitions
                If ($policySetDefinitionsToBeDeleted.count -gt 0) { Delete-ALZ-PolicySetDefinitions -fPolicySetDefinitionsToBeDeleted $policySetDefinitionsToBeDeleted }

                # Invoking function to delete policy definitions
                If ($policyDefinitionsToBeDeleted.count -gt 0) { Delete-ALZ-PolicyDefinitions -fPolicyDefinitionsToBeDeleted $policyDefinitionsToBeDeleted }

                # Invoking function to delete role assignments
                If ($roleAssignmentsToBeDeleted.count -gt 0) { Delete-ALZ-RoleAssignments -fRoleAssignmentsToBeDeleted $roleAssignmentsToBeDeleted }

                # Invoking function to delete user assigned managed identities
                If ($uamiToBeDeleted.count -gt 0) { Delete-ALZ-UserAssignedManagedIdentities -fUamiToBeDeleted $uamiToBeDeleted }

                # Invoking function to delete alert processing rules
                If ($aprToBeDeleted.count -gt 0) { Delete-ALZ-AlertProcessingRules -fAprToBeDeleted $aprToBeDeleted }

                # Invoking function to delete action groups
                If ($agToBeDeleted.count -gt 0) { Delete-ALZ-ActionGroups -fAgToBeDeleted $agToBeDeleted }

                # Invoking function to delete resource groups
                # If ($rgToBeDeleted -gt 0) { Delete-ALZ-ResourceGroups -fRgToBeDeleted $rgToBeDeleted }
            }
        }
    }

    "Deployments"
    {
        # Invoking function to retrieve deployments
        $deploymentsToBeDeleted = Get-ALZ-Deployments

        If ($deploymentsToBeDeleted.count -gt 0) {
            If ($PSCmdlet.ShouldProcess($pseudoRootManagementGroup, "Delete deployments performed by AMBA-ALZ on the '$pseudoRootManagementGroup' Management Group hierarchy ..." )) {

              # Invoking function to delete deployments
                Delete-ALZ-Deployments -fDeploymentsToBeDeleted $deploymentsToBeDeleted
            }
        }
    }

    "NotificationAssets"
    {
        # Invoking function to retrieve action groups
        $agToBeDeleted = Get-ALZ-ActionGroups

        # Invoking function to retrieve alert processing rules
        $aprToBeDeleted = Get-ALZ-AlertProcessingRules

        If (($aprToBeDeleted.count -gt 0) -or ($agToBeDeleted.count -gt 0)) {
            If ($PSCmdlet.ShouldProcess($pseudoRootManagementGroup, "Delete AMBA-ALZ alert processing rules and action groups on the '$pseudoRootManagementGroup' Management Group hierarchy ..." )) {

              # Invoking function to delete alert processing rules
                If ($aprToBeDeleted.count -gt 0) { Delete-ALZ-AlertProcessingRules -fAprToBeDeleted $aprToBeDeleted }

                # Invoking function to delete action groups
                If ($agToBeDeleted.count -gt 0) { Delete-ALZ-ActionGroups -fAgToBeDeleted $agToBeDeleted }
            }
        }
    }

    "Alerts"
    {
        # Invoking function to retrieve alerts
        $alertsToBeDeleted = Get-ALZ-Alerts

        If ($alertsToBeDeleted.count -gt 0) {
            If ($PSCmdlet.ShouldProcess($pseudoRootManagementGroup, "Delete alerts deployed by AMBA-ALZ on the '$pseudoRootManagementGroup' Management Group hierarchy ..." )) {

                # Invoking function to delete alerts
                Delete-ALZ-Alerts -fAlertsToBeDeleted $alertsToBeDeleted
            }
        }
    }

    "OrphanedAlerts"
    {
        # Invoking function to retrieve orphaned alerts
        $orphanedAlertsToDeleted = Get-ALZ-OrphanedAlerts

        If ($orphanedAlertsToDeleted.count -gt 0) {
            If ($PSCmdlet.ShouldProcess($pseudoRootManagementGroup, "Delete orphaned alerts deployed by AMBA-ALZ on the '$pseudoRootManagementGroup' Management Group hierarchy ..." )) {

                # Invoking function to delete alerts
                Delete-ALZ-Alerts -fAlertsToBeDeleted $orphanedAlertsToDeleted
            }
        }
    }

    "PolicyAssignments"
    {
        # Invoking function to retrieve policy assignments
        $policyAssignmentsToBeDeleted = Get-ALZ-PolicyAssignments

        # Invoking function to retrieve role assignments
        $roleAssignmentsToBeDeleted = Get-ALZ-RoleAssignments

        If (($policyAssignmentsToBeDeleted.count -gt 0) -or ($roleAssignmentsToBeDeleted.count -gt 0)) {
            If ($PSCmdlet.ShouldProcess($pseudoRootManagementGroup, "Delete policy assignments, policy initiatives, policy definitions and policy role assignments deployed by AMBA-ALZ on the '$pseudoRootManagementGroup' Management Group hierarchy ..." )) {

              # Invoking function to delete policy assignments
                If ($policyAssignmentsToBeDeleted.count -gt 0) { Delete-ALZ-PolicyAssignments -fPolicyAssignmentsToBeDeleted $policyAssignmentsToBeDeleted }

                # Invoking function to delete role assignments
                If ($roleAssignmentsToBeDeleted.count -gt 0) { Delete-ALZ-RoleAssignments -fRoleAssignmentsToBeDeleted $roleAssignmentsToBeDeleted }
            }
        }
    }

    "PolicyDefinitions"
    {
        # Invoking function to retrieve policy set definitions
        $policySetDefinitionsToBeDeleted = Get-ALZ-PolicySetDefinitions

        # Invoking function to retrieve policy definitions
        $policyDefinitionsToBeDeleted = Get-ALZ-PolicyDefinitions

        If (($policySetDefinitionsToBeDeleted.count -gt 0) -or ($policyDefinitionsToBeDeleted.count -gt 0)) {
            If ($PSCmdlet.ShouldProcess($pseudoRootManagementGroup, "Delete policy assignments, policy initiatives, policy definitions and policy role assignments deployed by AMBA-ALZ on the '$pseudoRootManagementGroup' Management Group hierarchy ..." )) {

                # Invoking function to delete policy set definitions
                If ($policySetDefinitionsToBeDeleted.count -gt 0) { Delete-ALZ-PolicySetDefinitions -fPolicySetDefinitionsToBeDeleted $policySetDefinitionsToBeDeleted }

                # Invoking function to delete policy definitions
                If ($policyDefinitionsToBeDeleted.count -gt 0) { Delete-ALZ-PolicyDefinitions -fPolicyDefinitionsToBeDeleted $policyDefinitionsToBeDeleted }
            }
        }
    }
}

Write-Host "`n=== Script execution completed. ===`n"
