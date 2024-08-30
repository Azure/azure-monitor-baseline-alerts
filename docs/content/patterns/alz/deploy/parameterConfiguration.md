---
title: Parameter configuration
geekdocHidden: true
---

## 1. Parameter configuration

To start, you can either download a copy of the parameter file or clone/fork the repository.

- [alzArm.param.json](https://github.com/azure/azure-monitor-baseline-alerts/blob/2024-09-02/patterns/alz/alzArm.param.json)

The following changes apply to all scenarios, whether you are aligned or unaligned with ALZ or have a single management group.

- Change the value of the following parameters at the beginning of parameter file according to the instructions below:

  {{< hint type=note >}}
  While it's technically possible to not add any notification information (no email, no ARM Role, no Logic App, etc.) it is strongly recommended to configure at least one option.
  {{< /hint >}}

  - Change the value of _```enterpriseScaleCompanyPrefix```_ to the management group where you wish to deploy the policies and the initiatives. This is usually the so called "pseudo root management group", for example, in [ALZ terminology](https://learn.microsoft.com/azure/cloud-adoption-framework/ready/landing-zone/design-area/resource-org-management-groups), this would be the so called "Intermediate Root Management Group" (directly beneath the "Tenant Root Group").
  - Change the value of _```bringYourownUserAssignedManagedIdentity```_ to **Yes** if you have an existing user assigned managed identity with the ***Monitoring Reader*** role assigned at the pseudo root management group level or leave it to **No** if you would like to create a new one with the proper rights as part of the deployment process.
  - Change the value of _```bringYourownUserAssignedManagedIdentityResourceId```_. If you set the _```bringYourownUserAssignedManagedIdentity```_ parameter to **Yes**, insert the resource id of your user assigned managed identity. If you left it with the default value of **No**, leave the value blank.
  - Change the value of _```userAssignedManagedIdentityName```_ to a name of your preference. This parameter is used only if the _```bringYourownUserAssignedManagedIdentity```_ has been set to **No**.
  - Change the value of _```managementSubscriptionId```_. If you set the _```bringYourownUserAssignedManagedIdentity```_ parameter to **No**, enter the subscriptionId of the management subscription, otherwise leave the default value.
  - Change the value of _```ALZMonitorResourceGroupName```_ to the name of the resource group where the activity logs, resource health alerts, actions groups and alert processing rules will be deployed in.
  - Change the value of _```ALZMonitorResourceGroupTags```_ to specify the tags to be added to said resource group.
  - Change the value of _```ALZMonitorResourceGroupLocation```_ to specify the location for said resource group.
  - Change the value of _```ALZMonitorActionGroupEmail```_ to the email address(es) where notifications of the alerts (including Service Health alerts) are sent to. Leave the value blank if no email notification is used.
  - Change the value of _```ALZLogicappResourceId```_ to the Logic app resource id to be used as action for the alerts (including Service Health alerts). Leave the value blank if no Logic app is used.
  - Change the value of _```ALZLogicappCallbackUrl```_ to the Logic app callback url of the Logic app you want to use as action for the alerts (including Service Health alerts). Leave the value blank if no Logic app is used. To retrieve the callback url you can either use the [_**Get-AzLogicAppTriggerCallbackUrl**_](https://learn.microsoft.com/en-us/powershell/module/az.logicapp/get-azlogicapptriggercallbackurl) PowerShell command or navigate to the Logic app in the Azure portal, go to _**Logic app designer**_, expand the trigger activity (_When an HTTP request is received_) and copy the value in the URL field using the 2-sheets icon.

    ![Get Logic app callback url](../../media/AMBA-LogicAppCallbackUrl.png)

  - Change the value of _```ALZArmRoleId```_ to the Azure Resource Manager Role(s) where notifications of the alerts (including Service Health alerts) are sent to. Leave the value blank if no Azure Resource Manager Role notification is required.
  - Change the value of _```ALZEventHubResourceId```_ to the Event Hubs to be used as action for the alerts (including Service Health alerts). Leave the value blank if no Event Hubs is used.
  - Change the value of _```ALZWebhookServiceUri```_ to the URI(s) to be used as action for the alerts (including Service Health alerts). Leave the value blank if no Webhook is used.
  - Change the value of _```ALZFunctionResourceId```_ to the Function resource id to be used as action for the alerts (including Service Health alerts). Leave the value blank if no Function is used.
  - Change the value of _```ALZFunctionTriggerUrl```_ to the Function App trigger url of the function to be used as action for the alerts (including Service Health alerts). Leave the value blank if no Function is used. To retrieve the Function App trigger url with the corresponding code, navigate to the HTTP-triggered functions in the Azure portal, go to _**Code + Test**_, select **Get function URL** from the menu top menu and copy the value in the URL field using the 2-sheets icon.

    ![Get function URL](../../media/AMBA-FunctionAppTriggerUrl.png)

  {{< hint type=note >}}
  It is possible use multiple email addresses, as well as multiple Arm Roles, Webhooks or Event Hubs (not recommended as per ALZ guidance). Should you set multiple entries, make sure they are entered as single string with values separated by comma. Example:

    "ALZMonitorActionGroupEmail": {
      "value": "action1@contoso.com , action2@contoso.com , action3@contoso.com"
      },

    "ALZArmRoleId": {
        "value": "8e3af657-a8ff-443c-a75c-2fe8c4bcb635, b24988ac-6180-42a0-ab88-20f7382dd24c"
      },

    "ALZWebhookServiceUri": {
      "value": "https://webhookUri1.webhook.com, http://webhookUri2.webhook.com"
    },
  {{< /hint >}}

- If you would like to disable initiative assignments, you can change the value on one or more of the following parameters; _```enableAMBAConnectivity```_, _```enableAMBAIdentity```_, _```enableAMBALandingZone```_, _```enableAMBAManagement```_, _```enableAMBAServiceHealth```_ to _**"No"**_.

### If you are aligned to ALZ

- Change the value of _```platformManagementGroup```_ to the management group id for Platform.
- Change the value of _```IdentityManagementGroup```_ to the management group id for Identity.
- Change the value of _```managementManagementGroup```_ to the management group id for Management.
- Change the value of _```connectivityManagementGroup```_ to the management group id for Connectivity.
- Change the value of _```LandingZoneManagementGroup```_ to the management group id for Landing Zones.

### If you are unaligned to ALZ

- Change the value of _```platformManagementGroup```_ to the management group id for Platform. The same management group id may be repeated.
- Change the value of _```IdentityManagementGroup```_ to the management group id for Identity. The same management group id may be repeated.
- Change the value of _```managementManagementGroup```_ to the management group id for Management. The same management group id may be repeated.
- Change the value of _```connectivityManagementGroup```_ to the management group id for Connectivity. The same management group id may be repeated.
- Change the value of _```LandingZoneManagementGroup```_ to the management group id for Landing Zones. The same management group id may be repeated.

{{< hint type=note >}}
For ease of deployment and maintenance we have kept the same variables. For example, if you combined Identity, Management and Connectivity into one management group you should configure the variables _```identityManagementGroup```_, _```managementManagementGroup```_ , _```connectivityManagementGroup```_ and _```LZManagementGroup```_ with the same management group id.
{{< /hint >}}

### If you have a single management group

- Change the value of _```platformManagementGroup```_ to the pseudo root management group id, also called the "Intermediate Root Management Group".
- Change the value of _```IdentityManagementGroup```_ to the pseudo root management group id, also called the "Intermediate Root Management Group".
- Change the value of _```managementManagementGroup```_ to the pseudo root management group id, also called the "Intermediate Root Management Group".
- Change the value of _```connectivityManagementGroup```_ to the pseudo root management group id, also called the "Intermediate Root Management Group".
- Change the value of _```LandingZoneManagementGroup```_ to the pseudo root management group id, also called the "Intermediate Root Management Group".

{{< hint type=note >}}
For ease of deployment and maintenance we have kept the same variables. Configure the variables _```enterpriseScaleCompanyPrefix```_, _```identityManagementGroup```_, _```managementManagementGroup```_, _```connectivityManagementGroup```_ and _```LZManagementGroup```_ with the pseudo root management group id.
{{< /hint >}}

## 2. Example Parameter file

The parameter file shown below has been truncated for brevity, compared to the samples included.

```json
{
  "$schema": "https://schema.management.azure.com/schemas/2019-04-01/deploymentParameters.json#",
  "contentVersion": "1.0.0.0",
  "parameters": {
    "enterpriseScaleCompanyPrefix": {
      "value": "contoso"
    },
    "platformManagementGroup": {
      "value": "contoso-platform"
    },
    "IdentityManagementGroup": {
      "value": "contoso-identity"
    },
    "managementManagementGroup": {
      "value": "contoso-management"
    },
    "connectivityManagementGroup": {
      "value": "contoso-connectivity"
    },
    "LandingZoneManagementGroup": {
      "value": "contoso-landingzones"
    },
    "enableAMBAConnectivity": {
      "value": "Yes"
    },
    "enableAMBAIdentity": {
      "value": "Yes"
    },
    "enableAMBALandingZone": {
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
    "managementSubscriptionId": {
      "value": ""
    },
    "ALZMonitorResourceGroupName": {
      "value": "rg-amba-monitoring-001"
    },
    "ALZMonitorResourceGroupLocation": {
      "value": "eastus"
    },
    "ALZMonitorResourceGroupTags": {
      "value": {
        "Project": "amba-monitoring"
      }
    }
    .
    .
    .
    .
  }
}
```
