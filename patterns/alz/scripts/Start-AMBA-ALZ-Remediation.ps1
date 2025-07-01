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
    This script is used to trigger remediation on a specific policy or policy set at management group scope.
    It first calls the Azure REST API to get the policy assignments in the management group scope, then it iterates through the policy assignments, checking by name whether it's a policy set or an individual policy.
    Depending on the result the script will either enumerate the policy set and trigger remediation for each individual policy in the set or trigger remediation for the individual policy.

    .LINK
    https://azure.github.io/azure-monitor-baseline-alerts/patterns/alz/deploy/Remediate-Policies/

    .PARAMETER managementGroupName
    The management group name where the policy assignments are located.

    .PARAMETER policyName
    The name of the policy or policy set to remediate.

    .EXAMPLE
    Modify the following variables to match your environment:

    $pseudoRootManagementGroup = "The pseudo root management group id parenting the Platform and Landing Zones management groups"
    $platformManagementGroup = "The management group id for  Platform"
    $identityManagementGroup = "The management group id for Identity"
    $managementManagementGroup = "The management group id for Management"
    $connectivityManagementGroup = "The management group id for Connectivity"
    $LZManagementGroup = "The management group id for Landing Zones"

    Run the following commands to initiate remediation:

    .\patterns\alz\scripts\Start-AMBA-ALZ-Remediation.ps1 -managementGroupName $pseudoRootManagementGroup -policyName Notification-Assets
    .\patterns\alz\scripts\Start-AMBA-ALZ-Remediation.ps1 -managementGroupName $pseudoRootManagementGroup -policyName Alerting-ServiceHealth
    .\patterns\alz\scripts\Start-AMBA-ALZ-Remediation.ps1 -managementGroupName $platformManagementGroup -policyName Alerting-HybridVM
    .\patterns\alz\scripts\Start-AMBA-ALZ-Remediation.ps1 -managementGroupName $platformManagementGroup -policyName Alerting-VM
    .\patterns\alz\scripts\Start-AMBA-ALZ-Remediation.ps1 -managementGroupName $connectivityManagementGroup -policyName Alerting-Connectivity
    .\patterns\alz\scripts\Start-AMBA-ALZ-Remediation.ps1 -managementGroupName $connectivityManagementGroup -policyName Alerting-Connectivity-2
    .\patterns\alz\scripts\Start-AMBA-ALZ-Remediation.ps1 -managementGroupName $identityManagementGroup -policyName Alerting-Identity
    .\patterns\alz\scripts\Start-AMBA-ALZ-Remediation.ps1 -managementGroupName $managementManagementGroup -policyName Alerting-Management
    .\patterns\alz\scripts\Start-AMBA-ALZ-Remediation.ps1 -managementGroupName $LZManagementGroup -policyName Alerting-KeyManagement
    .\patterns\alz\scripts\Start-AMBA-ALZ-Remediation.ps1 -managementGroupName $LZManagementGroup -policyName Alerting-LoadBalancing
    .\patterns\alz\scripts\Start-AMBA-ALZ-Remediation.ps1 -managementGroupName $LZManagementGroup -policyName Alerting-NetworkChanges
    .\patterns\alz\scripts\Start-AMBA-ALZ-Remediation.ps1 -managementGroupName $LZManagementGroup -policyName Alerting-RecoveryServices
    .\patterns\alz\scripts\Start-AMBA-ALZ-Remediation.ps1 -managementGroupName $LZManagementGroup -policyName Alerting-Storage
    .\patterns\alz\scripts\Start-AMBA-ALZ-Remediation.ps1 -managementGroupName $LZManagementGroup -policyName Alerting-HybridVM
    .\patterns\alz\scripts\Start-AMBA-ALZ-Remediation.ps1 -managementGroupName $LZManagementGroup -policyName Alerting-VM
    .\patterns\alz\scripts\Start-AMBA-ALZ-Remediation.ps1 -managementGroupName $LZManagementGroup -policyName Alerting-Web
#>

# The following SuppressMessageAttribute entries are used to suppress PSScriptAnalyzer tests against known exceptions as per:
# https://github.com/powershell/psscriptanalyzer#suppressing-rules
[Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSReviewUnusedParameter', '', Justification = 'False positive')]
[Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseDeclaredVarsMoreThanAssignments', '', Justification = 'False positive')]
[Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseApprovedVerbs', '', Justification = 'Approved verbs are not available for this scenario')]

Param(
    # [Parameter(Mandatory = $true)] [ValidateSet("AzureCloud", "AzureUSGovernment", "AzureChinaCloud", IgnoreCase = $true)] [string] $azureEnvironment,
    [Parameter(Mandatory = $true)] [string] $managementGroupName,
    [Parameter(Mandatory = $true)] [string] $policyName
)

#region general functions

# Function to trigger remediation for a single policy
Function Start-PolicyRemediation {
    Param(
        [Parameter(Mandatory = $true)] [string] $azureEnvironmentURI,
        [Parameter(Mandatory = $true)] [string] $managementGroupName,
        [Parameter(Mandatory = $true)] [string] $policyAssignmentName,
        [Parameter(Mandatory = $true)] [string] $policyAssignmentId,
        [Parameter(Mandatory = $false)] [string] $policyDefinitionReferenceId
    )
    $guid = New-Guid

    # Create remediation for the individual policy
    $uri = "https://$($azureEnvironmentURI)/providers/Microsoft.Management/managementGroups/$($managementGroupName)/providers/Microsoft.PolicyInsights/remediations/$($policyName)-$($guid)?api-version=2021-10-01"
    $body = @{
        properties = @{
            policyAssignmentId = "$policyAssignmentId"
        }
    }
    if ($policyDefinitionReferenceId) {
        $body.properties.policyDefinitionReferenceId = $policyDefinitionReferenceId
    }
    $body = $body | ConvertTo-Json -Depth 10
    Invoke-AzRestMethod -Uri $uri -Method PUT -Payload $body
}

#Function to get the policy assignments in the management group scope
function Get-PolicyType {
    Param (
        [Parameter(Mandatory = $true)] [string] $azureEnvironmentURI,
        [Parameter(Mandatory = $true)] [string] $managementGroupName,
        [Parameter(Mandatory = $true)] [string] $policyName
    )

    # Validate that the management group exists through the Azure REST API
    $uri = "https://$($azureEnvironmentURI)/providers/Microsoft.Management/managementGroups/$($managementGroupName)?api-version=2021-04-01"
    $result = (Invoke-AzRestMethod -Uri $uri -Method GET).Content | ConvertFrom-Json -Depth 100
    if ($result.error) {
        throw "Management group $managementGroupName does not exist, please specify a valid management group name"
    }

    # Getting custom policySetDefinitions
    $uri = "https://$($azureEnvironmentURI)/providers/Microsoft.Management/managementGroups/$($managementGroupName)/providers/Microsoft.Authorization/policySetDefinitions?&api-version=2023-04-01"
    $initiatives = (Invoke-AzRestMethod -Uri $uri -Method GET).Content | ConvertFrom-Json -Depth 100

    # Get policy assignments at management group scope
    $assignmentFound = $false
    $uri = "https://$($azureEnvironmentURI)/providers/Microsoft.Management/managementGroups/$($managementGroupName)/providers/Microsoft.Authorization/policyAssignments?`$filter=atScope()&api-version=2022-06-01"
    $result = (Invoke-AzRestMethod -Uri $uri -Method GET).Content | ConvertFrom-Json -Depth 100

    # Iterate through the policy assignments
    $result.value | ForEach-Object {

        #check if the policy assignment is for the specified policy set definition
        If ($($PSItem.properties.policyDefinitionId) -match "/providers/Microsoft.Authorization/policySetDefinitions/$policyName") {

            # Go to enumerating policy set
            $assignmentFound = $true
            Enumerate-PolicySet -azureEnvironmentURI $azureEnvironmentURI -managementGroupName $managementGroupName -policyAssignmentObject $PSItem
        }
        Elseif ($($PSItem.properties.policyDefinitionId) -match "/providers/Microsoft.Authorization/policyDefinitions/$policyName") {

            # Go to handling individual policy
            $assignmentFound = $true
            Enumerate-Policy -azureEnvironmentURI $azureEnvironmentURI -managementGroupName $managementGroupName -policyAssignmentObject $PSItem
        }
        Else {

            # Getting parent initiative for unassigned individual policies
            If ($initiatives) {
                $parentInitiative = $initiatives.value | Where-Object { ($_.properties.policyType -eq 'Custom') -and ($_.properties.metadata -like '*_deployed_by_amba*') } | Where-Object { $_.properties.policyDefinitions.policyDefinitionReferenceId -eq $policyname }

                # Getting the assignment of the parent initiative
                If ($parentInitiative) {
                    If ($($PSItem.properties.policyDefinitionId) -match "/providers/Microsoft.Authorization/policySetDefinitions/$($parentInitiative.name)") {

                        # Invoking policy remediation
                        $assignmentFound = $true
                        Start-PolicyRemediation -azureEnvironmentURI $azureEnvironmentURI -managementGroupName $managementGroupName -policyAssignmentName $PSItem.name -policyAssignmentId $PSItem.id -policyDefinitionReferenceId $policyName
                    }
                }
            }
        }
    }

    # If no policy assignments were found for the specified policy name, throw an error
    If (!$assignmentFound) {
        throw "No policy assignments found for policy $policyName at management group scope $managementGroupName"
    }
}

# Function to enumerate the policies in the policy set and trigger remediation for each individual policy
function Enumerate-PolicySet {
    param (
        [Parameter(Mandatory = $true)] [string] $azureEnvironmentURI,
        [Parameter(Mandatory = $true)] [string] $managementGroupName,
        [Parameter(Mandatory = $true)] [object] $policyAssignmentObject
    )

    # Extract policy assignment information
    $policyAssignmentObject
    $policyAssignmentId = $policyAssignmentObject.id
    $name = $policyAssignmentObject.name
    $policySetId = $policyAssignmentObject.properties.policyDefinitionId
    $policySetId
    $psetUri = "https://$($azureEnvironmentURI)$($policySetId)?api-version=2021-06-01"
    $policySet = (Invoke-AzRestMethod -Uri $psetUri -Method GET).Content | ConvertFrom-Json -Depth 100
    $policySet
    $policies = $policySet.properties.policyDefinitions

    # Iterate through the policies in the policy set
    If ($policyAssignmentObject.properties.policyDefinitionId -match "/providers/Microsoft.Authorization/policySetDefinitions/Alerting-ServiceHealth") {
        $policyDefinitionReferenceId = "Deploy_ServiceHealth_ActionGroups"
        Start-PolicyRemediation -azureEnvironmentURI $azureEnvironmentURI -managementGroupName $managementGroupName -policyAssignmentName $name -policyAssignmentId $policyAssignmentId -policyDefinitionReferenceId $policyDefinitionReferenceId
        Write-Host " Waiting for 5 minutes while remediating the 'Deploy Service Health Action Group' policy before continuing." -ForegroundColor Cyan
        Start-Sleep -Seconds 360
    }
    Foreach ($policy in $policies) {
        $policyDefinitionId = $policy.policyDefinitionId
        $policyDefinitionReferenceId = $policy.policyDefinitionReferenceId

        # Trigger remediation for the individual policy
        Start-PolicyRemediation -azureEnvironmentURI $azureEnvironmentURI -managementGroupName $managementGroupName -policyAssignmentName $name -policyAssignmentId $policyAssignmentId -policyDefinitionReferenceId $policyDefinitionReferenceId
    }
}

#Function to get specific information about a policy assignment for a single policy and trigger remediation
function Enumerate-Policy {
    param (
        [Parameter(Mandatory = $true)] [string] $azureEnvironmentURI,
        [Parameter(Mandatory = $true)] [string] $managementGroupName,
        [Parameter(Mandatory = $true)] [object] $policyAssignmentObject
    )

    # Extract policy assignment information
    $policyAssignmentId = $policyAssignmentObject.id
    $name = $policyAssignmentObject.name
    $policyDefinitionId = $policyAssignmentObject.properties.policyDefinitionId
    Start-PolicyRemediation -azureEnvironmentURI $azureEnvironmentURI -managementGroupName $managementGroupName -policyAssignmentName $name -policyAssignmentId $policyAssignmentId
}

#endregion

#Main script

# Checking for required module presence
If (-NOT(Get-Module -ListAvailable Az.Resources)) {
  Write-Warning "This script requires the Az.Resources module."

  $response = Read-Host "Would you like to install the 'Az.Resources' module now? (y/n)"
  If ($response -match '[yY]') { Install-Module Az.Resources -Scope CurrentUser }
}

# Assigning Azure environment URI to a fix value while leaving the code for Sovereign cloud in and commented
$azureEnvironmentURI = "management.azure.com"

# Leaving the following code implementation for Sovereign cloud in as commented in preparation for future supportability
<#
switch ($azureEnvironment) {
  "AzureCloud" {
    $azureEnvironmentURI = "management.azure.com"
  }

  "AzureUSGovernment" {
    $azureEnvironmentURI = "management.usgovcloudapi.net" # See API Endpoints for Azure US Government at https://learn.microsoft.com/en-us/azure/azure-government/compare-azure-government-global-azure#guidance-for-developers
  }

  "AzureChinaCloud" {
    $azureEnvironmentURI = "management.chinacloudapi.cn" # See API Endpoints for Azure China at https://learn.microsoft.com/en-us/azure/reliability/sovereign-cloud-china#azure-in-china-rest-endpoints
  }

  Default {azureEnvironmentURI = "management.azure.com"}
}
#>

Get-PolicyType -azureEnvironmentURI $azureEnvironmentURI -managementGroupName $managementGroupName -policyName $policyName
