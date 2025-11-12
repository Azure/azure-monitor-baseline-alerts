---
title: Updating to release 2024-09-02
geekdocCollapseSection: true
weight: 97
---

### In this page

> [Pre update actions](#pre-update-actions) </br>
> [Update](#update) </br>

{{< hint type=Important >}}
***Updating to release [2024-09-02](../../../Overview/Whats-New#2024-09-02) from previous releases involves a breaking change. To proceed with the update, you must remove previously deployed policy definitions, policy set definitions, policy assignments, and role assignments. A script is provided to facilitate the removal of these items. <ins>***It is highly recommended to thoroughly test the script in a non-production environment before executing it in production. Alert definitions do not need to be removed as they will continue to function.***</ins>***
{{< /hint >}}

## Pre update actions

Before updating to release [2024-09-02](../../../Overview/Whats-New#2024-09-02), it is necessary to remove existing policy definitions, policy set definitions, policy assignments, and role assignments. This requirement is due to a breaking change introduced by the redefinition of certain parameters, which now provide greater flexibility in disabling policy remediation or, in some cases, alerts. Note that not all alerts can be disabled post-creation; only log-based alerts can be. While disabling the effect of policies was previously possible in AMBA-ALZ, this release ensures that all policies will respect both the ***PolicyEffect*** and ***MonitorDisable*** parameters.

The *MonitorDisable* feature has been redesigned to allow customers to specify their own existing tag and tag value instead of using a hard-coded one. Following the ALZ guidance and best practices for consistent tagging definitions, only one parameter name is allowed for the entire deployment. However, the parameter value can vary. You can specify an array of values assigned to the same parameter. For example, if you have the `Environment` tag name consistently applied to several environments such as `Production`, `Test`, `Sandbox`, etc., and you want to disable alerts for resources in both `Test` and `Sandbox`, you can now do so by configuring the parameters for the tag name and tag values as shown in the sample screenshot below (these are the default values):

![MonitorDisable* parameters](../../../media/MonitorDisableParams.png)

For a detailed description of the new or redesigned feature, refer to the [MonitorDisable parameter](../../Disabling-Policies#monitordisable-parameter) section on the [Disabling Policies](../../Disabling-Policies) page.

After removing the policy definitions, policy set definitions, policy assignments, and role assignments, and completing the deployment, execute the [Policy remediation](../../deploy/Remediate-Policies) to ensure the new alerts are created as expected.

To execute the script, follow these steps:

1. Open PowerShell.
2. Install the **Az.ResourceGraph** module if it is not already installed by running: `Install-Module Az.ResourceGraph`.
3. Navigate to the `patterns\alz\scripts` directory where the **Start-AMBAPolicyInitiativesAndAssignmentsCleanup.ps1** script is located.
4. Set the ***$pseudoRootManagementGroup*** variable with the following command:

  ```powershell
  $pseudoRootManagementGroup = "The pseudo root management group ID parenting the identity, management and connectivity management groups"
  ```

5. Sign in to Azure using the `Connect-AzAccount` command. Ensure the account has the necessary permissions to remove policy definitions, policy set definitions, policy assignments, and role assignments at the required Management Group scope.

6. Run the script with one of the following options:

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

Complete the activities documented in the [Steps to update to the latest release](../#steps-to-update-to-the-latest-release) page.
