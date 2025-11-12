---
title: Terraform Module
geekdocCollapseSection: true
weight: 120
---

### On this page

> [Modules](./#modules) </br>
> [AzAPI Provider](./#azapi-provider) </br>
> [Required Inputs](./#required-inputs) </br>
> [Optional Inputs](./#optional-inputs) </br>
> [Outputs](./#outputs) </br>
> [Requirements](./#requirements) </br>
> [Data Collection](./#data-collection) </br>

## Modules

For a complete deployment of the AMBA-ALZ pattern you will need the following 2 modules:

### avm_ptn_alz

>Source: <a href="https://github.com/Azure/terraform-azurerm-avm-ptn-alz" target="_blank">Azure/avm-ptn-alz/azurerm</a>
>
>Version: 0.11.0
>
>Terraform registry: <a href="https://registry.terraform.io/modules/Azure/avm-ptn-alz/azurerm/latest" target="_blank">avm-ptn-alz</a>

This module is responsible for the deployment of the following resources:

- Resource Group.
- User Assigned Managed Identity.
- Monitoring Reader Role Assignment for the User Assigned Managed Identity.

### avm_ptn_monitoring_amba_alz

>Source: <a href="https://github.com/Azure/terraform-azurerm-avm-ptn-monitoring-amba-alz" target="_blank">Azure/avm-ptn-monitoring-amba-alz/azurerm</a>
>
>Version: 0.1.1
>
>Terraform registry: <a href="https://registry.terraform.io/modules/Azure/avm-ptn-monitoring-amba-alz/azurerm/latest" target="_blank">avm-ptn-monitoring-amba-alz</a>
>
>{{< hint type=note >}}
Additionally, the "avm-ptn-monitoring-amba-alz" module calls the following resource modules:

- #### resource_group

  Source: <a href="https://github.com/Azure/terraform-azurerm-avm-res-resources-resourcegroup" target="_blank">Azure/avm-res-resources-resourcegroup/azurerm</a>

  Version: 0.2.1

- #### user_assigned_managed_identity

  Source: <a href="https://github.com/Azure/terraform-azurerm-avm-res-managedidentity-userassignedidentity" target="_blank">Azure/avm-res-managedidentity-userassignedidentity/azurerm</a>

  Version: 0.3.3

>{{< /hint >}}

This module is responsible for the deployment of the following resources used the context of deploying AMBA-ALZ:

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

### location

Description: Azure region where the resource should be deployed.

Type: `string`

### root_management_group_name

Description: The name (ID) of the management group.

Type: `string`

## Optional Inputs

The following input variables are optional (have default values):

### description

Description: The description used for the role assignment to identify the resource as deployed by AMBA.

Type: `string`

Default: `"_deployed_by_amba"`

### enable_telemetry

Description: This variable controls whether or not telemetry is enabled for the module.
For more information see <https://aka.ms/avm/telemetryinfo>.
If it is set to false, then no telemetry will be collected.

Type: `bool`

Default: `true`

### lock

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

### resource_group_name

Description: The resource group where the resources will be deployed.

Type: `string`

Default: `"rg-amba-monitoring-001"`

### retries

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

### role_assignments

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

### role_definition

Description: The role definition ID to assign to the User Assigned Managed Identity. Defaults to Monitoring Reader.

Type: `string`

Default: `"43d0d8ad-25c7-4714-9337-8ba259a9fe05"`

### tags

Description: (Optional) Tags of the resource.

Type: `map(string)`

Default: `null`

### timeouts

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

### user_assigned_managed_identity_name

Description: The name of the user-assigned managed identity.

Type: `string`

Default: `"id-amba-prod-001"`

## Outputs

The following outputs are exported:

### resource_group_name

Description: The resource group name

### resource_id

Description: The resource id of the resource group

### user_assigned_managed_identity_name

Description: The user assigned managed identity name

### user_assigned_managed_identity_resource_id

Description: The resource id of the user assigned managed identity

## Requirements

The following requirements are needed by this module:

- <a href="https://github.com/hashicorp/terraform" target="_blank">terraform</a> (~> 1.9)

- <a href="https://github.com/Azure/terraform-provider-alz" target="_blank">alz</a> (~> 0.17.4)

- <a href="https://github.com/Azure/terraform-provider-azapi" target="_blank">azapi</a> (~> 2.2)

- <a href="https://github.com/hashicorp/terraform-provider-azurerm" target="_blank">azurem</a> (~> 4.0)

## Data Collection

The software may collect information about you and your use of the software and send it to Microsoft. Microsoft may use this information to provide services and improve our products and services. You may turn off the telemetry as described in the repository. There are also some features in the software that may enable you and Microsoft to collect data from users of your applications. If you use these features, you must comply with applicable law, including providing appropriate notices to users of your applications together with a copy of Microsoft’s privacy statement. Our privacy statement is located at <https://go.microsoft.com/fwlink/?LinkID=824704>. You can learn more about data collection and use in the help documentation and our privacy statement. Your use of the software operates as your consent to these practices.
