---
title: Bring Your Own User Assigned Managed Identity (BYO UAMI)
geekdocCollapseSection: true
weight: 62
---

# Overview

The ***Bring Your Own User Assigned Managed Identity*** (BYO UAMI) feature, available with release [2024-06-06](../Whats-New#2024-06-06), allows both Greenfield and Brownfield customers to create a new User Assigned Managed Identityb (UAMI) during the deployment of AMBA-ALZ. It also allows Brownfield customers, who deployed the ALZ pattern when this feature wasn't available, to use any existing one by configuring a couple of paramters. Thanks to this new feature, it is now possible to query Azure Resource Graph (ARG) using the Kusto Query Language. Log-based search alerts can now be enhanced to include ARG queries looking at resource tags.

# How this feature works

The BYO UAMI feature works by creating a new UAMI in the management subscription and assiging the ***Monitoring reader*** role on the parent pseudo root Management Group. With this new feature, it is now possible to query Azure Resource Graph (ARG) using the Kusto Query Language and to enhance Log-based search alerts that can now query ARG to look at resource tags or properties. It is enough to enter the necessary parameter values before running the ALZ pattern deployment.

Should Brownfield customers decide to use their own UAMI after the initial deployment, it will be sufficient to enter the parameter values for _bringYourOwnUserAssignedManagedIdentity_ and _bringYourOwnUserAssignedManagedIdentityResourceId_, leaving the _userAssignedManagedIdentityName_ parameter at its default and the parameter _managementSubscriptionId_ with no values:

  ![UAMI resource ID](../media/alz-BYO-UAMI.png)

Once parameters are set according to your needs, redeploy the AMBA-ALZ pattern and wait for the remediation to happen. You can also start the Policy remediation manually as documented at [Remediate Policies](../deploy/Remediate-Policies).

## Conditional deployment behavior

When running the deployment, the deployment template has conditions that controls what is being deployed according to the following two scenarios:

A. ***Customers want to use existing UAMI.*** In this scenario the deployment will:

  {{< hint type=Important >}}
  When using an existing UAMI provided by the customer, the customer has to grant the UAMI the ***Monitoring Reader*** role at the pseudo root Management Group level <ins>**before running the deployment.**</ins>
  {{< /hint >}}

  - Not deploy any UAMI
  - Not assign the Monitorg Reader role
  - Set the provided existing UAMI as the identity to be used in the necessary alerts

Here's an example of the parameter file with the relevant parameter for this scenario:



B. ***Customers does not have an existing UAMI and want AMBA-ALZ to create a new one.*** In this scenario the deployment will:

{{< hint type=Info >}}
When a new UAMI is created by the deployment template, the the ***Monitoring Reader*** role is <ins>*is automatically assigned at the pseudo root Management Group level during the deployment*</ins>.
{{< /hint >}}

  - Deploy any UAMI
  - Assign the Monitorg Reader role
  - Set the provided existing UAMI as the identity to be used in the necessary alerts

## Where is it used
The [conditional deployment behavior](../../alz/Bring-your-own-Notifications#conditional-deployment-behavior) discussed earlier, allows brownfield customers to switch from the initial notification assets scenario (the only one available until release [2024-03-01](../../alz/Whats-New#2024-03-01)) to the new BYON after deployment and viceversa.
Should customers decide to switch, it will be enough to:

- change the values in the parameter file to match one of the three cases previously discussed
- redeploy the ALZ pattern
- run the remediation for both [Notification Assets](https://raw.githubusercontent.com/Azure/azure-monitor-baseline-alerts/main/patterns/alz/policySetDefinitions/Deploy-Notification-Assets.json) and [Alerting-ServiceHealth](https://raw.githubusercontent.com/Azure/azure-monitor-baseline-alerts/main/patterns/alz/policySetDefinitions/Deploy-ServiceHealth-Alerts.json) policy initiatives
- remove notification assets deployed by ALZ patterns using the [**Remove-AMBANotificationAssets.ps1**](https://raw.githubusercontent.com/Azure/azure-monitor-baseline-alerts/main/patterns/alz/scripts/Remove-AMBANotificationAssets.ps1) script (_<b>***</b> only if moving from ALZ notification assets to BYON_)

The code will reconfigure the Service Health alerts to use either the customer's action groups to the ALZ pattern notification assets according to the selected case.
