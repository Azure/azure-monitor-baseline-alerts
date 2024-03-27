---
title: Bring Your Own Notifications (BYON)
geekdocCollapseSection: true
weight: 61
---

# Overview

The ***Bring Your Own Notifications*** (BYON) feature, available with release [2024-04-02](../../alz/Whats-New#2024-04-02), allows brownfield customers to use their existing Action Groups (also known as AGs) and Alert Processing Rule (also known as APR) not forcing the use of notification assets deployed by both the [Notification Assets](https://raw.githubusercontent.com/Azure/azure-monitor-baseline-alerts/main/patterns/alz/policySetDefinitions/Deploy-Notification-Assets.json) initiative and the [Deploy Service Health Action Group](https://raw.githubusercontent.com/Azure/azure-monitor-baseline-alerts/main/services/Resources/subscriptions/Deploy-ServiceHealth-ActionGroups.json) policy definition present in the ALZ pattern. It also allows Brownfield customer who deployed the ALZ pattern when this feature was not available, to switch to it.

# How this feature works

The BYON feature works by setting the necessary parameter values before running the ALZ pattern deployment. Customers have the choice to either specify one or more existing AGs and one APR or to enter target values so the AG and the APR will be created using the actions specified in the parameter file (including the option to not specify any value and creating an empty AG).

Should Brownfield customers decide to use their own notification assets, it will be sufficient to enter the _AG resource IDs_ (separated by comma) and the _APR resource ID_ values in the parameter section called ***policyAssignmentParametersBYON***, leaving the ***policyAssignmentParametersNotificationAssets*** <ins>***with no values***</ins>:

  ![policyAssignmentParametersBYON section](../../alz/media/BYON_Params.png)

Differently if they decide to use the assets provided by AMBA or if they are Greenfield customers, they will just leave the policyAssignmentParametersBYON  section with no values and populate the section called ***policyAssignmentParametersNotificationAssets***:

![policyAssignmentParametersNotificationAssets section](../../alz/media/NotificationAssets_Params.png)

## Conditional deployment behavior

When running the deployment, the deployment code has conditions that control the deployment behavior according to the following  three possible cases:

A. ***Customer wants to use its own AGs with no APR***. In this scenario, the deployment we will:

- Not deploy the AMBA SH AG
- Deploy the AMBA ARP with customer's AGs in it
- Deploy SH alerts pointing to customer's AGs

B. ***Customer wants to use its own AGs and APR***. In this scenario, the deployment we will:

- Not deploy any AMBA notification AG or ARP (since it's not physically linked to any alert) assets or AMBA SH AG
- Deploy SH alerts pointing to customer's AGs

C. ***Customer does not have any AGs or APR in place and wants to leverage AMBA notification assets***. In this scenario, the deployment will:

- Deploy notification assets for SH alerts and wide notifications.

Below you can find a sample of the parameter file with the ***policyAssignmentParametersBYON*** section populated:

![policyAssignmentParametersBYON section](../../alz/media/BYON_Params_2.png)

## Switching between BYON and Notification Assets

The [conditional deployment behavior](../../alz/Bring-your-own-Notifications#conditional-deployment-behavior) discussed earlier, allows brownfield customers to switch from the initial notification assets scenario (the only one available until release [2024-03-01](../../alz/Whats-New#2024-03-01)) to the new BYON after deployment and viceversa.
Should customers decide to switch, it will be enough to:

- change the values in the parameter file to match the new need (see [How this feature works](../../alz/Bring-your-own-Notifications#how-this-feature-works))
- remove notification assets deployed by ALZ patterns. The [**Remove-AMBANotificationAssets.ps1**](https://raw.githubusercontent.com/Azure/azure-monitor-baseline-alerts/main/patterns/alz/scripts/Remove-AMBANotificationAssets.ps1) script
- redeploy the ALZ pattern
- run the remediation for both [Notification Assets](https://raw.githubusercontent.com/Azure/azure-monitor-baseline-alerts/main/patterns/alz/policySetDefinitions/Deploy-Notification-Assets.json) and [Alerting-ServiceHealth](https://raw.githubusercontent.com/Azure/azure-monitor-baseline-alerts/main/patterns/alz/policySetDefinitions/Deploy-ServiceHealth-Alerts.json) policy initiatives

The code will reconfigure the Service Health alerts to use either the customer's action groups to the ALZ pattern notification assets.
