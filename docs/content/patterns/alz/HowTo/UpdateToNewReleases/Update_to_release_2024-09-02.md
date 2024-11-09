---
title: Updating to release 2024-09-02
geekdocCollapseSection: true
weight: 97
---

{{< hint type=Important >}}
**_Updating to release [2024-09-02](../../Whats-New#2024-09-02) from previous releases, contains a breaking change. To perform the update, it's required to remove previously deployed policy definitions, policy set definitions, policy assignments and role assignments. It isn't necessary to remove alert definitions that will continue to work in the meantime._**</ins>
{{< /hint >}}

## Pre update actions

Before updating to release [2024-09-02](../../Whats-New#2024-09-02), it's required to remove existing policy definitions, policy set definitions, policy assignments and role assignments. This action is required because of a breaking change caused by the redefinition of some parameters, which allows for more flexibility in disabling the policy remediation or, in some cases, the alerts. Unfortunately not all the alerts can be disabled after creation; only log-based alerts can be. Even if disabling the effect of policy was already possible in AMBA-ALZ, with this release we made sure that all the policies will honor both the **_PolicyEffect_** and the **_MonitorDisable_** parameters.

In particular, the _MonitorDisable_ feature has been redesigned to allow customer to specify they own existing tag and tag value instead of forcing a hard coded one. Given the ALZ guidance and the best practice of having a consistent tagging definition, it's only allowed to one parameter name fo r the entire deployment. Instead, parameter value can be different. You can specify an array of values assigned to the same parameter. For instance, you have the `Environment` tag name consistently applied to several environments, saying `Production`, `Test`, `Sandbox`, and so on, and you want to disable alerts for resources, which are in both `Test` and `Sandbox`. Now it's possible by just configuring the parameters for tag name and tag values as reported in the sample screenshot (these are the default values) below:

![MonitorDisable* parameters](../../media/MonitorDisableParams.png)

Complete description of this new/redesigned feature can be found in the [MonitorDisable parameter](../../Disabling-Policies#monitordisable-parameter) paragraph inside the [Disabling Policies](../../Disabling-Policies) page.

Once the policy definitions, policy set definitions, policy assignments and role assignments are removed and the deployment is completed, the execution of [Policy remediation](../../deploy/Remediate-Policies) will ensure that the new alerts will be created accordingly.

To run the script, complete the following steps:

1. Open PowerShell
2. Make sure the following modules are installed:
   1. **Az.Accounts**: if not installed, use the `Install-Module Az.Accounts` to install it
   2. **Az.Resources**: if not installed, use the `Install-Module Az.Resources` to install it
3. Change directory to the location of the **Start-AMBA-ALZ-Maintenance.ps1** script
4. Configure the **_$pseudoRootManagementGroup_** variable using the following command:

   ```powershell
   $pseudoRootManagementGroup = "The pseudo root management group id parenting the Platform and Landing Zones management groups"
   ```

5. Sign in to Azure with the `Connect-AzAccount` command. The account you sign in with needs to have permissions to all the aforementioned resources (Policy Assignments, Policy Definitions, and other resources) at the desired Management Group scope.
6. Execute the script using one of the following options:

   {{% include "PowerShell-ExecutionPolicy.md" %}}

   **Get full help on script usage help:**

   ```powershell
   Get-help ./Start-AMBA-ALZ-Maintenance.ps1
   ```

   **Show output of what would happen if deletes executed:**

   ```powershell
   ./Start-AMBA-ALZ-Maintenance.ps1 -pseudoRootManagementGroup $pseudoRootManagementGroup -cleanItems PolicyAssignments -WhatIf
   ```

   **Execute the script asking for confirmation before deleting the resources deployed by AMBA-ALZ:**

   ```powershell
   ./Start-AMBA-ALZ-Maintenance.ps1 -pseudoRootManagementGroup $pseudoRootManagementGroup -cleanItems PolicyAssignments
   ```

   **Execute the script <ins>without</ins> asking for confirmation before deleting the resources deployed by AMBA-ALZ.**

   ```powershell
   ./Start-AMBA-ALZ-Maintenance.ps1 -pseudoRootManagementGroup $pseudoRootManagementGroup -cleanItems PolicyAssignments -Confirm:$false
   ```

7. Repeat the command passing the **_PolicyDefinitions_** parameter to clean up policy definitions and policy initiatives.

## Update

Complete the activities documented in the [Steps to update to the latest release](.._index#steps-to-update-to-the-latest-release) page.
