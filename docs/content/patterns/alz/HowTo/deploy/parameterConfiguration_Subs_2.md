---
title: Parameter Configuration
hidden: true
---

The parameter file below is a shortened version for demonstration purposes. Full examples are available in the provided samples.

```json
{
  "$schema": "https://schema.management.azure.com/schemas/2019-04-01/deploymentParameters.json#",
  "contentVersion": "1.0.0.0",
  "parameters": {
    "topLevelSubscriptionId": {
      "value": "00000000-0000-0000-0000-000000000000"
    },
    "enableAMBAConnectivity": {
      "value": "Yes"
    },
    "enableAMBAIdentity": {
      "value": "Yes"
    },
    "enableAMBAManagement": {
      "value": "Yes"
    },
    "enableAMBAServiceHealth": {
      "value": "Yes"
    },
    "enableAMBANotificationAssets": {
      "value": "Yes"
    },
    "enableAMBAHybridVM": {
      "value": "Yes"
    },
    "enableAMBAKeyManagement": {
      "value": "Yes"
    },
    "enableAMBALoadBalancing": {
      "value": "Yes"
    },
    "enableAMBANetworkChanges": {
      "value": "Yes"
    },
    "enableAMBARecoveryServices": {
      "value": "Yes"
    },
    "enableAMBAStorage": {
      "value": "Yes"
    },
    "enableAMBAVM": {
      "value": "Yes"
    },
    "enableAMBAWeb": {
      "value": "Yes"
    },
    "telemetryOptOut": {
      "value": "No"
    },
    "bringYourOwnUserAssignedManagedIdentity": {
      "value": "No"
    },
    "bringYourOwnUserAssignedManagedIdentityResourceId": {
      "value": ""
    },
    "userAssignedManagedIdentityName": {
      "value": "id-amba-prod-001"
    },
    "ALZMonitorResourceGroupName": {
      "value": "rg-amba-monitoring-001"
    },
    "ALZMonitorResourceGroupLocation": {
      "value": "eastus"
    },
    "ALZMonitorResourceGroupTags": {
      "value": {
        "_deployed_by_amba": true
      }
    },
    "ALZMonitorDisableTagName": {
      "value": "MonitorDisable"
    },
    "ALZMonitorDisableTagValues": {
      "value": [
        "true",
        "Test",
        "Dev",
        "Sandbox"
      ]
    },
    .
    .
    .
    .
  }
}
```
