# Connect Az account
Connect-AzAccount

# Variables
$mgId = "DG" # management group ID where the policy will be assigned
$mgSubId = "8a0e842c-dea4-4214-bb9e-44b30813ebb9" # management subscription to place automation account in
$location = "westeurope" # location for automation account (should be same as AMBA deployment later)
$automationAccountName = "p-amba-automations-weu-aa" # name for automation account
$resourceGroupName = "p-amba-automations-rg" # resource group for automation account
$tags = @{ "Owner"="Stefan.Olivesten@dellnergroup.com"; "department"="Group IT"; "project"="AMBA"; "environment"="prod"; "CreatedBy"="Kim Nordqvist"}
$runbookName = "AMBA-Register-Required-Resource-Providers"
$runbookContentPath = "C:\OnevinnADO\CodeLibrary\AzurePolicy\AMBA_Custom_code\DellnerGroup\runbooks\register_required_resourceProvider_by_AMBA_on_sub.ps1"
$azurePolicyDefinitionName = "Audit - AlertsManagement ResProvider on Subscriptions (AMBA)"
$azurePolicyDefinitionDisplayName = "Audit - AlertsManagement ResProvider on Subscriptions (AMBA)"
$azurePolicyAssignmentName = "Audit-subs-AMBA-prereqs"


# Build custom role definition as an object
$role = New-Object -TypeName Microsoft.Azure.Commands.Resources.Models.Authorization.PSRoleDefinition
$role.Name = 'AMBA Resource Provider Registration Operator'
$role.Description = 'Allows registering resource providers required by AMBA within subscriptions under this management group.'
$role.IsCustom = $true
$role.AssignableScopes = @("/providers/Microsoft.Management/managementGroups/DG")
$role.Actions = @(
    "Microsoft.AlertsManagement/register/action"
)

# Create custom RBAC role for resource provider registration
New-AzRoleDefinition -Role $role
# Verify custom role was created
Get-AzRoleDefinition -Name 'AMBA Resource Provider Registration Operator'
# Assign Tag Contributor role to the automation account's managed identity
$roleAssignment = New-AzRoleAssignment -ObjectId $principalId -RoleDefinitionName 'Tag Contributor' -Scope "/providers/Microsoft.Management/managementGroups/DG"
# Verify role assignment
Get-AzRoleAssignment -ObjectId $principalId | Where-Object { $_.RoleDefinitionName -eq 'Tag Contributor' }

### Start resource creation ###
# Set context to management subscription
Set-AzContext -SubscriptionId $mgSubId
#
# Create resource group if it does not exist
###
if (-not (Get-AzResourceGroup -Name $resourceGroupName -ErrorAction SilentlyContinue)) {
    New-AzResourceGroup -Name $resourceGroupName -Location $location -Tag $tags
}
###
# Create Automation Account with Managed Identity enabled if it does not exist
###
if (Get-AzAutomationAccount -ResourceGroupName $resourceGroupName -Name $automationAccountName -ErrorAction SilentlyContinue) {
    Write-Output "Automation Account $automationAccountName already exists in resource group $resourceGroupName."
    $automationAccount = Get-AzAutomationAccount -ResourceGroupName $resourceGroupName -Name $automationAccountName
} else {
    Write-Output "Creating Automation Account $($automationAccountName) in resource group $($resourceGroupName)."
    $automationAccount = New-AzAutomationAccount -ResourceGroupName $resourceGroupName -Name $automationAccountName -Location $location -Tag $tags -AssignSystemIdentity
    Write-Output "Automation Account $($automationAccountName) created successfully."
}
# Fetch automation account
$automationAccount = Get-AzAutomationAccount -ResourceGroupName $resourceGroupName -Name $automationAccountName -ErrorAction SilentlyContinue
$automationAccount
## Fetch automation account resource id
$automationAccountResource = get-azresource -ResourceGroupName $resourceGroupName -ResourceType "Microsoft.Automation/automationAccounts" -ResourceName $automationAccountName
$automationAccountResource.ResourceId

# Get the principal ID of the managed identity
$principalId = $automationAccount.Identity.PrincipalId
$principalId
# Assign custom RBAC role to the automation account's managed identity
$roleAssignment = New-AzRoleAssignment -ObjectId $principalId -RoleDefinitionName 'AMBA Resource Provider Registration Operator' -Scope "/providers/Microsoft.Management/managementGroups/DG"
# Verify role assignment
Get-AzRoleAssignment -ObjectId $principalId | Where-Object { $_.RoleDefinitionName -eq 'AMBA Resource Provider Registration Operator' }
###
# Create runbook if it does not exist
###
if (Get-AzAutomationRunbook -ResourceGroupName $resourceGroupName -AutomationAccountName $automationAccountName -Name $runbookName -ErrorAction SilentlyContinue) {
    Write-Output "Runbook $($runbookName) already exists in Automation Account $($automationAccountName)."
} else {
    Write-Output "Creating runbook $($runbookName) in Automation Account $($automationAccountName)."
    # Import script content into the runbook
    Import-AzAutomationRunbook -AutomationAccountName $AutomationAccountName -ResourceGroupName $ResourceGroupName -Name $runbookName -Type PowerShell72 -Path $RunbookContentPath -Description "Registers Microsoft.AlertsManagement resource provider in all subscriptions."
    Write-Output "Script content imported into runbook $($runbookName) successfully."

    # Publish the runbook
    Publish-AzAutomationRunbook -ResourceGroupName $resourceGroupName -AutomationAccountName $automationAccountName -Name $runbookName
    Write-Output "Runbook $($runbookName) published successfully."
}
# Verify runbook
Get-AzAutomationRunbook `
    -AutomationAccountName $AutomationAccountName `
    -ResourceGroupName $ResourceGroupName `
    | Select-Object Name, State, LastModifiedTime
###
# Create schedule in automation account if it does not exist
###
$scheduleName = "Weekdays at 3AM UTC"
$schedule = Get-AzAutomationSchedule -ResourceGroupName $resourceGroupName -AutomationAccountName $automationAccountName -Name $scheduleName -ErrorAction SilentlyContinue
if (-not $schedule) {
    $StartTime = (Get-Date "05:00:00").AddDays(1)
    [System.DayOfWeek[]]$WeekDays = @([System.DayOfWeek]::Monday..[System.DayOfWeek]::Friday)
    $schedule = New-AzAutomationSchedule -ResourceGroupName $resourceGroupName -AutomationAccountName $automationAccountName -Name $scheduleName -StartTime $StartTime -WeekInterval 1 -DaysOfWeek $WeekDays -TimeZone 'UTC' -Description "Runs every weekday at 6AM UTC"
    Write-Output "Schedule $($scheduleName) created successfully."
} else {
    Write-Output "Schedule $($scheduleName) already exists in Automation Account $($automationAccountName)."
}
###
# Link runbook to schedule if not already linked
###
$jobSchedule = Get-AzAutomationScheduledRunbook -ResourceGroupName $resourceGroupName -AutomationAccountName $automationAccountName -RunbookName $runbookName -ErrorAction SilentlyContinue
if (-not $jobSchedule) {
    $jobSchedule = Register-AzAutomationScheduledRunbook -ResourceGroupName $resourceGroupName -AutomationAccountName $automationAccountName -RunbookName $runbookName -ScheduleName $scheduleName -Parameters @{"TriggerAlertRule" = $true}
    Write-Output "Runbook $($runbookName) linked to schedule $($scheduleName) successfully."
} else {
    Write-Output "Runbook $($runbookName) is already linked to a schedule in Automation Account $($automationAccountName)."
}
###
# Create azure policy definition to trigger the runbook if the resource provider is not registered
###

# Create policy definition JSON file
$policyDefinition = @"
{
  "properties": {
    "displayName": "Audit subscriptions missing AMBAenabled tag",
    "policyType": "Custom",
    "mode": "All",
    "description": "Audits all subscriptions that do not have the tag 'AMBAenabled' set to 'yes'. These subscriptions are missing prerequisites for AMBA. An automation runbook called 'AMBA-Register-Required-Resource-Providers' is used to ensure that new subscriptions have the required resource provider registered.",
    "metadata": {
      "category": "Monitoring"
    },
    "parameters": {},
    "policyRule": {
      "if": {
        "allOf": [
          {
            "field": "type",
            "equals": "Microsoft.Resources/subscriptions"
          },
          {
            "anyOf": [
              {
                "field": "tags.AMBAenabled",
                "exists": "false"
              },
              {
                "field": "tags.AMBAenabled",
                "notEquals": "yes"
              }
            ]
          }
        ]
      },
      "then": {
        "effect": "audit"
      }
    }
  }
}
"@

# Create policy definition from JSON
$definition = New-AzPolicyDefinition -Name $azurePolicyDefinitionName -DisplayName $azurePolicyDefinitionDisplayName -Policy $policyDefinition -Mode All -ManagementGroupName $($mgId)
# Verify policy definition
Get-AzPolicyDefinition -Name $azurePolicyDefinitionName
# Assign policy definition to management group scope
$assignment = New-AzPolicyAssignment -Name $azurePolicyAssignmentName -PolicyDefinition $definition -Scope "/providers/Microsoft.Management/managementGroups/$($mgId)"
# Verify policy assignment
Get-AzPolicyAssignment -Name $azurePolicyAssignmentName -Scope "/providers/Microsoft.Management/managementGroups/$($mgId)"





