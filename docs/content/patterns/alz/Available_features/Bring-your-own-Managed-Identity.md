---
title: Bring Your Own User Assigned Managed Identity
geekdocCollapseSection: true
weight: 95
---

# Overview

The ***Bring Your Own User Assigned Managed Identity*** (BYO UAMI) feature, available with release [2024-06-05](../../Whats-New#2024-06-05), allows both Greenfield and Brownfield customers to create a new User Assigned Managed Identity (UAMI) during or after the deployment of AMBA-ALZ. It also allows Brownfield customers, who deployed the ALZ pattern when this feature wasn't available, to use any existing one by configuring a couple of parameters. Thanks to this new feature, it's now possible to query Azure Resource Graph (ARG) using the Kusto Query Language. Log-based search alerts can now be enhanced to include ARG queries looking at resource tags.

# How this feature works

The BYO UAMI feature works by creating a new UAMI in the management subscription and assigns the ***Monitoring reader*** role on the parent pseudo root Management Group. With this new feature, it's now possible to query Azure Resource Graph (ARG) using the Kusto Query Language and to enhance Log-based search alerts that can now query ARG to look at resource tags or properties. It's enough to enter the necessary parameter values before running the ALZ pattern deployment.

Should Brownfield customers decide to use their own UAMI after the initial deployment, it will be sufficient to enter the parameter values for _bringYourOwnUserAssignedManagedIdentity_ and _bringYourOwnUserAssignedManagedIdentityResourceId_, leaving the _userAssignedManagedIdentityName_ parameter at its default and the parameter _managementSubscriptionId_ with no values:

Once parameters are set according to your needs, redeploy the AMBA-ALZ pattern and wait for the remediation to happen. You can also start the Policy remediation manually as documented at [Remediate Policies](../deploy/Remediate-Policies).

## Conditional deployment behavior

The deployment template has conditions that controls what is being deployed according to the following two scenarios:

A. ***Customers want to use existing UAMI.*** In this scenario the deployment will:

{{< hint type=Important >}}
Before executing the deployment, ensure that the existing UAMI is assigned the ***Monitoring Reader*** role at the pseudo root Management Group.

It is probable that the UAMI you provide is located within the Management subscription beneath the Platform management group, whereas the Policy Assignment resides at the LandingZones management group. In this case, for the deployIfNotExists policies to have permission to assign the UAMI to the scheduled query rule, the ***Managed Identity Operator*** role must be granted to the system Managed Identity of the Initiative Assignment (```Deploy-AMBA-VM``` for the Virtual machine initiative, ```Deploy-AMBA-HybridVM``` for the Arc-enabled Servers initiative) at the UAMI scope.

{{< /hint >}}

- Not deploy any UAMI
- Not assign the _Monitoring Reader_ role
- Set the provided existing UAMI as the identity to be used in the necessary alerts

Here's a sample extract of the parameter file with the relevant parameter configuration for this scenario:

  ![Customer defined UAMI](../../media/alz-UAMI-Param-Example-1.png)

B. ***Customers does not have an existing UAMI and want AMBA-ALZ to create a new one.*** In this scenario the deployment will:

{{< hint type=Info >}}
When a new UAMI is created by the deployment template, the ***Monitoring Reader*** role is <ins>*is automatically assigned at the pseudo root Management Group level during the deployment*</ins>.
{{< /hint >}}

- Deploy any UAMI
- Assign the *Monitoring Reader* role
- Set the provided existing UAMI as the identity to be used in the necessary alerts

Here's a sample extract of the parameter file with the relevant parameter configuration for this scenario:

  ![New UAMI deployed by the template](../../media/alz-UAMI-Param-Example-2.png)

## Where is it used

This new feature is used in Log-search based alerts. At the moment of this release, there's one alert using it. The alert is part of the new ***Deploy Azure Monitor Vaseline Alerts for Hybrid VMs*** policySet added to monitor hybrid virtual machine.

![Deploy Azure Monitor Baseline Alerts for Hybrid VMs](../../media/deploy-HybridVM-Alerts.png)

{{< hint type=Info >}}
We're planning to use this feature more in the future and to include it as part of other alerts.
{{< /hint >}}

## Switching between BYO UAMI and new UAMI

The [conditional deployment behavior](../../Available_features/Bring-your-own-Managed-Identity#conditional-deployment-behavior) discussed earlier, allows brownfield customers to switch from a new created UAMI to an existing one and viceversa.
Should customers decide to switch, it will be enough to:

- Change the values in the parameter file to match one of the two scenarios previously discussed
- Redeploy the AMBA-ALZ pattern
- Run the remediation for the [Deploy Azure Monitor Baseline Alerts for Hybrid VMs](https://raw.githubusercontent.com/Azure/azure-monitor-baseline-alerts/main/patterns/alz/policySetDefinitions/Deploy-HybridVM-Alerts.json) policy initiative as documented at [Remediate Policies](../../deploy/Remediate-Policies)

The code will reconfigure the necessary alerts to use either the customer's provided UAMI or the new one created during the deployment.
