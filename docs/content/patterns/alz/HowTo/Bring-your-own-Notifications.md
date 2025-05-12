---
title: Bring Your Own Notifications
geekdocCollapseSection: true
weight: 95
---

### In this page

> [Overview](#overview) </br>
> [How this feature works](#how-this-feature-works) </br>
> [Conditional deployment behavior](#conditional-deployment-behavior) </br>

## Overview

The ***Bring Your Own Notifications*** (BYON) feature, introduced in the [2024-04-12](../../Overview/Whats-New#2024-04-12) release, enables brownfield customers to utilize their existing Action Groups (AGs) and Alert Processing Rules (APRs) without mandating the use of notification assets deployed by the [Notification Assets](https://raw.githubusercontent.com/Azure/azure-monitor-baseline-alerts/main/patterns/alz/policySetDefinitions/Deploy-Notification-Assets.json) initiative or the [Deploy Service Health Action Group](https://raw.githubusercontent.com/Azure/azure-monitor-baseline-alerts/main/services/Resources/subscriptions/Deploy-ServiceHealth-ActionGroups.json) policy definition in the ALZ pattern. This feature also allows brownfield customers who deployed the ALZ pattern before this feature was available to switch to it.

## How this feature works

The BYON feature operates by setting the necessary parameter values before deploying the ALZ pattern. Customers can either specify existing AGs and one APR or provide target values to create the AG and APR using the actions specified in the parameter file. If no values are specified, an empty AG will be created.

For brownfield customers opting to use their own notification assets, they need to enter the *AG resource IDs* and the *APR resource ID* in the parameters ***BYOActionGroup*** and ***BYOAlertProcessingRule***, respectively, while leaving the parameters ***ALZMonitorActionGroupEmail***, ***ALZLogicappResourceId***, ***ALZLogicappCallbackUrl***, ***ALZArmRoleId***, ***ALZEventHubResourceId***, ***ALZWebhookServiceUri***, ***ALZFunctionResourceId***, and ***ALZFunctionTriggerUrl*** empty:

![policyAssignmentParametersBYON section](../../media/BYON_Params_3.png)

Conversely, if they choose to use the assets provided by AMBA-ALZ or if they are greenfield customers, they should leave the ***BYOActionGroup*** and ***BYOAlertProcessingRule*** parameters empty and populate the other parameters (***ALZMonitorActionGroupEmail***, ***ALZLogicappResourceId***, ***ALZLogicappCallbackUrl***, ***ALZArmRoleId***, ***ALZEventHubResourceId***, ***ALZWebhookServiceUri***, ***ALZFunctionResourceId***, and ***ALZFunctionTriggerUrl***):

![policyAssignmentParametersNotificationAssets section](../../media/NotificationAssets_Params_2.png)

{{< hint type=Note >}}
The steps for retrieving the resource ID for the notification type is documented in the ***Parameter Configuration*** paragraph present in one of the following deployment guides:

- For deploying with GitHub Actions, refer to [Deploy with GitHub Actions](../../HowTo/deploy/Deploy-with-GitHub-Actions).
- For deploying with Azure Pipelines, refer to [Deploy with Azure Pipelines](../../HowTo/deploy/Deploy-with-Azure-Pipelines).
- For deploying with Azure CLI, refer to [Deploy with Azure CLI](../../HowTo/deploy/Deploy-with-Azure-CLI).
- For deploying with Azure PowerShell, refer to [Deploy with Azure PowerShell](../../HowTo/deploy/Deploy-with-Azure-PowerShell).
{{< /hint >}}

## Conditional deployment behavior

The deployment code includes conditions that control the deployment behavior based on the following scenarios:

A. ***Use your own AGs with the AMBA APR***:

- Does not deploy the AMBA SH AG.
- Deploys the AMBA APR with the customer's AGs.
- Deploys SH alerts pointing to the customer's AGs.

Example parameter file for this scenario:

![policyAssignmentParametersBYON section](../../media/BYON_Params_2.png)

B. ***Use your own AGs and APR***:

- Does not deploy any AMBA notification AG or APR assets or AMBA SH AG.
- Deploys SH alerts pointing to the customer's AGs.

Example parameter file for this scenario:

![policyAssignmentParametersBYON section](../../media/BYON_Params_3.png)

C. ***Use AMBA notification assets***:

- Deploys notification assets for SH alerts and wide notifications

Example parameter file for this scenario:

![policyAssignmentParametersNotificationAssets section](../../media/NotificationAssets_Params_2.png)

## Switching between BYON and Notification Assets

The [conditional deployment behavior](../Bring-your-own-Notifications#conditional-deployment-behavior) allows brownfield customers to switch from the initial notification assets scenario (available until the [2024-03-01](../../Overview/Whats-New#2024-03-01) release) to the new BYON feature and vice versa.

To switch, customers need to:

- Update the parameter file to match one of the three scenarios discussed.
- Redeploy the ALZ pattern.
- Run the remediation for both [Notification Assets](https://raw.githubusercontent.com/Azure/azure-monitor-baseline-alerts/main/patterns/alz/policySetDefinitions/Deploy-Notification-Assets.json) and [Alerting-ServiceHealth](https://raw.githubusercontent.com/Azure/azure-monitor-baseline-alerts/main/patterns/alz/policySetDefinitions/Deploy-ServiceHealth-Alerts.json) policy initiatives.
- Remove notification assets deployed by ALZ patterns using the [**Start-AMBA-ALZ-Maintenance.ps1**](https://raw.githubusercontent.com/Azure/azure-monitor-baseline-alerts/main/patterns/alz/scripts/Start-AMBA-ALZ-Maintenance.ps1) script (*<b>***</b> only if moving from ALZ notification assets to BYON*)

The code will reconfigure the Service Health alerts to use either the customer's action groups or the ALZ pattern notification assets based on the selected scenario.
