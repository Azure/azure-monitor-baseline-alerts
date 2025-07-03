---
title: Customize Policy Assignment
geekdocCollapseSection: true
weight: 20
---

### In this page

> [Introduction](../Customize-Policy-Assignment#introduction) </br>
> [Modify initiative assignment](../Customize-Policy-Assignment#modify-initiative-assignment) </br>
> [Next steps](../Customize-Policy-Assignment#next-steps)

## Introduction

This document provides guidance on customizing policy assignments for the policies and initiatives in this repository. While default configurations are available as described in [Introduction to deploying the AMBA-ALZ pattern](../Introduction-to-deploying-the-ALZ-Pattern), you may need to adjust these settings to meet specific monitoring requirements or to implement alerts incrementally in an existing environment.

## Modify Initiative Assignment

To adjust alert thresholds for one or more metric alerts, specify the relevant parameters in a parameter file. A comprehensive parameter file template is provided, which includes all configurable parameters for each initiative. Use this template to create your own parameter file, as parameters may change over time, potentially affecting your alert configurations.

### Parameter File

Two versions of the parameter file are available:

1. [alzArm.param.json](https://github.com/azure/azure-monitor-baseline-alerts/blob/2025-07-02/patterns/alz/alzArm.param.json) aligned with the latest release.
2. [alzArm.param.json](https://github.com/azure/azure-monitor-baseline-alerts/blob/main/patterns/alz/alzArm.param.json) aligned with the main branch.

### Applying Changes to the Parameter File

To adjust the threshold values for Virtual Network Gateway Express Route CPU utilization from 80 to 90, and for Virtual Network Gateway Egress traffic from 1 to 1000, include these changes in a parameter file as shown below. These specific thresholds will apply to the individual policy assignment, while all other policy values will remain at their default settings. Note that the parameter file shown below is truncated for brevity.

{{< hint type=Note >}}
The parameter file includes default values as documented. However, the _Policy assignment parameter reference type_ will change for all parameters when using the template parameter file. Even if a parameter's value remains unmodified, it will be marked as a _User defined parameter_ after deployment because it is explicitly defined in the parameter file. To prevent this, create custom parameter files that only include the parameters you wish to modify.
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

### Metric Alert Policy Parameters

The following parameters can be modified for metric alert policies. In the initiatives, these parameters are prefixed with a specific string to denote the relevant metric.

| **Parameter Name** | **Parameter Description** |
|--------------------|---------------------------|
| severity           | 0 - 4 indicating alert severity |
| windowSize         | Time window for alert evaluation |
| evaluationFrequency| Frequency of evaluation within the time window |
| effect             | DeployIfNotExists or Disabled (modify allowed for recovery services vault alert) |
| autoMitigate       | Whether the alert auto-resolves if the condition is no longer true |
| threshold          | Numerical threshold for alert trigger (not relevant to all alerts) |
| enabled            | Whether the alert is enabled or not |

### Activity Log, Service Health Alert, and Action Group Policy Parameters

The following parameters can be changed for activity log, service health alert, and action group policies.

| **Parameter Name** | **Parameter Description** |
|--------------------|---------------------------|
| ALZMonitorResourceGroupName | Name of the resource group for the alerts |
| ALZMonitorResourceGroupTags | Tags to be added to the resource group |
| ALZMonitorResourceGroupLocation | Location of the resource group for the alerts |

These parameters specify the resource group where activity log alerts will be placed. If the resource group does not exist, it will be created. The `tags` parameter can accept multiple tags if needed, but tags are only applied at the resource group level. By default, the `tags` parameter is set to a single tag with the name _environment_ and the value _test_. You can add more tags as required or leave it empty.

### Disabling Policies

For options on disabling policies, visit [Disabling Policies](../../Disabling-Policies).

## Next Steps

- To deploy using Azure Portal UI, visit [Deploy via the Azure Portal Accelerator](../Deploy-via-Azure-Portal-UI)
- To deploy with GitHub Actions, visit [Deploy with GitHub Actions](../Deploy-with-GitHub-Actions)
- To deploy with Azure DevOps Pipelines, visit [Deploy with Azure Pipelines](../Deploy-with-Azure-Pipelines)
- To deploy with Azure CLI, visit [Deploy with Azure CLI](../Deploy-with-Azure-CLI)
- To deploy with Azure PowerShell, visit [Deploy with Azure PowerShell](../Deploy-with-Azure-PowerShell)
