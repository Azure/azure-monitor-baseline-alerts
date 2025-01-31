---
title: Bring Your Own User Assigned Managed Identity
geekdocCollapseSection: true
weight: 90
---

### In this page

> [Overview](../Bring-your-own-Managed-Identity#overview) </br>
> [How this feature works](../Bring-your-own-Managed-Identity#how-this-feature-works) </br>

## Overview

The ***Bring Your Own User Assigned Managed Identity*** (BYO UAMI) feature, introduced in the [2024-06-05 release](../../Overview/Whats-New#2024-06-05), allows both Greenfield and Brownfield customers to create a new User Assigned Managed Identity (UAMI) during or after the deployment of AMBA-ALZ. Brownfield customers who deployed the ALZ pattern before this feature was available can now configure existing UAMIs by setting a few parameters. This feature enables querying Azure Resource Graph (ARG) using Kusto Query Language and enhances log-based search alerts to include ARG queries for resource tags.

## How this feature works

The BYO UAMI feature creates a new UAMI in the management subscription and assigns the ***Monitoring Reader*** role to the parent pseudo root Management Group. This enables querying Azure Resource Graph (ARG) using Kusto Query Language and enhances log-based search alerts to query ARG for resource tags or properties. To use this feature, enter the necessary parameter values before deploying the ALZ pattern.

For Brownfield customers wanting to use their own UAMI after initial deployment, set the parameters _bringYourOwnUserAssignedManagedIdentity_ and _bringYourOwnUserAssignedManagedIdentityResourceId_, leaving _userAssignedManagedIdentityName_ at its default and _managementSubscriptionId_ with no values:

After setting the parameters, redeploy the AMBA-ALZ pattern and wait for remediation. Manual Policy remediation can also be initiated as documented in [Remediate Policies](../deploy/Remediate-Policies).

### Conditional deployment behavior

The deployment template includes conditions that control deployment based on two scenarios:

A. ***Using an existing UAMI.*** In this scenario, the deployment will:

{{< hint type=Important >}}
Before deployment, ensure the existing UAMI is assigned the ***Monitoring Reader*** role at the pseudo root Management Group.

If the UAMI is within the Management subscription under the Platform management group, and the Policy Assignment is at the LandingZones management group, grant the ***Managed Identity Operator*** role to the system Managed Identity of the Initiative Assignment (```Deploy-AMBA-VM``` for Virtual machine initiative, ```Deploy-AMBA-HybridVM``` for Arc-enabled Servers initiative) at the UAMI scope.
{{< /hint >}}

- Not deploy any UAMI
- Not assign the _Monitoring Reader_ role
- Use the provided existing UAMI for necessary alerts

Sample parameter file configuration for this scenario:

  ![Customer defined UAMI](../../media/alz-UAMI-Param-Example-1.png)

B. ***Creating a new UAMI.*** In this scenario, the deployment will:

{{< hint type=Info >}}
When a new UAMI is created by the deployment template, the ***Monitoring Reader*** role is <ins>*automatically assigned at the pseudo root Management Group level during deployment*</ins>.
{{< /hint >}}

- Deploy a new UAMI
- Assign the *Monitoring Reader* role
- Set the provided UAMI as the identity to be used in the necessary alerts

Sample parameter file configuration for this scenario:

  ![New UAMI deployed by the template](../../media/alz-UAMI-Param-Example-2.png)

### Usage

This feature is currently used in log-search based alerts which are mostly included in the following policy initiatives:

- Deploy Azure Monitor Baseline Alerts for Azure Virtual Machines
- Deploy Azure Monitor Baseline Alerts for Hybrid Virtual Machines

![Deploy Azure Monitor Baseline Alerts for Hybrid VMs](../../media/deploy-HybridVM-Alerts.png)

{{< hint type=Info >}}
This feature could be expanded to other alerts in the future.
{{< /hint >}}

### Switching between BYO UAMI and new UAMI

The [conditional deployment behavior](../Bring-your-own-Managed-Identity#conditional-deployment-behavior) allows Brownfield customers to switch between a newly created UAMI and an existing one. To switch:

- Update the parameter file values to match one of the discussed scenarios
- Redeploy the AMBA-ALZ pattern
- Run remediation as documented in [Remediate Policies](../deploy/Remediate-Policies)

The code will reconfigure alerts to use either the provided UAMI or the newly created one.
