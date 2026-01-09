---
title: Adopt the new Monitoring Policy Contributor least privileged role
geekdocCollapseSection: true
geekdocHidden: false
weight: 76
---

### In this page

> [Overview](#overview) </br>
> [How this feature works](#how-this-feature-works) </br>
> [How to remove existing high-privileged role assignments](#how-to-remove-existing-high-privileged-role-assignments) </br>

## Overview

As part of the ongoing security enhancements in AMBA-ALZ, a new least privileged built-in role called "Monitoring Policy Contributor" has been introduced and used with the [2025-10-01](../../Overview/Whats-New#2025-10-01) release. This new Azure built-in role is designed to align with SFI principles by significantly reducing the security risk surface cutting down from over 6,700 unused permissions to just 6.

| Before                                                                | After                                                               |
| --------------------------------------------------------------------- | ------------------------------------------------------------------- |
| ![Unused permission before](../../media/UnusedPermissions_Before.png) | ![Unused permission after](../../media/UnusedPermissions_After.png) |

Tailored to support both AMBA-ALZ and customer-created alert policies, the role ensures operational flexibility while enforcing strict access control. This change not only simplifies permission management but also addresses overprovisioning concerns flagged by Microsoft Defender for Cloud, making such alerts less critical and improving overall compliance posture.

## How this feature works

Deploying the least privileged version of AMBA-ALZ in a clean environment is straightforward and efficient. With the [2025-10-01](../../Overview/Whats-New#2025-10-01) release, users can apply the updated template, which includes the new least privileged role, and benefit immediately from a reduced security footprint and tailored permissions. For existing deployments, the update process involves two key steps:

1. Removing any existing role assignments deployed by using previous AMBA-ALZ releases
2. Redeploying AMBA-ALZ using the new release. Documentation on how to update to this specific new release is available at [Update to new releases](../../HowTo/UpdateToNewReleases/Update_to_release_2025-10-01)

## How to remove existing high-privileged role assignments

Removing existing high-privileged role assignment is straightforward. We have updated the **Clean-up Script** to provide a specific option to ***only*** remove role assignments.

To use this capability, it is enough to execute the script using the following command syntax:

```powershell
./Start-AMBA-ALZ-Maintenance.ps1 -pseudoRootManagementGroup $pseudoRootManagementGroup -cleanItems RoleAssignments
```

For further information about the clean-up script, refer to the [Clean-up AMBA-ALZ Deployment](../Cleaning-up-a-Deployment) page or to the [Clean-up Script Execution](../Cleaning-up-a-Deployment#clean-up-script-execution) section in the same page.
