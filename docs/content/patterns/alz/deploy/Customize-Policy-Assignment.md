---
title: Customize Policy Assignment
geekdocCollapseSection: true
weight: 20
---

## Introduction

As described in [Introduction to deploying AMBA](../Introduction-to-deploying-the-ALZ-Pattern), the policies and initiatives in this repo can be deployed in a default configuration, i.e. with default settings and are intended to be used as such. There may be however, scenarios where you would want to tweak the initiative assignment for individual policies to conform with your monitoring requirements, or potentially wish to deploy alerts in a more phased approach to a brownfield environment. This document lists some of the various scenarios as well as how you would go about making such changes to the assignments.

## Modify initiative assignment

As an example you may want to change alert thresholds for one or more metric alerts when assigning initiatives. To do so the specific parameters can be specified in a parameter file. For convenience we supply a complete parameter file, containing all the parameters that can be comfigured in each initiative. Note that you are advised to leverage this as a template for creating your own parameter file as the parameters in these files may change over time, which could potentially have undesirable effects on your alert configurations.

### Parameter file

- [alzArm.param.json](https://github.com/azure/azure-monitor-baseline-alerts/blob/2024-08-30/patterns/alz/alzArm.param.json)

### Applying changes to the parameter file

If we want to change the threshold value for Virtual Network Gateway Express Route CPU utilization from 80 (default value) to 90, and Virtual Network Gateway Egress traffic from 1 to 1000, what we would do is include this in a parameter file as shown below. These specific thresholds would then be set in the individual policy assignment, while the remaining values for all other policies would remain at default. Note that the parameter file shown below has been truncated for brevity, compared to the samples included.

{{< hint type=Note >}}
The parameter file contains the same default values as listed in our documentation. However, be aware that the _Policy assignment parameter reference type​_ will change for all parameters when using the template parameter file, even when a value of a parameter wasn't modified it will appear as a _User defined parameter_ after deployment. This occurs because the parameter is explicitly defined in the parameter file. To avoid this, you can create your own parameter files that only includes the parameters that you wish to modify.
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

### Metric alert policy parameters

The following parameters can be changed for metric alert policies, in the initiatives these are prefixed with an appropriate string to indicate the metric in question.

| **Parameter Name** | **Parameter Description** |
|----------|----------|
| severity | 0 - 4 indicating alert severity |
| windowSize | Indicating the time windows inside which the alert is evaluating for true/false |
| evaluationFrequency | Indicating how often inside the time window evaluation takes place |
| effect | Can be either DeployIfNotExists or Disabled (modify is allowed for the recovery services vault alert) |
| autoMitigate | Indicates whether the the alert will auto-resolve if the alert condition is no longer true |
| threshold | Indicates a numerical threshold for when the alert would trigger. Not relevant to all alerts as some are configured with dynamic rather than fixed thresholds |
| enabled | Whether the alert is enabled or not |

### Activity log, Service health alert and action group policy parameters

The following parameters can be changed for activity log, service health alert and action group policies.

| **Parameter Name** | **Parameter Description** |
|----------|----------|
| ALZMonitorResourceGroupName | The name of the resource group to place the alerts in |
| ALZMonitorResourceGroupTags | Any tags than needs to be added to the resource group created |
| ALZMonitorResourceGroupLocation | The location of the resource group to place the alerts in |

Note that the above parameters specifies the resource group that activity log alerts are placed in. If the resource group does not exist it gets created. Also the parameter for tags can take several tags, if multiple tags are needed. Tags are only applied at the resource group level. The tags parameter is set to a default value of one tag with the name *environment* and the value *test*, you can add more tags as already mentioned or set it to be an empty value.

### Disabling Policies
- To review the options for disabling policies, please proceed with [Disabling Policies](../../Disabling-Policies)

# Next steps
- To deploy with GitHub Actions, please proceed with [Deploy with GitHub Actions](../Deploy-with-GitHub-Actions)
- To deploy with Azure DevOps Pipelines, please proceed with [Deploy with Azure Pipelines](../Deploy-with-Azure-Pipelines)
- To deploy with Azure CLI, please proceed with [Deploy with Azure CLI](../Deploy-with-Azure-CLI)
- To deploy with Azure PowerShell, please proceed with [Deploy with Azure PowerShell](../Deploy-with-Azure-PowerShell)
