---
title: Deploy via the Azure Portal (Preview)
weight: 30
---

[![Deploy to Azure](https://aka.ms/deploytoazurebutton)](https://aka.ms/amba/alz/portal)

## Deployment Settings Blade

![Deployment Settings Blade](../../media/PortalAccelerator/DeploymentSettings.png)

- Change the values on the Deployment Settings blade to the instructions below:
  - Choose the Management Group where you wish to deploy the policies and the initiatives. This is usually the so called "pseudo root management group", for example, in [ALZ terminology](https://learn.microsoft.com/azure/cloud-adoption-framework/ready/landing-zone/design-area/resource-org-management-groups), this would be the so called "Intermediate Root Management Group" (directly beneath the "Tenant Root Group").
  - Choose the value of _`Region`_ to specify your Azure location of choice.
  - Change the value of _`Resource group for baseline alerts`_ to the name of the resource group where the activity logs, resource health alerts, actions groups and alert processing rules will be deployed in.
  - Choose the value of _`Resource group location`_ to specify the location for said resource group.
  - Choose the value of _`Bring Your Own User Assigned Managed Identity`_ to specify if you want to bring your own user assigned managed identity for monitoring purpose.
  - Define the value of _`User Assigned Managed Identity Name`_ to specify the name of the user assigned managed identity for monitoring purpose.
  - Choose the value of _`Bring Your Own User Assigned Managed Identity Resource Id`_ to specify the resource id of the user assigned managed identity if you want to bring your own user assigned managed identity for monitoring purpose.
  - Choose the value of _`Management Subscription Id`_ to specify the subscription id where the user assigned managed identity will be created.
  - Choose the value of _`Customer Usage Selection Option`_ Microsoft can identify the deployments of the Azure Resource Manager and Bicep templates with the deployed Azure resources. Microsoft can correlate these resources used to support the deployments. Microsoft collects this information to provide the best experiences with their products and to operate their business. The telemetry is collected through customer usage attribution. The data is collected and governed by Microsoft’s privacy policies, located at the trust center.
  - Change the value of _`Resource Group Tags`_ to specify the tags to be added to said resource group.

## Management Groups Settings Blade

- Change the values on the Management Groups Settings blade to the instructions below:

![Management Groups Settings Blade](../../media/PortalAccelerator/MGSettings.png)

### If you are aligned to ALZ

- Choose the value of _`Enterprise Scale Company Management Group`_ to the management group id for Platform.
- Choose the value of _`Identity Management Group`_ to the management group id for Identity.
- Choose the value of _`Management Management Group`_ to the management group id for Management.
- Choose the value of _`Connectivity Management Group`_ to the management group id for Connectivity.
- Choose the value of _`Landing Zone Management Group`_ to the management group id for Landing Zones.

### If you are unaligned to ALZ

- Choose the value of _`Enterprise Scale Company Management Group`_ to the management group id for Platform. The same management group id may be repeated.
- Choose the value of _`Identity Management Group`_ to the management group id for Identity. The same management group id may be repeated.
- Choose the value of _`Management Management Group`_ to the management group id for Management. The same management group id may be repeated.
- Choose the value of _`Connectivity Management Group`_ to the management group id for Connectivity. The same management group id may be repeated.
- Choose the value of _`Landing Zone Management Group`_ to the management group id for Landing Zones. The same management group id may be repeated.

{{< hint type=note >}}
For ease of deployment and maintenance we have kept the same variables.
{{< /hint >}}

### If you have a single management group

- Choose the value of _`Enterprise Scale Company Management Group`_ to the pseudo root management group id, also called the "Intermediate Root Management Group".
- Choose the value of _`Identity Management Group`_ to the pseudo root management group id, also called the "Intermediate Root Management Group".
- Choose the value of _`Management Management Group`_ to the pseudo root management group id, also called the "Intermediate Root Management Group".
- Choose the value of _`Connectivity Management Group`_ to the pseudo root management group id, also called the "Intermediate Root Management Group".
- Choose the value of _`Landing Zone Management Group`_ to the pseudo root management group id, also called the "Intermediate Root Management Group".

{{< hint type=note >}}
For ease of deployment and maintenance we have kept the same variables.
{{< /hint >}}

- Change the value of _`Enable AMBA Hybrid VM`_ to _`Yes`_ This initiative deploys Azure Monitor Baseline Alerts to monitor Azure Arc-enabled Servers.
- Change the value of _`Enable AMBA Key Management`_ to _`Yes`_ This initiative deploys Azure Monitor Baseline Alerts to monitor Key Management Services such as Azure Key Vault, and Managed HSM.
- Change the value of _`Enable AMBA Load Balancing`_ to _`Yes`_ This initiative deploys Azure Monitor Baseline Alerts to monitor Load Balancing Services such as Load Balancer, Application Gateway, Traffic Manager, and Azure Front Door.
- Change the value of _`Enable AMBA Network Changes`_ to _`Yes`_ This initiative implements Azure Monitor Baseline Alerts to monitor alterations in Network Routing and Security, such as modifications to Route Tables and the removal of Network Security Groups.
- Change the value of _`Enable AMBA Recovery Services`_ to _`Yes`_ This initiative deploys Azure Monitor Baseline Alerts to monitor Recovery Services such as Azure Backup, and Azure Site Recovery.
- Change the value of _`Enable AMBA Storage`_ to _`Yes`_ This initiative deploys Azure Monitor Baseline Alerts to monitor Storage Services such as Storage accounts.
- Change the value of _`Enable AMBA VM`_ to _`Yes`_ This initiative deploys Azure Monitor Baseline Alerts to monitor Azure Virtual Machines.
- Change the value of _`Enable AMBA Web`_ to _`Yes`_ This initiative deploys Azure Monitor Baseline Alerts to monitor Web Services such as App Services.
- Change the value of _`Enable AMBA notification assets`_ to _`Yes`_ In this scenario, the deployment will Deploy notification assets for Service Health alerts and wide notifications.
- Change the value of _`Enable AMBA Service Health`_ to _`Yes`_ In this scenario, the deployment will assign the Service Health Policy Set Definition.

## Notification Settings Blade

![Notification Settings Blade](../../media/PortalAccelerator/NotificationSettings.png)

{{< hint type=note >}}
While it's technically possible to not add any notification information (no email, no ARM Role, no Logic App, etc.) it is strongly recommended to configure at least one option.
{{< /hint >}}

- Change values on the Notification Settings Blade blade to the instructions below:

  - Change the value of _`Bring Your Own Notifications (BYON)`_ to _` Yes`_ if you wish to use existing Action Groups and Alert Processing Rule. The BYON feature works by setting the necessary parameter values before running the ALZ pattern deployment. Customers have the choice to either specify one or more existing AGs and one APR or to enter target values so the AG and the APR will be created using the actions specified in the parameter file (including the option to not specify any value and creating an empty AG).
  - Change the value of _`Email contact for action group notifications`_ to the email address(es) where notifications of the alerts (including Service Health alerts) are sent to. Leave the value blank if no email notification is used.
  - Change the value of _`Webhook Service Uri`_ to the URI(s) to be used as action for the alerts (including Service Health alerts). Leave the value blank if no Webhook is used.
  - Choose the value of _`Arm Role Id`_ to the Azure Resource Manager Role(s) where notifications of the alerts (including Service Health alerts) are sent to. Leave the value blank if no Azure Resource Manager Role notification is required.
  - Change the value of _`Logicapp Resource Id`_ to the Logic app resource id to be used as action for the alerts (including Service Health alerts). Leave the value blank if no Logic app is used.
  - Change the value of _`Logicapp Callback Url`_ to the Logic app callback url of the Logic app you want to use as action for the alerts (including Service Health alerts). Leave the value blank if no Logic app is used. To retrieve the callback url you can either use the [_**Get-AzLogicAppTriggerCallbackUrl**_](https://learn.microsoft.com/en-us/powershell/module/az.logicapp/get-azlogicapptriggercallbackurl) PowerShell command or navigate to the Logic app in the Azure portal, go to _**Logic app designer**_, expand the trigger activity (_When an HTTP request is received_) and copy the value in the URL field using the 2-sheets icon.

    ![Get Logic app callback url](../../media/AMBA-LogicAppCallbackUrl.png)

  - Change the value of _`Event Hub Resource Id`_ to the Event Hubs to be used as action for the alerts (including Service Health alerts). Leave the value blank if no Event Hubs is used.
  - Change the value of _`Function Resource Id`_ to the Function resource id to be used as action for the alerts (including Service Health alerts). Leave the value blank if no Function is used.
  - Change the value of _`Function Trigger Url`_ to the Function App trigger url of the function to be used as action for the alerts (including Service Health alerts). Leave the value blank if no Function is used. To retrieve the Function App trigger url with the corresponding code, navigate to the HTTP-triggered functions in the Azure portal, go to _**Code + Test**_, select **Get function URL** from the menu top menu and copy the value in the URL field using the 2-sheets icon.

    ![Get function URL](../../media/AMBA-FunctionAppTriggerUrl.png)

  {{< hint type=note >}}
  It is possible use multiple email addresses, as well as multiple Arm Roles, Webhooks or Event Hubs (not recommended as per ALZ guidance). Should you set multiple entries, make sure they are entered as an array. Example:

  `["action1@contoso.com","action2@contoso.com","action3@contoso.com"]`

  `["https://webhookUri1.webhook.com","http://webhookUri2.webhook.com"]`

  {{< /hint >}}

## Next steps

To remediate non-compliant policies, continue with [Policy remediation](../Remediate-Policies)
