<# This script:
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

$lighthouseFilesPath = ".\patterns\alz\lighthouse\"

#region Copy templates
copy-item -Path "$templateFilePath\resourceGroup.json" -Destination "$lighthouseFilesPath\templates\resourceGroup.json" -force
copy-item -Path "$templateFilePath\userAssignedManagedIdentity.json" -Destination "$lighthouseFilesPath\templates\userAssignedManagedIdentity.json" -force
#endregion

#region Policy Assignments

# Define a hashtable of replacements
$replacements = @{
  '2019-08-01/managementGroupDeploymentTemplate' = '2018-05-01/subscriptionDeploymentTemplate'
  'topLevelManagementGroupPrefix' = 'topLevelSubscriptionId'
  'providers/Microsoft.Management/managementGroups' = 'subscriptions'
  'ESLZ prefix to your intermediate root management group' = 'subscription'
}

# Loading, modifying and saving policy assignemnts
$policyAssignmenstFiles = Get-ChildItem -Path $policyAssignmenstFilePath -Filter *.json
foreach ($file in $policyAssignmenstFiles) {
  $fileContent = Get-Content -Path $file.FullName -Raw
  foreach ($key in $replacements.Keys) {
    $fileContent = $fileContent -replace "\b$key\b", $replacements[$key]
  }
  $fileContent | Set-Content -Path "$lighthouseFilesPath/policyAssignments/$($file.Name)" -Force
}

#endregion

#region Policy Definitions

# Define a hashtable of replacements
$replacements = @{
  '2019-08-01/managementGroupDeploymentTemplate' = '2018-05-01/subscriptionDeploymentTemplate'
  'topLevelManagementGroupPrefix' = 'topLevelSubscriptionId'
  'tenantResourceId'= 'concat'
  #'Provide a prefix (unique at tenant-scope) for the Management Group hierarchy and other resources created as part of an Azure landing zone. DEFAULT VALUE = \"alz\"' = 'Provide a subscription ID'
  #'/providers/Microsoft.Management/managementGroups/contoso/providers/' = '/subscriptions/00000000-0000-0000-0000-000000000000/providers/'
  'providers/Microsoft.Management/managementGroups/contoso'= 'subscriptions/00000000-0000-0000-0000-000000000000'
  #'contoso' = '00000000-0000-0000-0000-000000000000'
  #'alz' = '00000000-0000-0000-0000-000000000000'
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
    $fileContent | Set-Content -Path "$lighthouseFilesPath/policyDefinitions/$($file.Name)" -Force

    foreach ($key2 in $replacements2.Keys) {
      $fileContent = $fileContent -replace "\b$key2\b", $replacements2[$key2]
    }
    $fileContent | Set-Content -Path "$lighthouseFilesPath/policyDefinitions/$($file.Name)" -Force
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
    $fileContent | Set-Content -Path "$lighthouseFilesPath/policySetDefinitions/$($file.Name)" -Force
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

  # removing unnecessary parameters
  $mainArmTemporaryContent = Get-Content -Path $armTemplateFilePath -Raw | ConvertFrom-Json
  foreach ($param in $parametersToRemove) {
    $mainArmTemporaryContent.parameters.PSObject.Properties.Remove($param)
  }

  $mainArmTemporaryContent.resources | ForEach-Object {
    if (($_.type -eq "Microsoft.Resources/deployments") -and (($_.name -like "*variables('deploymentNames').policyDefinitions*") -or ($_.name -like "*variables('deploymentNames').policySetDefinitionsDeploymentName*"))) {
      $_.PSObject.Properties.Remove("scope")
    }
  }

  $mainArmTemporaryContent | ConvertTo-Json -Depth 10 | Set-Content -Path "$lighthouseFilesPath/alzArmLighthouse.json" -Force

  # Define a hashtable of replacements
  $replacements = @{
    'managementGroupDeploymentTemplate'                                                                                                     = 'subscriptionDeploymentTemplate'
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
  $mainArmTemplateContent = Get-Content -Path "$lighthouseFilesPath/alzArmLighthouse.json" -Raw
  foreach ($key in $replacements.Keys) {
    $mainArmTemplateContent = $mainArmTemplateContent -replace "\b$key\b", $replacements[$key]
  }
  $mainArmTemplateContent | Set-Content -Path "$lighthouseFilesPath/alzArmLighthouse.json" -Force

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
  $paramFileTemporaryContent | ConvertTo-Json -Depth 10 | Set-Content -Path "$lighthouseFilesPath/alzArmLighthouse.param.json" -Force

  # Define a hashtable of replacements
  $replacements = @{
    'enterpriseScaleCompanyPrefix' = 'topLevelSubscriptionId'
    'managementSubscriptionId'     = 'topLevelSubscriptionId'
    'contoso'                      = '00000000-0000-0000-0000-000000000000'
  }

  # replacing strings
  $mainArmTemplateContent = Get-Content -Path "$lighthouseFilesPath/alzArmLighthouse.param.json" -Raw
  foreach ($key in $replacements.Keys) {
    $mainArmTemplateContent = $mainArmTemplateContent -replace "\b$key\b", $replacements[$key]
  }
  $mainArmTemplateContent | Set-Content -Path "$lighthouseFilesPath/alzArmLighthouse.param.json" -Force

#endregion
