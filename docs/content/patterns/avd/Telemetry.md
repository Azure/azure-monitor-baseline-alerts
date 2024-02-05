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

This deployment has a custom UI definition meaning you will then be provided a form to select options with the ability to check the box labeled ["Opt-Out of Telemetry"](./media/AVDAlertsOptOut.png).

In the avdArm.json file, you will see the following:

```json
    "optoutTelemetry": {
      "type": "bool",
      "defaultValue": false,
      "metadata": {
        "description": "Telemetry Opt-Out"
      }
    },
```


## Module PID Value Mapping

The following are the unique ID's (also known as PIDs) used in the Alerts Pattern deployment

| Name                            | PID                                  |
| ------------------------------- | ------------------------------------ |
| AVD Baseline Alerts             | b8b4a533-1bb2-402f-bbd9-3055d00d885a |