---
title: Updating to release 2025-10-01
geekdocCollapseSection: true
weight: 88
---

### In this page

> [Pre update actions](#pre-update-actions) </br>
> [Update](#update)

## Pre update actions

In this release, we have adopted:

- a new least privileged built-in Azure role called "Monitoring Policy Contributor". This role will be the default role for the System Assigned Managed Identities created the AMBA-ALZ deployment.
- a new built-in Service Health policy.

The new role allows for policy remediation task execution using less privileges compared to the previous "Contributor "role. We were able to reduce the surface of unused permission flagged by Microsft Defender for Cloud from nearly ***6750*** to just ***6***.

| Before                                                                   | After                                                                  |
| ------------------------------------------------------------------------ | ---------------------------------------------------------------------- |
| ![Unused permission before](../../../media/UnusedPermissions_Before.png) | ![Unused permission after](../../../media/UnusedPermissions_After.png) |

This enhancement does not represent a breaking change, but requires that existing role assignments (coming with the deployment of AMBA-ALZ releases prior to this one) being removed.</br>
To ease the update process and successfully align an existing deployment with the use of the least privileged role, it is possible to use the [Start-AMBA-ALZ-Maintenance.ps1](https://github.com/Azure/azure-monitor-baseline-alerts/blob/main/patterns/alz/scripts/Start-AMBA-ALZ-Maintenance.ps1) script to clean up ***only*** the existing role assignment.</br>
For instructions on running the script, refer to the documentation available on the [Clean-up AMBA-ALZ Deployment](../../Cleaning-up-a-Deployment) page, ensuring that you enter **RoleAssignments** as the value for the ***-cleanItems*** script parameter:

```powershell
.\patterns\alz\scripts\Start-AMBA-ALZ-Maintenance.ps1 -pseudoRootManagementGroup $pseudoRootManagementGroup -cleanItems RoleAssignments
```

  ![Clean up role assignment](../../../media/Clean-up-current-roleAssignments.png)

As far as the adoption of built-in Service Health alerts policy goes, it does not require any specific task. However, it is recommended to remove the old Service Health alerts and action groups created by the former custom policy to avoid confusion. To perform the clean-up of the old Service Health artifact, run the clean-up script mentioned above ensuring to enter **legacySH** as the value for the ***-cleanItems*** script parameter:

```powershell
.\patterns\alz\scripts\Start-AMBA-ALZ-Maintenance.ps1 -pseudoRootManagementGroup $pseudoRootManagementGroup -cleanItems legacySH
```

  ![Clean up legacy Service Health alerts and action groups](../../../media/Clean-up-clegacySH.png)

As always recommended when updating to a new version or release, ensure the parameter file is aligned with the latest version and with your required configuration. In this release, the parameter file had a change in the configuration of ***ALZArmRoleId***. This paramter does not accept Azure Resource Manager Role ID(s) anymore but instead it requires Azure Resource Manager Role name(s). For additional information on how to configure the Azure Resource Manager Role(s), refer to the ***Parameter Configuration*** section in each of the available deployment methods. An example can be found at [Deploy with Azure PowerShell - 1. Parameter Configuration](../../deploy/Deploy-with-Azure-PowerShell#1-parameter-configuration)

## Update

Complete the activities documented in the [Steps to update to the latest release](../#steps-to-update-to-the-latest-release) page.
