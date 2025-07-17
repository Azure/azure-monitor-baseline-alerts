---
title: Parameter Configuration
geekdocHidden: true
---

To begin, download the appropriate parameter file for the version of AMBA-ALZ you are deploying.

  {{< hint type=note >}}
  Forking or cloning the repository isn’t required for the deployment, unless you have customized the policies as described in [How to modify individual policies](../Introduction-to-deploying-the-ALZ-Pattern#how-to-modify-individual-policies)
  {{< /hint >}}

- [alzArm.param.json](https://github.com/azure/azure-monitor-baseline-alerts/blob/2025-07-02/patterns/alz/alzArm.param.json) for the latest release.
- [alzArm.param.json](https://github.com/azure/azure-monitor-baseline-alerts/blob/main/patterns/alz/alzArm.param.json) for the main branch.

The following instructions apply universally, regardless of your alignment with ALZ or if you have a single management group.

- Modify the values of the following parameters at the beginning of the parameter file as per the following instructions:

  {{< hint type=note >}}
  It is highly recommended to configure at least one notification option (email, ARM Role, Logic App, etc.) to ensure you receive alerts. Proceeding without any notification settings is not advised.
  {{< /hint >}}

  - Set the value of _```enterpriseScaleCompanyPrefix```_ to the management group where you intend to deploy the policies and initiatives. Typically, this is the "pseudo root management group." In [ALZ terminology](https://learn.microsoft.com/azure/cloud-adoption-framework/ready/landing-zone/design-area/resource-org-management-groups), this refers to the "Intermediate Root Management Group" located directly beneath the "Tenant Root Group."
  - Set the _```bringYourownUserAssignedManagedIdentity```_ parameter to **Yes** if you have an existing user-assigned managed identity with the ***Monitoring Reader*** role assigned at the pseudo root management group level. Otherwise, leave it set to **No** to create a new managed identity with the appropriate permissions during the deployment process.
  - Update the _```bringYourownUserAssignedManagedIdentityResourceId```_ parameter. If _```bringYourownUserAssignedManagedIdentity```_ is set to **Yes**, provide the resource ID of your user-assigned managed identity. If it is set to **No**, leave this parameter blank.
  - Set the _```userAssignedManagedIdentityName```_ parameter to a preferred name. This parameter is only used if _```bringYourownUserAssignedManagedIdentity```_ is set to **No**.
  - Update the _```managementSubscriptionId```_ parameter. If _```bringYourownUserAssignedManagedIdentity```_ is set to **No**, provide the subscription ID of the management subscription. Otherwise, leave it blank.
  - Set the _```ALZMonitorResourceGroupName```_ parameter to the name of the resource group where activity logs, resource health alerts, action groups, and alert processing rules will be deployed.
  - Update the _```ALZMonitorResourceGroupTags```_ parameter to specify the tags to be added to the resource group.
  - Set the _```ALZMonitorResourceGroupLocation```_ parameter to specify the location of the resource group.
  - Update the _```ALZMonitorActionGroupEmail```_ parameter with the email address(es) for alert notifications (including Service Health alerts). Leave it blank if no email notification is required or if existing customer-owned action group(s) should be used (see [Bring Your Own Notifications](../../Bring-your-own-Notifications)).
  - Set the _```ALZLogicappResourceId```_ parameter to the Logic App resource ID to be used for alert actions (including Service Health alerts). Leave it blank if no Logic App is used or if existing customer-owned action group(s) should be used (see [Bring Your Own Notifications](../../Bring-your-own-Notifications)). To retrieve the Logic App resource ID, navigate to the resource, in the ***Overview*** panel click on ***JSON View*** and copy the value of the Resource ID field.

    ![Logic App JSON View](../../../media/LogicApp_ResourceID_1.png)

    ![Logic App Resource ID](../../../media/LogicApp_ResourceID_2.png)

  - Update the _```ALZLogicappCallbackUrl```_ parameter with the callback URL of the Logic App to be used for alert actions (including Service Health alerts). Leave it blank if no Logic App is used or if existing customer-owned action group(s) should be used (see [Bring Your Own Notifications](../../Bring-your-own-Notifications)). To retrieve the callback URL, use the [***Get-AzLogicAppTriggerCallbackUrl***](https://learn.microsoft.com/en-us/powershell/module/az.logicapp/get-azlogicapptriggercallbackurl) PowerShell command or navigate to the Logic App in the Azure portal, go to ***Logic App Designer***, expand the trigger activity (_When an HTTP request is received_), and copy the URL using the copy icon.

    ![Get Logic app callback url](../../../media/AMBA-LogicAppCallbackUrl.png)

  - Update the value of `_ALZArmRoleId_` to specify the Azure Resource Manager Role(s) that should receive notifications for the alerts, including Service Health alerts. If no notifications are required for any Azure Resource Manager Role, or if existing customer-owned action group(s) should be used (see [Bring Your Own Notifications](../../Bring-your-own-Notifications)) leave this value blank.
  - Update the value of _```ALZEventHubResourceId```_ to specify the Event Hubs that will be used for alert actions, including Service Health alerts. Leave it blank if no Event Hubs is used or if existing customer-owned action group(s) should be used (see [Bring Your Own Notifications](../../Bring-your-own-Notifications)). To retrieve the Event Hubs resource ID, navigate to the resource, in the search box type ***Event Hubs***, click ***Event Hubs***, select the event hub of your interest and in the ***Overview*** page that will load click on ***JSON View*** and copy the value of the Resource ID field.

    ![Event Hub Namespace ](../../../media/EventHub_ResourceID_1.png)

    ![Event Hub JSON View](../../../media/EventHub_ResourceID_2.png)

    ![Event Hub Resource ID](../../../media/EventHub_ResourceID_3.png)

  - Update the _```ALZWebhookServiceUri```_ parameter with the URI(s) of the Webhooks to be used for alert actions, including Service Health alerts. Leave it blank if no Webhooks are used or if existing customer-owned action group(s) should be used (see [Bring Your Own Notifications](../../Bring-your-own-Notifications)).
  - Update the _```ALZFunctionResourceId```_ parameter with the resource ID of the Function App to be used for alert actions, including Service Health alerts. Leave it blank if no Function App is used or if existing customer-owned action group(s) should be used (see [Bring Your Own Notifications](../../Bring-your-own-Notifications)). To retrieve the Function App resource ID, navigate to the resource, in the ***Overview*** panel click on ***JSON View*** and copy the value of the Resource ID field.

    ![Function App JSON View](../../../media/FunctionApp_ResourceID_1.png)

    ![Funtion App Resource ID](../../../media/FunctionApp_ResourceID_2.png)

  - Update the _```ALZFunctionTriggerUrl```_ parameter with the trigger URL of the Function App to be used for alert actions, including Service Health alerts. Leave it blank if no Function App is used or if existing customer-owned action group(s) should be used (see [Bring Your Own Notifications](../../Bring-your-own-Notifications)). To retrieve the Function App trigger URL with the corresponding code, navigate to the HTTP-triggered functions in the Azure portal, go to ***Code + Test***, select **Get function URL** from the top menu, and copy the value in the URL field using the copy icon.

    ![Get function URL](../../../media/AMBA-FunctionAppTriggerUrl.png)

  - Update the _```ALZAlertSeverity```_ parameter with the different severity level to be used for alert actions, including Service Health alerts. Leave the default values to notify on every severity level.

    {{< hint type=note >}}
    Activity Log alerts can only be configured with ***Sev4*** which translates to ***Verbose***. No other severities are allowed. Consider this when changing the default value of the ALZAlertSeverity parameter.
    {{< /hint >}}

  - Update the _```BYOActionGroup```_ parameter with resource ID of your selected action group to be used for alert actions, including Service Health alerts. Leave it blank to use AMBA-ALZ created action groups. To retrieve the Action Group resource ID, navigate to the ***Monitor*** page, click on ***Action groups***, click on the identified action group, in the ***Overview*** page that will load click on ***JSON View*** and copy the value of the Resource ID field.

    ![Action groups](../../../media/ActionGroup_ResourceID_1.png)

    ![Selected action group](../../../media/ActionGroup_ResourceID_2.png)

    ![Action Group JSON View ID](../../../media/ActionGroup_ResourceID_3.png)

    ![Action Group Resource ID](../../../media/ActionGroup_ResourceID_4.png)

  - Update the _```BYOAlertProcessingRule```_ parameter with the trigger URL of the Function App to be used for alert actions, including Service Health alerts. Leave it blank to use AMBA-ALZ created alert processing rules. To retrieve the Alert Processing Rule resource ID, navigate to the ***Monitor*** page, click on ***Alert Processing Rule***, click on the identified action group, in the ***Overview*** page that will load click on ***JSON View*** and copy the value of the Resource ID field.

    ![Alert Processing Rules](../../../media/AlertProcessingRule_ResourceID_1.png)

    ![Selected lert processing rule](../../../media/AlertProcessingRule_ResourceID_2.png)

    ![Alert Processing Rule JSON View ID](../../../media/AlertProcessingRule_ResourceID_3.png)

    ![Alert Processing Rule Resource ID](../../../media/AlertProcessingRule_ResourceID_4.png)

  {{< hint type=note >}}
  You can use multiple email addresses, ARM Roles, Webhooks, or Event Hubs (though using multiple Event Hubs is not recommended as per ALZ guidance). If you set multiple entries, ensure they are entered as a single string with values separated by commas. For example:

  ```json
  "ALZMonitorActionGroupEmail": {
      "value": [
          "action1@contoso.com",
          "action2@contoso.com"
      ]
  },
  "ALZArmRoleId": {
      "value": [
          "8e3af657-a8ff-443c-a75c-2fe8c4bcb635",
          "b24988ac-6180-42a0-ab88-20f7382dd24c"
      ]
  },
  "ALZWebhookServiceUri": {
      "value": [
          "https://webookURI1.webook.com",
          "http://webookURI2.webook.com"
      ]
  }
  ```

  {{< /hint >}}

  To disable initiative assignments, set the value of any of the following parameters to **"No"**: _```enableAMBAConnectivity```_, _```enableAMBAIdentity```_, _```enableAMBAManagement```_, _```enableAMBAServiceHealth```_, _```enableAMBANotificationAssets```_, _```enableAMBAHybridVM```_, _```enableAMBAKeyManagement```_, _```enableAMBALoadBalancing```_, _```enableAMBANetworkChanges```_, _```enableAMBARecoveryServices```_, _```enableAMBAStorage```_, _```enableAMBAVM```_, or _```enableAMBAWeb```_.

### If you are aligned to ALZ

- Set the _```platformManagementGroup```_ parameter to the management group ID designated for Platform.
- Set the _```IdentityManagementGroup```_ parameter to the management group ID designated for Identity.
- Set the _```managementManagementGroup```_ parameter to the management group ID designated for Management.
- Set the _```connectivityManagementGroup```_ parameter to the management group ID designated for Connectivity.
- Set the _```LandingZoneManagementGroup```_ parameter to the management group ID designated for Landing Zones.

### If you are unaligned to ALZ

- Set the _```platformManagementGroup```_ parameter to the management group ID designated for Platform. This ID may be used multiple times.
- Set the _```IdentityManagementGroup```_ parameter to the management group ID designated for Identity. This ID may be used multiple times.
- Set the _```managementManagementGroup```_ parameter to the management group ID designated for Management. This ID may be used multiple times.
- Set the _```connectivityManagementGroup```_ parameter to the management group ID designated for Connectivity. This ID may be used multiple times.
- Set the _```LandingZoneManagementGroup```_ parameter to the management group ID designated for Landing Zones. This ID may be used multiple times.

{{< hint type=note >}}
For streamlined deployment and maintenance, we have retained the same variable names. For instance, if you have consolidated Identity, Management, and Connectivity into a single management group, configure the variables _```identityManagementGroup```_, _```managementManagementGroup```_, _```connectivityManagementGroup```_, and _```LZManagementGroup```_ with the same management group ID.
{{< /hint >}}

### If you have a single management group

- Set the value of _```platformManagementGroup```_ to the pseudo root management group ID, also known as the "Intermediate Root Management Group".
- Set the value of _```IdentityManagementGroup```_ to the pseudo root management group ID, also known as the "Intermediate Root Management Group".
- Set the value of _```managementManagementGroup```_ to the pseudo root management group ID, also known as the "Intermediate Root Management Group".
- Set the value of _```connectivityManagementGroup```_ to the pseudo root management group ID, also known as the "Intermediate Root Management Group".
- Set the value of _```LandingZoneManagementGroup```_ to the pseudo root management group ID, also known as the "Intermediate Root Management Group".

{{< hint type=note >}}
For streamlined deployment and maintenance, we have retained the same variable names. Configure the variables _```enterpriseScaleCompanyPrefix```_, _```platformManagementGroup```_, _```identityManagementGroup```_, _```managementManagementGroup```_, _```connectivityManagementGroup```_, and _```LZManagementGroup```_ with the pseudo root management group ID.
{{< /hint >}}
