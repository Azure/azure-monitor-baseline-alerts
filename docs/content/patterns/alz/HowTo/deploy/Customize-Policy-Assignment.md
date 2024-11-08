---
title: Customize Policy Assignment
geekdocCollapseSection: true
weight: 20
---
## In this page

> [Introduction](../Customize-Policy-Assignment#introduction) </br>
> [Modify initiative assignment](../Customize-Policy-Assignment#modify-initiative-assignment) </br>
> [- Parameter file](../Customize-Policy-Assignment#parameter-file) </br>
> [- Applying changes to the parameter file](../Customize-Policy-Assignment#applying-changes-to-the-parameter-file) </br>
> [- Metric alert policy parameters](../Customize-Policy-Assignment#metric-alert-policy-parameters) </br>
> [- Activity log, Service health alert and action group policy parameters](../Customize-Policy-Assignment#activity-log-service-health-alert-and-action-group-policy-parameters) </br>
> [- Disabling Policies](../Customize-Policy-Assignment#disabling-policies) </br>
> [Next steps](../Customize-Policy-Assignment#next-steps)

## Introduction

The policies and initiatives in this repository can be deployed using their default configurations, as described in [Introduction to deploying the ALZ pattern](../Introduction-to-deploying-the-ALZ-Pattern). These default settings are intended for general use. However, there may be scenarios where you need to adjust the initiative assignment for specific policies to meet your monitoring requirements or to implement alerts gradually in an existing environment. This document outlines various scenarios and provides guidance on how to modify these assignments.

[Back to top of page](.)

## Modify initiative assignment

When assigning initiatives, you may need to adjust alert thresholds for one or more metric alerts. This can be achieved by specifying the relevant parameters in a parameter file. For your convenience, we provide a comprehensive parameter file that includes all configurable parameters for each initiative. It is recommended to use this file as a template to create your own parameter file, as the parameters may change over time, potentially affecting your alert configurations.

[Back to top of page](.)

### Parameter file

- [alzArm.param.json](https://github.com/azure/azure-monitor-baseline-alerts/blob/2024-08-30/patterns/alz/alzArm.param.json)

[Back to top of page](.)

### Applying changes to the parameter file

To adjust the threshold values for Virtual Network Gateway Express Route CPU utilization from the default value of 80 to 90, and for Virtual Network Gateway Egress traffic from 1 to 1000, you need to include these changes in a parameter file as demonstrated below. These specific thresholds will be applied to the individual policy assignment, while all other policy values will remain at their default settings. Note that the parameter file shown below is truncated for brevity compared to the full samples provided.


{{< hint type=Note >}}
The parameter file includes the default values as documented. However, the _Policy assignment parameter reference type_ will change for all parameters when using the template parameter file. Even if a parameter's value remains unmodified, it will be marked as a _User defined parameter_ after deployment because it is explicitly defined in the parameter file. To prevent this, you can create custom parameter files that only include the parameters you wish to modify.
{{< /hint >}}

```json
{
    "$schema": "https://schema.management.azure.com/schemas/2019-04-01/deploymentParameters.json#",
    "contentVersion": "1.0.0.0",
    "parameters": {
        "enterpriseScaleCompanyPrefix": {
            "value": "contoso"
        },
        "policyAssignmentParametersCommon": {
            "value": {
                "ALZMonitorResourceGroupName": {
                    "value": "rg-amba-monitoring-001"
                },
                "ALZMonitorResourceGroupTags": {
                    "value": {
                        "Project": "amba-monitoring"
                    }
                },
                "ALZMonitorResourceGroupLocation": {
                    "value": "eastus"
                }
            }
        },
        "policyAssignmentParametersConnectivity": {
            "value": {
                "VnetGwERCpuUtilThreshold": {
                    "value": "90"
                },
                "VnetGwTunnelEgressThreshold": {
                    "value": "1000"
                }
            }
        }
    }
}
```

[Back to top of page](.)

### Metric alert policy parameters

The following parameters can be modified for metric alert policies. In the initiatives, these parameters are prefixed with a specific string to denote the relevant metric.

| **Parameter Name** | **Parameter Description** |
|----------|----------|
| severity | 0 - 4 indicating alert severity |
| windowSize | Indicating the time window where the alert performs the true/false evaluation |
| evaluationFrequency | Indicating how often evaluation takes place inside the time window |
| effect | Can be either DeployIfNotExists or Disabled (modify is allowed for the recovery services vault alert) |
| autoMitigate | Indicates whether the the alert will auto-resolve if the alert condition is no longer true |
| threshold | Indicates a numerical threshold for when the alert would trigger. Not relevant to all alerts as some are configured with dynamic rather than fixed thresholds |
| enabled | Whether the alert is enabled or not |

[Back to top of page](.)

### Activity log, Service health alert and action group policy parameters

The following parameters can be changed for activity log, service health alert and action group policies.

| **Parameter Name** | **Parameter Description** |
|----------|----------|
| ALZMonitorResourceGroupName | The name of the resource group for the alerts |
| ALZMonitorResourceGroupTags | Any tags than need to be added to the resource group created |
| ALZMonitorResourceGroupLocation | The location of the resource group for the alerts |


The parameters mentioned above specify the resource group where activity log alerts will be placed. If the resource group does not exist, it will be created. The `tags` parameter can accept multiple tags if needed, but tags are only applied at the resource group level. By default, the `tags` parameter is set to a single tag with the name *environment* and the value *test*. You can add more tags as required or leave it empty.

[Back to top of page](.)

### Disabling Policies

To review the options for disabling policies, visit [Disabling Policies](../../Disabling-Policies)

[Back to top of page](.)

## Next steps

- To deploy with GitHub Actions, visit [Deploy with GitHub Actions](../Deploy-with-GitHub-Actions)
- To deploy with Azure DevOps Pipelines, visit [Deploy with Azure Pipelines](../Deploy-with-Azure-Pipelines)
- To deploy with Azure CLI, visit [Deploy with Azure CLI](../Deploy-with-Azure-CLI)
- To deploy with Azure PowerShell, visit [Deploy with Azure PowerShell](../Deploy-with-Azure-PowerShell)

[Back to top of page](.)
