---
title: Updating to release 2025-02-05
geekdocCollapseSection: true
weight: 93
---

### In this page

> [Pre update actions](#pre-update-actions) </br>
> [Update](#update)

## Pre update actions

In this release, we have resolved an issue where a missing role assignment was preventing the successful completion of the remediation task for the Web Initiative. </br>
However, addressing this problem introduces a breaking change that does not allow an in-place update of an existing environment because the additional role assignment also requires an update of an existing assignment, generating a conflict that makes the update unsuccessful.</br>
To resolve this issue and successfully update an existing deployment, you need to remove both the existing policy and role assignments. This can be accomplished using the [Start-AMBA-ALZ-Maintenance.ps1](patterns\alz\scripts\Start-AMBA-ALZ-Maintenance.ps1) script.</br>
For instructions on running the script, refer to the documentation available on the [Clean-up AMBA-ALZ Deployment](../../Cleaning-up-a-Deployment) page, ensuring that you enter **PolicyAssignments** as the value for the ***-cleanItems*** script parameter:

```powershell
.\patterns\alz\scripts\Start-AMBA-ALZ-Maintenance.ps1 -pseudoRootManagementGroup $pseudoRootManagementGroup -cleanItems PolicyAssignment
```

  ![Remove policy and role assignments](../../../media/Remove-Policy-And-Role-Assignments.png)

## Update

Complete the activities documented in the [Steps to update to the latest release](../#steps-to-update-to-the-latest-release) page.
