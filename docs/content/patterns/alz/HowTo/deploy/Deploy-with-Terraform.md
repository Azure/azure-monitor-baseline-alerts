---
title: Deploy with Terraform
weight: 75
---

### On this page

> [Modules](../Deploy-with-Terraform#Modules) </br>
> [Features `avm-ptn-monitoring-amba-alz` module](../Deploy-with-Terraform#Features-avm-ptn-monitoring-amba-alz-module) </br>
> [Features `avm-ptn-alz` module](../Deploy-with-Terraform#Features-avm-ptn-alz-module) </br>
> [AzAPI Provider](../Deploy-with-Terraform#AzAPI-Provider) </br>
> [Required Inputs](../Deploy-with-Terraform#Required-Inputs) </br>
> [Optional Inputs](../Deploy-with-Terraform#Optional-Inputs) </br>
> [Outputs](../Deploy-with-Terraform#Outputs) </br>
> [Requirements](../Deploy-with-Terraform#Requirements) </br>
> [Example - Deploying AMBA ALZ](../Deploy-with-Terraform#Example-Deploying-AMBA-ALZ) </br>
> [Example - Deploying a Custom Architecture](../Deploy-with-Terraform#Example-Deploying-a-Custom-Architecture) </br>
> [Data Collection](../Deploy-with-Terraform#Data-Collection) </br>
> [Next Steps](../Deploy-with-Terraform#Next-Steps) </br>

## Modules

For a complete deployment of the AMBA ALZ pattern you will need the following 2 modules:

### <a name="module_avm_ptn_alz"></a> [avm\_ptn\_alz](#module\_avm\_ptn\_alz)

Source: Azure/avm-ptn-alz/azurerm

Version: 0.11.0

Terraform registry: [avm-ptn-alz](https://registry.terraform.io/modules/Azure/avm-ptn-alz/azurerm/latest)

### <a name="module_avm_ptn_monitoring_amba_alz"></a> [avm\_ptn\_monitoring\_amba\_alz](#module\_avm\_ptn\_monitoring\_amba\_alz)

Source: Azure/avm-ptn-monitoring-amba-alz/azurerm

Version: 0.1.1

Terraform registry: [avm-ptn-monitoring-amba-alz](https://registry.terraform.io/modules/Azure/avm-ptn-monitoring-amba-alz/azurerm/latest)

{{< hint type=note >}}
Additionally, the "avm-ptn-monitoring-amba-alz" module calls the following resource modules:

- #### <a name="module_resource_group"></a> [resource\_group](#module\_resource\_group)

  Source: Azure/avm-res-resources-resourcegroup/azurerm

  Version: 0.2.1

- #### <a name="module_user_assigned_managed_identity"></a> [user\_assigned\_managed\_identity](#module\_user\_assigned\_managed\_identity)

  Source: Azure/avm-res-managedidentity-userassignedidentity/azurerm

  Version: 0.3.3

{{< /hint >}}

## Features avm-ptn-monitoring-amba-alz module

- Deployment of Resource Group.
- Deployment of User Assigned Managed Identity.
- Deployment of Monitoring Reader Role Assignment for the User Assigned Managed Identity.

## Features avm-ptn-alz module

In the context of deploying AMBA ALZ, the following features are used:

- Deploy policy assets (definitions, assignments, and initiatives) according to the supplied architecture and associated archetypes
- Modify policy assignments:
  - Enforcement mode
  - Identity
  - Non-compliance messages
  - Overrides
  - Parameters
  - Resource selectors
- Create the required role assignments for Azure Policy, including support for the **assign permissions** metadata tag, just like the Azure Portal

## AzAPI Provider

We use the AzAPI provider to interact with the Azure APIs.
The new features allow us to be more efficient and reliable, with orders of magnitude speed improvements and retry logic for transient errors.

<!-- markdownlint-disable MD013 -->
## Required Inputs

The following input variables are required:

### <a name="input_location"></a> [location](#input\_location)

Description: Azure region where the resource should be deployed.

Type: `string`

### <a name="input_root_management_group_name"></a> [root\_management\_group\_name](#input\_root\_management\_group\_name)

Description: The name (ID) of the management group.

Type: `string`

## Optional Inputs

The following input variables are optional (have default values):

### <a name="input_description"></a> [description](#input\_description)

Description: The description used for the role assignment to identify the resource as deployed by AMBA.

Type: `string`

Default: `"_deployed_by_amba"`

### <a name="input_enable_telemetry"></a> [enable\_telemetry](#input\_enable\_telemetry)

Description: This variable controls whether or not telemetry is enabled for the module.
For more information see <https://aka.ms/avm/telemetryinfo>.
If it is set to false, then no telemetry will be collected.

Type: `bool`

Default: `true`

### <a name="input_lock"></a> [lock](#input\_lock)

Description: Controls the Resource Lock configuration for this resource. The following properties can be specified:

- `kind` - (Required) The type of lock. Possible values are `\"CanNotDelete\"` and `\"ReadOnly\"`.
- `name` - (Optional) The name of the lock. If not specified, a name will be generated based on the `kind` value. Changing this forces the creation of a new resource.

Type:

```hcl
object({
    kind = string
    name = optional(string, null)
  })
```

Default: `null`

### <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name)

Description: The resource group where the resources will be deployed.

Type: `string`

Default: `"rg-amba-monitoring-001"`

### <a name="input_retries"></a> [retries](#input\_retries)

Description: The retry settings to apply to the CRUD operations. Value is a nested object, the top level keys are the resources and the values are an object with the following attributes:

- `error_message_regex` - (Optional) A list of error message regexes to retry on. Defaults to `null`, which will will disable retries. Specify a value to enable.
- `interval_seconds` - (Optional) The initial interval in seconds between retries. Defaults to `null` and will fall back to the provider default value.
- `max_interval_seconds` - (Optional) The maximum interval in seconds between retries. Defaults to `null` and will fall back to the provider default value.
- `multiplier` - (Optional) The multiplier to apply to the interval between retries. Defaults to `null` and will fall back to the provider default value.
- `randomization_factor` - (Optional) The randomization factor to apply to the interval between retries. Defaults to `null` and will fall back to the provider default value.

For more information please see the provider documentation here: <https://registry.terraform.io/providers/Azure/azapi/azurerm/latest/docs/resources/resource#nestedatt--retry>

Type:

```hcl
object({
    role_assignments = optional(object({
      error_message_regex = optional(list(string), [
        "AuthorizationFailed", # Avoids a eventual consistency issue where a recently created management group is not yet available for a GET operation.
        "ResourceNotFound",    # If the resource has just been created, retry until it is available.
      ])
      interval_seconds     = optional(number, null)
      max_interval_seconds = optional(number, null)
      multiplier           = optional(number, null)
      randomization_factor = optional(number, null)
    }), {})
  })
```

Default: `{}`

### <a name="input_role_assignments"></a> [role\_assignments](#input\_role\_assignments)

Description: A map of role assignments to create on this resource. The map key is deliberately arbitrary to avoid issues where map keys maybe unknown at plan time.

- `role_definition_id_or_name` - The ID or name of the role definition to assign to the principal.
- `principal_id` - The ID of the principal to assign the role to.
- `description` - The description of the role assignment.
- `skip_service_principal_aad_check` - If set to true, skips the Azure Active Directory check for the service principal in the tenant. Defaults to false.
- `condition` - The condition which will be used to scope the role assignment.
- `condition_version` - The version of the condition syntax. Valid values are '2.0'.

> Note: only set `skip_service_principal_aad_check` to true if you are assigning a role to a service principal.

Type:

```hcl
map(object({
    role_definition_id_or_name             = string
    principal_id                           = string
    description                            = optional(string, null)
    skip_service_principal_aad_check       = optional(bool, false)
    condition                              = optional(string, null)
    condition_version                      = optional(string, null)
    delegated_managed_identity_resource_id = optional(string, null)
    principal_type                         = optional(string, null)
  }))
```

Default: `{}`

### <a name="input_role_definition_id"></a> [role\_definition\_id](#input\_role\_definition\_id)

Description: The role definition ID to assign to the User Assigned Managed Identity. Defaults to Monitoring Reader.

Type: `string`

Default: `"43d0d8ad-25c7-4714-9337-8ba259a9fe05"`

### <a name="input_tags"></a> [tags](#input\_tags)

Description: (Optional) Tags of the resource.

Type: `map(string)`

Default: `null`

### <a name="input_timeouts"></a> [timeouts](#input\_timeouts)

Description: A map of timeouts to apply to the creation and destruction of resources.
If using retry, the maximum elapsed retry time is governed by this value.

The object has attributes for each resource type, with the following optional attributes:

- `create` - (Optional) The timeout for creating the resource. Defaults to `5m` apart from policy assignments, where this is set to `15m`.
- `delete` - (Optional) The timeout for deleting the resource. Defaults to `5m`.
- `update` - (Optional) The timeout for updating the resource. Defaults to `5m`.
- `read` - (Optional) The timeout for reading the resource. Defaults to `5m`.

Each time duration is parsed using this function: <https://pkg.go.dev/time#ParseDuration>.

Type:

```hcl
object({
    role_assignment = optional(object({
      create = optional(string, "5m")
      delete = optional(string, "5m")
      update = optional(string, "5m")
      read   = optional(string, "5m")
      }), {}
    )
  })
```

Default: `{}`

### <a name="input_user_assigned_managed_identity_name"></a> [user\_assigned\_managed\_identity\_name](#input\_user\_assigned\_managed\_identity\_name)

Description: The name of the user-assigned managed identity.

Type: `string`

Default: `"id-amba-prod-001"`

## Outputs

The following outputs are exported:

### <a name="output_resource_group_name"></a> [resource\_group\_name](#output\_resource\_group\_name)

Description: The resource group name

### <a name="output_resource_id"></a> [resource\_id](#output\_resource\_id)

Description: The resource id of the resource group

### <a name="output_user_assigned_managed_identity_name"></a> [user\_assigned\_managed\_identity\_name](#output\_user\_assigned\_managed\_identity\_name)

Description: The user assigned managed identity name

### <a name="output_user_assigned_managed_identity_resource_id"></a> [user\_assigned\_managed\_identity\_resource\_id](#output\_user\_assigned\_managed\_identity\_resource\_id)

Description: The resource id of the user assigned managed identity

## Requirements

The following requirements are needed by this module:

- <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) (~> 1.9)

- <a name="requirement_alz"></a> [alz](#requirement\_alz) (~> 0.17.4)

- <a name="requirement_azapi"></a> [azapi](#requirement\_azapi) (~> 2.2)

- <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) (~> 4.0)

## Example - Deploying AMBA ALZ

This example demonstrates how to deploy the AMBA ALZ pattern using an existing management group hierarchy with default naming as used in the ALZ reference architecture. It shows how to use the variables to customize the deployment.

```hcl
data "azapi_client_config" "current" {}

provider "alz" {
  library_references = [{
    path = "platform/amba"
    ref  = "2025.04.0"
  }]
}

provider "azurerm" {
  alias           = "management"
  subscription_id = var.management_subscription_id != "" ? var.management_subscription_id : data.azapi_client_config.current.subscription_id
  features {}
}

variable "management_subscription_id" {
  description = "Management subscription ID"
  type        = string
  default     = ""
}

variable "location" {
  description = "Location"
  type        = string
  default     = "swedencentral"
}

variable "resource_group_name" {
  type        = string
  default     = "rg-amba-monitoring-001"
  description = "The resource group where the resources will be deployed."
}

variable "user_assigned_managed_identity_name" {
  type        = string
  default     = "id-amba-prod-001"
  description = "The name of the user-assigned managed identity."
}

variable "bring_your_own_user_assigned_managed_identity" {
  type        = bool
  default     = false
  description = "Flag to indicate if the user-assigned managed identity is provided by the user."
}

variable "bring_your_own_user_assigned_managed_identity_resource_id" {
  type        = string
  default     = ""
  description = "The resource ID of the user-assigned managed identity."
}

variable "action_group_email" {
  description = "Action group email"
  type        = list(string)
  default     = []
}

variable "action_group_arm_role_id" {
  description = "Action group ARM role ID"
  type        = list(string)
  default     = []
}

variable "logic_app_resource_id" {
  type        = string
  default     = ""
  description = "The resource ID of the logic app."
}

variable "logic_app_callback_url" {
  type        = string
  default     = ""
  description = "The callback URL of the logic app."
}

variable "event_hub_resource_id" {
  type        = list(string)
  default     = []
  description = "The resource ID of the event hub."
}

variable "webhook_service_uri" {
  type        = list(string)
  default     = []
  description = "The service URI of the webhook."
}

variable "function_resource_id" {
  type        = string
  default     = ""
  description = "The resource ID of the Azure function."
}

variable "function_trigger_uri" {
  type        = string
  default     = ""
  description = "The trigger URI of the Azure function."
}

variable "bring_your_own_alert_processing_rule_resource_id" {
  type        = string
  default     = ""
  description = "The resource id of the alert processing rule, required if you intend to use an existing alert processing rule for monitoring purposes."
}

variable "bring_your_own_action_group_resource_id" {
  type        = list(string)
  default     = []
  description = "The resource id of the action group, required if you intend to use an existing action group for monitoring purposes."
}

variable "amba_disable_tag_name" {
  type        = string
  default     = "MonitorDisable"
  description = "Tag name used to disable monitoring at the resource level."
}

variable "amba_disable_tag_values" {
  type        = list(string)
  default     = ["true", "Test", "Dev", "Sandbox"]
  description = "Tag value(s) used to disable monitoring at the resource level."
}

variable "tags" {
  type = map(string)
  default = {
    _deployed_by_amba = "True"
  }
  description = "(Optional) Tags of the resource."
}

locals {
  root_management_group_name = "alz"
}

module "amba_alz" {
  source  = "Azure/avm-ptn-monitoring-amba-alz/azurerm"
  version = "0.1.1"
  providers = {
    azurerm = azurerm.management
  }
  location                            = var.location
  root_management_group_name          = local.root_management_group_name
  resource_group_name                 = var.resource_group_name
  user_assigned_managed_identity_name = var.user_assigned_managed_identity_name

  count = var.bring_your_own_user_assigned_managed_identity ? 0 : 1
}

module "amba_policy" {
  source             = "Azure/avm-ptn-alz/azurerm"
  version            = "0.11.0"
  architecture_name  = "amba"
  location           = var.location
  parent_resource_id = data.azapi_client_config.current.tenant_id
  policy_default_values = {
    amba_alz_management_subscription_id            = jsonencode({ value = var.management_subscription_id != "" ? var.management_subscription_id : data.azapi_client_config.current.subscription_id })
    amba_alz_resource_group_location               = jsonencode({ value = var.location })
    amba_alz_resource_group_name                   = jsonencode({ value = var.resource_group_name })
    amba_alz_resource_group_tags                   = jsonencode({ value = var.tags })
    amba_alz_user_assigned_managed_identity_name   = jsonencode({ value = var.user_assigned_managed_identity_name })
    amba_alz_byo_user_assigned_managed_identity_id = jsonencode({ value = var.bring_your_own_user_assigned_managed_identity_resource_id })
    amba_alz_disable_tag_name                      = jsonencode({ value = var.amba_disable_tag_name })
    amba_alz_disable_tag_values                    = jsonencode({ value = var.amba_disable_tag_values })
    amba_alz_action_group_email                    = jsonencode({ value = var.action_group_email })
    amba_alz_arm_role_id                           = jsonencode({ value = var.action_group_arm_role_id })
    amba_alz_webhook_service_uri                   = jsonencode({ value = var.webhook_service_uri })
    amba_alz_event_hub_resource_id                 = jsonencode({ value = var.event_hub_resource_id })
    amba_alz_function_resource_id                  = jsonencode({ value = var.function_resource_id })
    amba_alz_function_trigger_url                  = jsonencode({ value = var.function_trigger_uri })
    amba_alz_logicapp_resource_id                  = jsonencode({ value = var.logic_app_resource_id })
    amba_alz_logicapp_callback_url                 = jsonencode({ value = var.logic_app_callback_url })
    amba_alz_byo_alert_processing_rule             = jsonencode({ value = var.bring_your_own_alert_processing_rule_resource_id })
    amba_alz_byo_action_group                      = jsonencode({ value = var.bring_your_own_action_group_resource_id })
  }
}
```

## Example - Deploying a Custom Architecture

This example demonstrates how to deploy the AMBA ALZ pattern using an existing custom management group hierarchy.

1. Create the `./lib` directory.
1. Create the `custom.alz_architecture_definition.json` file in the lib directory. Refer to [examples/custom-architecture-definition](https://github.com/Azure/terraform-azurerm-avm-ptn-monitoring-amba-alz/blob/main/examples/custom-architecture-definition) for a sample.
1. Adjust the management group names in `custom.alz_architecture_definition.json`.

```hcl
data "azapi_client_config" "current" {}

provider "alz" {
  library_overwrite_enabled = true
  library_references = [
    {
      path = "platform/amba"
      ref  = "2025.04.0"
    },
    {
      custom_url = "${path.root}/lib"
    }
  ]
}

provider "azurerm" {
  alias           = "management"
  subscription_id = var.management_subscription_id != "" ? var.management_subscription_id : data.azapi_client_config.current.subscription_id
  features {}
}

variable "management_subscription_id" {
  description = "Management subscription ID"
  type        = string
  default     = ""
}

variable "location" {
  description = "Location"
  type        = string
  default     = "swedencentral"
}

variable "resource_group_name" {
  type        = string
  default     = "rg-amba-monitoring-001"
  description = "The resource group where the resources will be deployed."
}

variable "user_assigned_managed_identity_name" {
  type        = string
  default     = "id-amba-prod-001"
  description = "The name of the user-assigned managed identity."
}
variable "action_group_email" {
  description = "Action group email"
  type        = list(string)
  default     = []
}

variable "action_group_arm_role_id" {
  description = "Action group ARM role ID"
  type        = list(string)
  default     = []
}

variable "tags" {
  type = map(string)
  default = {
    _deployed_by_amba = "True"
  }
  description = "(Optional) Tags of the resource."
}

locals {
  root_management_group_name = jsondecode(file("${path.root}/lib/custom.alz_architecture_definition.json")).management_groups[0].id
}

module "amba_alz" {
  source  = "Azure/avm-ptn-monitoring-amba-alz/azurerm"
  version = "0.1.1"
  providers = {
    azurerm = azurerm.management
  }
  location                            = var.location
  root_management_group_name          = local.root_management_group_name
  resource_group_name                 = var.resource_group_name
  user_assigned_managed_identity_name = var.user_assigned_managed_identity_name
}

module "amba_policy" {
  source             = "Azure/avm-ptn-alz/azurerm"
  version            = "0.11.0"
  architecture_name  = "custom"
  location           = var.location
  parent_resource_id = data.azapi_client_config.current.tenant_id
  policy_default_values = {
    amba_alz_management_subscription_id          = jsonencode({ value = var.management_subscription_id != "" ? var.management_subscription_id : data.azapi_client_config.current.subscription_id })
    amba_alz_resource_group_location             = jsonencode({ value = var.location })
    amba_alz_resource_group_name                 = jsonencode({ value = var.resource_group_name })
    amba_alz_resource_group_tags                 = jsonencode({ value = var.tags })
    amba_alz_user_assigned_managed_identity_name = jsonencode({ value = var.user_assigned_managed_identity_name })
    amba_alz_action_group_email                  = jsonencode({ value = var.action_group_email })
    amba_alz_arm_role_id                         = jsonencode({ value = var.action_group_arm_role_id })
  }
}
```

## Data Collection

The software may collect information about you and your use of the software and send it to Microsoft. Microsoft may use this information to provide services and improve our products and services. You may turn off the telemetry as described in the repository. There are also some features in the software that may enable you and Microsoft to collect data from users of your applications. If you use these features, you must comply with applicable law, including providing appropriate notices to users of your applications together with a copy of Microsoft’s privacy statement. Our privacy statement is located at <https://go.microsoft.com/fwlink/?LinkID=824704>. You can learn more about data collection and use in the help documentation and our privacy statement. Your use of the software operates as your consent to these practices.

## Next Steps

To remediate non-compliant policies, continue with [Policy Remediation](../Remediate-Policies).
