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
    This script cleans up the policy assignments, policy initiatives, policy definitions and policy role assignments previously deployed.
.DESCRIPTION

.NOTES
    In order for this script to function the deployed resources must have a tag _deployed_by_amba with a value of true and Policy resources must have metadata property
    named _deployed_by_amba with a value of True. These tags and metadata are included in the automation, but if they are subsequently removed, there may be orphaned
    resources after this script executes.

    The Role Assignments associated with Policy assignment identities and including _deployed_by_amba in the description field will also be deleted.

    This script leverages the Azure Resource Graph to find object to delete. Note that the Resource Graph lags behind ARM by a couple minutes.

.LINK
    https://github.com/Azure/azure-monitor-baseline-alerts

.EXAMPLE
    ./Start-AMBAPolicyInitiativesAndAssignmentsCleanup.ps1 -pseudoRootManagementGroup Contoso -WhatIf
    # show output of what would happen if deletes executed.

.EXAMPLE
    ./Start-AMBAPolicyInitiativesAndAssignmentsCleanup.ps1 -pseudoRootManagementGroup Contoso
    # execute the script and will ask for confirmation before taking the configured action.

.EXAMPLE
    ./Start-AMBAPolicyInitiativesAndAssignmentsCleanup.ps1 -pseudoRootManagementGroup Contoso -Confirm:$false
    # execute the script without asking for confirmation before taking the configured action.
#>

[CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'High')]
param(
    # the pseudo managemnt group to start from
    [Parameter(Mandatory = $True,
        ValueFromPipeline = $false)]
        [string]$pseudoRootManagementGroup
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

        For ($i = 0; $i -le $managementGroupNames.count; $i = $i + 10) {
            $batchGroups = $managementGroupNames[$i..($i + 9)]
            $managementGroupBatches += , @($batchGroups)

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
$managementGroups = @()
$allMgs = Get-AzManagementGroup -GroupName $pseudoRootManagementGroup -Expand -Recurse
foreach ($mg in $allMgs) {
    Iterate-ManagementGroups $mg
}

Write-Host "Found '$($managementGroups.Count)' management groups(s) (including the parent one) which are part of the '$pseudoRootManagementGroup' management group hierarchy, to be queried for policy assignments, policy initiatives, policy definitions and policy role assignments deployed by AMBA-ALZ."

If ($managementGroups.count -eq 0) {
    Write-Error "The command 'Get-AzManagementGroups' returned '0' groups. This script needs to run with Owner permissions on the Azure Landing Zones intermediate root management group to effectively query policy assignments, policy initiatives, policy definitions and policy role assignments deployed by AMBA-ALZ."
}

# get policy assignments to delete
$query = "policyresources | where type =~ 'microsoft.authorization/policyAssignments' | project name,metadata=parse_json(properties.metadata),type,identity,id | where metadata._deployed_by_amba =~ 'true'"
$policyAssignmentIds = Search-AzGraphRecursive -Query $query -ManagementGroupNames $managementGroups | Select-Object -ExpandProperty Id | Sort-Object | Get-Unique
Write-Host "- Found '$($policyAssignmentIds.Count)' policy assignments with metadata '_deployed_by_amba=True' to be deleted."

# get policy set definitions to delete
$query = "policyresources | where type =~ 'microsoft.authorization/policysetdefinitions' | project name,metadata=parse_json(properties.metadata),type,id | where metadata._deployed_by_amba =~ 'true' | project id"
$policySetDefinitionIds = Search-AzGraphRecursive -Query $query -ManagementGroupNames $managementGroups | Select-Object -ExpandProperty Id | Sort-Object | Get-Unique
Write-Host "- Found '$($policySetDefinitionIds.Count)' policy set definitions with metadata '_deployed_by_amba=True' to be deleted."

# get policy definitions to delete
$query = "policyresources | where type =~ 'microsoft.authorization/policyDefinitions' | project name,metadata=parse_json(properties.metadata),type,id | where metadata._deployed_by_amba =~ 'true' | project id"
$policyDefinitionIds = Search-AzGraphRecursive -Query $query -ManagementGroupNames $managementGroups | Select-Object -ExpandProperty Id | Sort-Object | Get-Unique
Write-Host "- Found '$($policyDefinitionIds.Count)' policy definitions with metadata '_deployed_by_amba=True' to be deleted."

# get role assignments to delete
$query = "authorizationresources | where type =~ 'microsoft.authorization/roleassignments' and properties.description == '_deployed_by_amba' | project roleDefinitionId = properties.roleDefinitionId, objectId = properties.principalId, scope = properties.scope, id"
$roleAssignments = Search-AzGraphRecursive -Query $query -ManagementGroupNames $managementGroups | Sort-Object -Property id | Get-Unique -AsString
Write-Host "- Found '$($roleAssignments.Count)' role assignments with description '_deployed_by_amba' to be deleted."

If (($policyAssignmentIds.count -gt 0) -or ($policySetDefinitionIds.count -gt 0) -or ($policyDefinitionIds.count -gt 0) -or ($roleAssignments.count -gt 0)) {
    If ($PSCmdlet.ShouldProcess($pseudoRootManagementGroup, "Delete policy assignments, policy initiatives, policy definitions and policy role assignments deployed by AMBA-ALZ on the '$pseudoRootManagementGroup' Management Group hierarchy ..." )) {

        # delete policy assignments
        If ($policyAssignmentIds.count -gt 0) {
            Write-Host "-- Deleting AMBA-ALZ policy assignments  ..."
            $policyAssignmentIds | ForEach-Object { Remove-AzPolicyAssignment -Id $_ -Confirm:$false }
        }

        # delete policy set definitions
        If ($policySetDefinitionIds.count -gt 0) {
            Write-Host "-- Deleting AMBA-ALZ policy set definitions ..."
            $policySetDefinitionIds | ForEach-Object { Remove-AzPolicySetDefinition -Id $_ -Force }
        }

        # delete policy definitions
        If ($policyDefinitionIds.count -gt 0) {
            Write-Host "-- Deleting AMBA-ALZ policy definitions ..."
            $policyDefinitionIds | ForEach-Object { Remove-AzPolicyDefinition -Id $_ -Force}
        }

        # delete role assignments
        If ($roleAssignments.count -gt 0) {
            Write-Host "-- Deleting AMBA-ALZ role assignments performed on the '$pseudoRootManagementGroup' Management Group hierarchy ..."
            $roleAssignments | Select-Object -Property objectId, roleDefinitionId, scope | ForEach-Object { Remove-AzRoleAssignment @psItem -Confirm:$false | Out-Null }
        }
    }
}

Write-Host "=== Script execution completed. ==="
