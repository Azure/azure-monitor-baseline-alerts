---
title: Exclude Management Groups and/or Subscriptions from Policy Assignment
geekdocCollapseSection: true
geekdocHidden: false
weight: 78
---

### In this page

> [Overview](../Exclude_resources_from_policy_assignment#overview) </br>
> [How this feature works](../Exclude_resources_from_policy_assignment#how-this-feature-works) </br>

## Overview

After release [2025-03-03](../../Overview/Whats-New#2025-03-03), we have made available a new set of parameters that allows you to exclude Management Groups and/or Subscriptions from policy assignments. This feature helps customers that would like to control the application of policies at scale during the deployment of the AMBA-ALZ pattern. For customers who already deployed the AMBA-ALZ pattern, it is possible to use this feature by either updating the existing deployment or manually configuring the exclusion in the existing policy assignments. A guide to perform the manual exclusion is available at [Can I exclude Management Groups or Subscriptions from policy assignment?](../../Resources/FAQ#can-i-exclude-management-groups-or-subscriptions-from-policy-assignment) in the [FAQ](../../Resources/FAQ) page. For new deployments, using the new parameters will help performing the resource(s) exclusion at scale for policy assignments. The resource format must adhere to the standard Azure resource ID format reported as following for both Management Groups and Subscriptions:

- **Management Groups** == *"/providers/Microsoft.Management/managementGroups/<<management group id>>"*
- **Subscriptions** == *"/subscriptions/<<subscription id>>"*

The parameters can be configured with more than one value, since it is expecting an array of item, and with a mix of them. Below, you can find some use case with values to be passed for the exclusion:

### Exclusion of two management groups

"value": ["/providers/Microsoft.Management/managementGroups/mgmtGrp-1", "/providers/Microsoft.Management/managementGroups/mgmtGrp-2"]

  ![Exclusion of 2 management groups](../../media/AssignmentsExclusion-1.png)

### Exclusion of two subscriptions

"value": ["/subscriptions/00000000-0000-0000-0000-000000000000", "/subscriptions/11111111-1111-1111-1111-111111111111"]

![Exclusion of 2 subscriptions](../../media/AssignmentsExclusion-2.png)

### Exclusion of one management group and one subscription

"value": ["/providers/Microsoft.Management/managementGroups/mgmtGrp-1", "/subscriptions/11111111-1111-1111-1111-111111111111"]

![Mixed exclusion](../../media/AssignmentsExclusion-3.png)

### Exclusion of two management groups (or more) and two subscriptions (or more)

"value": ["/providers/Microsoft.Management/managementGroups/mgmtGrp-1", "/providers/Microsoft.Management/managementGroups/mgmtGrp-2", "/subscriptions/00000000-0000-0000-0000-000000000000", "/subscriptions/11111111-1111-1111-1111-111111111111"]

![Mixed exclusion - multiple elements](../../media/AssignmentsExclusion-4.png)

During the deployment the policy, assignment will be configured with the requested exclusion.

## How this feature works

{{< hint type=Info >}}
**This feature is only available when deploying through the following methods: GitHub Actions, Azure Pipelines, Azure CLI or Azure PowerShell since the AMBA-ALZ portal experience does not require configuration of parameter file.**
{{< /hint >}}

To use this feature, customers must populate the relevant parameter file section with the ID of resources to be excluded. The section called _**policyAssignmentExclusionList**_ contains an entry for each of the policy assignments configured during the deployment with no default value.

![policyAssignmentExclusionList](../../media/AssignmentsExclusion-5.png)

Resources to be excluded can be inserted more than once on different scopes if applicable. Make sure you enter the correct resource scope under the relevant section. As already documented in the preceding section, enter the resource IDs in the correct form. You can use any of the following combinations when configuring the exclusion:

- One or more Management groups
- One or more subscriptions
- a mix of one or more management groups and one or more subscriptions

Once the parameter has been properly configured, go ahead with the deployment of the AMBA-ALZ pattern using one the following methods:

- To deploy with GitHub Actions, continue with [Deploy with GitHub Actions](../deploy/Deploy-with-GitHub-Actions)
- To deploy with Azure Pipelines, continue with [Deploy with Azure Pipelines](../deploy/Deploy-with-Azure-Pipelines)
- To deploy with Azure CLI, continue with [Deploy with Azure CLI](../deploy/Deploy-with-Azure-CLI)
- To deploy with Azure PowerShell, continue with [Deploy with PowerShell](../deploy/Deploy-with-Azure-PowerShell)

You will get policy assignments configured with the excluded resources (if any):

![Policy assignment with excluded resources](../../media/AssignmentsExclusion-6.png)
