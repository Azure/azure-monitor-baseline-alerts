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
  .NOTES
    AUTHORS:  Bruno Gabrielli
    LASTEDIT: September 24th, 2025

  .VERSION
    - VERSION: 1.0 // September 24th, 2025
    - Initial version of the script

  .DESCRIPTION
    This script is inteded to generate a version of the AMBA-ALZ pattern that can be deployed at subscription level.
    It takes care of the following tasks
    - copies the following templates that do not require modifications:
      - resourceGroups.json
      - userAssignedManagedIdentities.json

    - modifies the following AMBA-ALZ files to be used in an Azure Lighthouse scenario where companies, Cloud Solution Provider do not have access to the Management Group Level.
      - Policy Assignments
      - Policy Definitions
      - Policy Set Definitions
      - Main Arm Template
      - Parameter File

#>

# Setting variables
$policyAssignmenstFilePath = ".\patterns\alz\policyAssignments"
$policyDefinitionsFilePath = ".\patterns\alz\policyDefinitions"
$policySetDefinitionsFilePath = ".\patterns\alz\policySetDefinitions"
$armTemplateFilePath = ".\patterns\alz\alzArm.json"
$parameterFilePath = ".\patterns\alz\alzArm.param.json"
$templateFilePath = ".\patterns\alz\templates"

$alzForSubsFilesPath = ".\patterns\alzForSubscriptions\"
$alzForSubsTemplateFileName = "alzArmForSubscriptions.json"
$alzForSubsParamFileName = "alzArmForSubscriptions.param.json"

#region Copy templates
copy-item -Path "$templateFilePath\resourceGroup.json" -Destination "$alzForSubsFilesPath\templates\resourceGroup.json" -force
copy-item -Path "$templateFilePath\userAssignedManagedIdentity.json" -Destination "$alzForSubsFilesPath\templates\userAssignedManagedIdentity.json" -force
#endregion

#region Policy Assignments

# Define a hashtable of replacements
$replacements = @{
  '2019-08-01/managementGroupDeploymentTemplate'           = '2018-05-01/subscriptionDeploymentTemplate'
  'topLevelManagementGroupPrefix'                          = 'topLevelSubscriptionId'
  'providers/Microsoft.Management/managementGroups'        = 'subscriptions'
  'ESLZ prefix to your intermediate root management group' = 'subscription'
  'tenantResourceId'                                       = 'concat'
}

# Loading, modifying and saving policy assignemnts
$policyAssignmenstFiles = Get-ChildItem -Path $policyAssignmenstFilePath -Filter *.json
foreach ($file in $policyAssignmenstFiles) {
  $fileContent = Get-Content -Path $file.FullName -Raw
  foreach ($key in $replacements.Keys) {
    $fileContent = $fileContent -replace "\b$key\b", $replacements[$key]
  }

  $fileContent | Set-Content -Path "$alzForSubsFilesPath/policyAssignments/$($file.Name)" -Force

  # Reopening the saved file to change variable and condition and to remove scope
  $fileContent2 = Get-Content -Path "$alzForSubsFilesPath/policyAssignments/$($file.Name)" -raw | ConvertFrom-Json

  $fileContent2.variables | ForEach-Object {
    if ($_.roleAssignmentNames -match "roleAssignmentNameManagedIdentityOperator") {
      $_.roleAssignmentNames.roleAssignmentNameManagedIdentityOperator = $_.roleAssignmentNames.roleAssignmentNameManagedIdentityOperator -replace "'-1'", "'-MI-'"
    }
  }

  # Changing variable value for Managed Identity Contributor role assignment
  # Changing Conditions and Removing Scope for Managed Identity Contributor role assignment
  $fileContent2.resources | ForEach-Object {
    if (($_.type -eq "Microsoft.Authorization/roleAssignments") -and ($_.name -like "*variables('roleAssignmentNames').roleAssignmentNameManagedIdentityOperator*")) {
      #$_.condition = "[equals(parameters('bringYourOwnUserAssignedManagedIdentity'), 'No')]"
      $_.PSObject.Properties.Remove("scope")
    }
  }
  $fileContent2 | ConvertTo-Json -Depth 10 | Set-Content -Path "$alzForSubsFilesPath/policyAssignments/$($file.Name)" -Force

}

#endregion

#region Policy Definitions

# Define a hashtable of replacements
$replacements = @{
  '2019-08-01/managementGroupDeploymentTemplate'            = '2018-05-01/subscriptionDeploymentTemplate'
  'topLevelManagementGroupPrefix'                           = 'topLevelSubscriptionId'
  'tenantResourceId'                                        = 'concat'
  'providers/Microsoft.Management/managementGroups/contoso' = 'subscriptions/00000000-0000-0000-0000-000000000000'
}

$replacements2 = @{
  'Microsoft.Management/managementGroups' = '/subscriptions/'
}

# Loading, modifying and saving policy definitions
$policyDefinitionsFiles = Get-ChildItem -Path $policyDefinitionsFilePath -Filter *.json
foreach ($file in $policyDefinitionsFiles) {
  $fileContent = Get-Content -Path $file.FullName -Raw

  foreach ($key in $replacements.Keys) {
    $fileContent = $fileContent -replace "\b$key\b", $replacements[$key]
  }
  $fileContent | Set-Content -Path "$alzForSubsFilesPath/policyDefinitions/$($file.Name)" -Force

  foreach ($key2 in $replacements2.Keys) {
    $fileContent = $fileContent -replace "\b$key2\b", $replacements2[$key2]
  }
  $fileContent | Set-Content -Path "$alzForSubsFilesPath/policyDefinitions/$($file.Name)" -Force
}

#endregion

#region PolicySet Definitions

# Define a hashtable of replacements
$replacements = @{
  'Microsoft.Management/managementGroups/contoso' = 'Microsoft.Subscription/subscriptions/00000000-0000-0000-0000-000000000000'
}

# Loading, modifying and saving policySet definitions
$policySetDefinitionsFiles = Get-ChildItem -Path $policySetDefinitionsFilePath -Filter *.json
foreach ($file in $policySetDefinitionsFiles) {
  $fileContent = Get-Content -Path $file.FullName -Raw
  foreach ($key in $replacements.Keys) {
    $fileContent = $fileContent -replace "\b$key\b", $replacements[$key]
  }
  $fileContent | Set-Content -Path "$alzForSubsFilesPath/policySetDefinitions/$($file.Name)" -Force
}

#endregion

#region main Arm template

# Define a hashtable of unnecessary parameters to be removed
$parametersToRemove = @(
  "managementSubscriptionId",
  "platformManagementGroup",
  "IdentityManagementGroup",
  "managementManagementGroup",
  "connectivityManagementGroup",
  "LandingZoneManagementGroup"
)

# Removing unnecessary parameters
$mainArmTemporaryContent = Get-Content -Path $armTemplateFilePath -Raw | ConvertFrom-Json
foreach ($param in $parametersToRemove) {
  $mainArmTemporaryContent.parameters.PSObject.Properties.Remove($param)
}

# Removing scope from deployment of policy definitions, policy set definitions and policy assignments
$mainArmTemporaryContent.resources | ForEach-Object {
  if (($_.type -eq "Microsoft.Resources/deployments") -and (($_.name -like "*variables('deploymentNames').policyDefinitions*") -or ($_.name -like "*variables('deploymentNames').policySetDefinitionsDeploymentName*") -or ( $_.name -like "*variables('deploymentNames').AMBA*"))) {
    $_.PSObject.Properties.Remove("scope")
  }
}

$mainArmTemporaryContent | ConvertTo-Json -Depth 10 | Set-Content -Path "$alzForSubsFilesPath/$alzForSubsTemplateFileName" -Force

# Define a hashtable of replacements
$replacements = @{
  '2019-08-01/managementGroupDeploymentTemplate'                                                                                          = '2018-05-01/subscriptionDeploymentTemplate'
  'enterpriseScaleCompanyPrefix'                                                                                                          = 'topLevelSubscriptionId'
  'managementSubscriptionId'                                                                                                              = 'topLevelSubscriptionId'
  'Microsoft.Management/managementGroups'                                                                                                 = 'Microsoft.Subscription/subscriptions'
  'Provide a prefix (unique at tenant-scope) for the Management Group hierarchy and other resources created as part of Enterprise-scale.' = 'Provide a subscription ID'
  'connectivityManagementGroup'                                                                                                           = 'topLevelSubscriptionId'
  'identityManagementGroup'                                                                                                               = 'topLevelSubscriptionId'
  'managementManagementGroup'                                                                                                             = 'topLevelSubscriptionId'
  'LandingZoneManagementGroup'                                                                                                            = 'topLevelSubscriptionId'
  'platformManagementGroup'                                                                                                               = 'topLevelSubscriptionId'
  'topLevelManagementGroupPrefix'                                                                                                         = 'topLevelSubscriptionId'
}

# replacing strings
$mainArmTemplateContent = Get-Content -Path "$alzForSubsFilesPath/$alzForSubsTemplateFileName" -Raw
foreach ($key in $replacements.Keys) {
  $mainArmTemplateContent = $mainArmTemplateContent -replace "\b$key\b", $replacements[$key]
}
$mainArmTemplateContent | Set-Content -Path "$alzForSubsFilesPath/$alzForSubsTemplateFileName" -Force

#endregion

#region Parameter file

# Define a hashtable of unnecessary parameters to be removed
$parametersToRemove = @(
  "managementSubscriptionId",
  "platformManagementGroup",
  "IdentityManagementGroup",
  "managementManagementGroup",
  "connectivityManagementGroup",
  "LandingZoneManagementGroup"
)

# removing unnecessary parameters
$paramFileTemporaryContent = Get-Content -Path $parameterFilePath -Raw | ConvertFrom-Json
foreach ($param in $parametersToRemove) {
  $paramFileTemporaryContent.parameters.PSObject.Properties.Remove($param)
}
$paramFileTemporaryContent | ConvertTo-Json -Depth 10 | Set-Content -Path "$alzForSubsFilesPath/$alzForSubsParamFileName" -Force

# Define a hashtable of replacements
$replacements = @{
  'enterpriseScaleCompanyPrefix' = 'topLevelSubscriptionId'
  'managementSubscriptionId'     = 'topLevelSubscriptionId'
  'contoso'                      = '00000000-0000-0000-0000-000000000000'
}

# replacing strings
$mainArmTemplateContent = Get-Content -Path "$alzForSubsFilesPath/$alzForSubsParamFileName" -Raw
foreach ($key in $replacements.Keys) {
  $mainArmTemplateContent = $mainArmTemplateContent -replace "\b$key\b", $replacements[$key]
}
$mainArmTemplateContent | Set-Content -Path "$alzForSubsFilesPath/$alzForSubsParamFileName" -Force

#endregion
