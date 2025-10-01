---
title: Adopt the new built-in Azure Service Health policy
geekdocCollapseSection: true
geekdocHidden: false
weight: 77
---

### In this page

> [Overview](#overview) </br>
> [How this feature works](#how-this-feature-works) </br>
> [How to remove previous Service Health alerts and action groups](#how-to-remove-previous-service-health-alerts-and-action-groups) </br>

## Overview

The AMBA-ALZ team has combined with the Service Health Product team to include the Service Health Alerts capability into the Azure native experience. Thanks to this collaboration, the ***Azure Service Health Built-In Policy (Preview)***, a new built-in Azure Policy designed to simplify and scale the deployment of Service Health alerts across your Azure environment, is now available. Like its AMBA-ALZ custom policy predecessor, this policy enables customers to automatically deploy Service Health alerts across subscriptions, ensuring consistent visibility into platform-level issues that may impact workloads. Existing subscriptions can be remediated in bulk and new Azure subscriptions, created once the Policy has been assigned, will automatically be configured for receiving Service Health alerts. It is also important to note that this new policy addresses situations where customers only permit the use of built-in policies. Given all the aboves, we have decided to leverage it in place of the custom one in the AMBA-ALZ pattern.

## How this feature works

Adopting the new built-in policy is extremely easy for both new deployments or update of existing ones. With the [2025-10-01](../../Overview/Whats-New#2025-10-01) release, users can apply the updated template, which includes a new policy initiative called [Resource and Service Health initiative](../../Getting-started/Policy-Initiatives#resource-and-service-health-initiative). This new policy definition is deployed side-by-side with the old deprecated one called [Service Health initiative](../../Getting-started/Policy-Initiatives#service-health-initiative-deprecated)

For existing deployments, the update process involves two key steps:

1. Removing any existing Service Health alerts and action groups deployed by using previous AMBA-ALZ releases
2. Redeploying AMBA-ALZ using the new release. Documentation on how to update to this specific new release is available at [Update to new releases](../../HowTo/UpdateToNewReleases/Update_to_release_2025-10-01)

## How to remove previous Service Health alerts and action groups

Removing existing Service Health alerts and action groups is straightforward. We have updated the **Clean-up Script** to provide a specific option to ***only*** remove former Service Health alerts and action groups.

To use this capability, it is enough to execute the script using the following command syntax:

```powershell
./Start-AMBA-ALZ-Maintenance.ps1 -pseudoRootManagementGroup $pseudoRootManagementGroup -cleanItems LegacySH
```

For further information about the clean-up script, refer to the [Clean-up AMBA-ALZ Deployment](../Cleaning-up-a-Deployment) page or to the [Clean-up Script Execution](../Cleaning-up-a-Deployment#clean-up-script-execution) section in the same page.
