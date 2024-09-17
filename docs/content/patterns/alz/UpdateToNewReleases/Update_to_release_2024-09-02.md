---
title: Updating to release 2024-09-02
geekdocCollapseSection: true
weight: 97
---
{{< hint type=Important >}}
***Updating to release [2024-09-02](../../Whats-New#2024-09-02) from previous releases, contains a breaking change. To perform the update, it's required to remove previously deployed policy definitions, policy set definitions, policy assignments and role assignments. As part of this release we made a script available to clean all the necessary items. <ins>***It's strongly recommended that you test the script thoroughly before running on production environment. It isn't necessary to remove alert definitions that will continue to work in the meantime.***</ins>
{{< /hint >}}

# Pre update actions

Before updating to release [2024-09-02](../../Whats-New#2024-09-02), it's required to remove existing policy definitions, policy set definitions, policy assignments and role assignments. This action is required because of a breaking change caused by the redefinition of some parameters, which allows for more flexibility in disabling the policy remediation or, in some cases, the alerts. Unfortunately not all the alerts can be disabled after creation; only log-based alerts can be. Even if disabling the effect of policy was already possible in AMBA-ALZ, with this release we made sure that all the policies will honor both the ***PolicyEffect*** and the ***MonitorDisable*** parameters.

In particular, the *MonitorDisable* feature has been redesigned to allow customer to specify they own existing tag and tag value instead of forcing a hard coded one. Given the ALZ guidance and the best practice of having a consistent tagging definition, it's only allowed to one parameter name fo r the entire deployment. Instead, parameter value can be different. You can specify an array of values assigned to the same parameter. For instance, you have the ```Environment``` tag name consistently applied to several environments, saying ```Production```, ```Test```, ```Sandbox```, and so on and you want to disable alerts for resources, which are in both ```Test``` and ```Sandbox```. Now it's possible by just configuring the parameters for tag name and tag values as reported in the sample screenshot (these are the default values) below:

![MonitorDisable* parameters](../../media/MonitorDisableParams.png)

Complete description of this new/redesigned feature can be found in the [MonitorDisable parameter](../../Disabling-Policies#monitordisable-parameter) paragraph inside the [Disabling Policies](../../Disabling-Policies) page.

Once the policy definitions, policy set definitions, policy assignments and role assignments are removed and the deployment is completed, the execution of [Policy remediation](../../deploy/Remediate-Policies) will ensure that the new alerts will be created accordingly.

To run the script, complete the following steps:

  1. Open PowerShell
  2. Install the **Az.ResourceGraph** module: `Install-Module Az.ResourceGraph` (if not present)
  3. Change directory to `patterns\alz\scripts`, there you find the **Start-AMBAPolicyInitiativesAndAssignmentsCleanup.ps1** script
  4. Configure the ***$pseudoRootManagementGroup*** variable using the following command:

  ```powershell
  $pseudoRootManagementGroup = "The pseudo root management group id parenting the Platform and Landing Zones management groups"
  ```

  1. Sign in to the Azure with the `Connect-AzAccount` command. The account you sign in as needs to have permissions to remove policy definitions, policy set definitions, policy assignments and role assignments at the desired Management Group scope.

  2. Execute the script using one of the following options:

  {{% include "PowerShell-ExecutionPolicy.md" %}}

  **Show output of what would happen if deletes executed:**

  ```powershell
  ./Start-AMBAPolicyInitiativesAndAssignmentsCleanup.ps1 -pseudoRootManagementGroup $pseudoRootManagementGroup -WhatIf
  ```

  **Execute the script asking for confirmation before deleting the policy definitions, policy set definitions, policy assignments and role assignments deployed by AMBA-ALZ:**

  ```powershell
  ./Start-AMBAPolicyInitiativesAndAssignmentsCleanup.ps1 -pseudoRootManagementGroup $pseudoRootManagementGroup
  ```

  **Execute the script <ins>without</ins> asking for confirmation before deleting the policy definitions, policy set definitions, policy assignments and role assignments deployed by AMBA-ALZ.**

  ```powershell
  ./Start-AMBAPolicyInitiativesAndAssignmentsCleanup.ps1 -pseudoRootManagementGroup $pseudoRootManagementGroup -Confirm:$false
  ```
