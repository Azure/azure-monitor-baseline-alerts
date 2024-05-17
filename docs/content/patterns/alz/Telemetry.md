---
title: Telemetry
geekdocCollapseSection: true
weight: 90
---

<!-- markdownlint-disable -->
## Telemetry Tracking Using Customer Usage Attribution (PID)
<!-- markdownlint-restore -->

Microsoft can identify the deployments of the Azure Resource Manager and Bicep templates with the deployed Azure resources. Microsoft can correlate these resources used to support the deployments. Microsoft collects this information to provide the best experiences with their products and to operate their business. The telemetry is collected through [customer usage attribution](https://docs.microsoft.com/azure/marketplace/azure-partner-customer-usage-attribution). The data is collected and governed by Microsoft's privacy policies, located at the [trust center](https://www.microsoft.com/trustcenter).

To disable this tracking, we have included a parameter called `telemetryOptOut` to the deployment template in this repo with a simple boolean flag. The default value `No` which **does not** disable the telemetry. If you would like to disable this tracking, then simply set this value to `Yes` and this module will not be included in deployments and **therefore disables** the telemetry tracking.

If you are happy with leaving telemetry tracking enabled, no changes are required.

For example, in the alzArm.json file, you will see the following:

```json
"telemetryOptOut": {
    "type": "string",
    "defaultValue": "No",
    "allowedValues": [
       "Yes",
       "No"
    ],
    "metadata": {
        "description": "The customer usage identifier used for telemetry purposes. The default value of False enables telemetry. The value of True disables telemetry."
    }
}
```

The default value is `No`, but can be changed to `Yes` in the parameter file. If set to `Yes` the deployment below will be ignored and therefore telemetry will not be tracked.

```json
{
    "condition": "[equals(parameters('telemetryOptOut'), 'No')]",
    "apiVersion": "2020-06-01",
    "name": "[variables('deploymentNames').pidCuaDeploymentName]",
    "location": "[deployment().location]",
    "type": "Microsoft.Resources/deployments",
    "properties": {
       "mode": "Incremental",
       "template": {
          "$schema": "https://schema.management.azure.com/schemas/2015-01-01/deploymentTemplate.json#",
          "contentVersion": "1.0.0.0",
          "resources": []
        }
    }
}
```

## Module PID Value Mapping

The following are the unique ID's (also known as PIDs) used in the AMBA deployment

| Name                                                                | PID                                  | Telemetry for                                                                   |
| ------------------------------------------------------------------- | ------------------------------------ | ------------------------------------------------------------------------------- |
| Azure Monitor Baseline Alerts - AMBA ARM Deployment                 | d6b3b08c-5825-4b89-a62b-e3168d3d8fb0 | Deplyments performed through PowerShell, Az CLI, Azure DevOps, GitHub pipelines |
| Azure Monitor Baseline Alerts - ALZ Portal Accelerator Deployments  | 5f0e5693-3998-4ae2-8115-ee96e38dac62 | Deplyments performed through the ALZ Portal Accelerator                         |
| Azure Monitor Baseline Alerts - AMBA Portal Accelerator Deployments | dddb1f42-f9d8-48e3-9e6b-f1ce3e9c2c76 | Deplyments performed through the AMBA Portal Accelerator                        |
| Azure Monitor Baseline Alerts - Bicep Deployments                   | 8fdd7c49-68f6-4e35-8ba3-ee0dd2979bc0 | Deplyments performed through Biceps                                             |
| Azure Monitor Baseline Alerts - Terraform Deployments               | da02c554-db8c-4029-96dd-d4ab9abf4dc4 | Deplyments performed through Terraform                                          |
| Connectivity Policy Initiative                                      | 2d69aa07-8780-4697-a431-79882cb9f00e | Usage of Connectivity Policy initiative alerts                                  |
| Identity Policy Initiative                                          | 8d257c20-97bf-4d14-acb3-38dd1436d13a | Usage of Identity Policy initiative alerts                                      |
| Management Policy Initiative                                        | d87415c4-01ef-4667-af89-0b5adc14af1b | Usage of Management Policy initiative alerts                                    |
| LandingZone Policy Initiative                                       | 7bcfc615-be78-43da-b81d-98959a9465a5 | Usage of LandingZone Policy initiative alerts                                   |
| Hybrid VM Initiative                                                | b5c25c0c-dfbf-4414-bedb-f48ab00d0f9e | Usage of Hybrid VM Policy initiative alerts                                     |
| ServiceHealth Policy Initiative                                     | 860d2afd-b71e-452f-9d3a-e56196cba570 | Usage of ServiceHealth Policy initiative alerts                                 |
| Notification Assets Policy Initiative                               | eabaaf0b-eed4-48a9-9f91-4f7e431ba807 | Usage of Notification Assets Policy initiative alerts                           |
