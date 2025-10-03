---
title: Updating to release 2024-04-12
geekdocCollapseSection: true
weight: 99
---

### In this page

> [Update](#update) </br>
> [Post update actions](#post-update-actions) </br>

{{< hint type=Important >}}
**_No post-update action_** is required if you wish to continue using the notification assets deployed by the ALZ pattern.
{{< /hint >}}

## Update

Complete the activities documented in the [Steps to update to the latest release](../#steps-to-update-to-the-latest-release) page.

## Post update actions

If you are updating to release [2024-04-12](../../../Overview/Whats-New#2024-04-12), you may need to run a post-update script to remove the notification assets deployed by the ALZ pattern. This is necessary only if you have chosen to use existing action groups and alert processing rules. In such cases, the Service Health alerts will be reconfigured to use your action groups according to the ***Bring Your Own Notifications (BYON)*** feature.

To execute the script, follow these steps:

1. Open PowerShell.
2. Install the **Az.ResourceGraph** module if it is not already installed by running: `Install-Module Az.ResourceGraph`.
3. Navigate to the directory containing the **Remove-AMBANotificationAssets.ps1** script.
4. Set the ***$pseudoRootManagementGroup*** variable using the following command:

  ```powershell
  $pseudoRootManagementGroup = "The pseudo root management group ID parenting the identity, management and connectivity management groups"
  ```

5. Sign in to your Azure account using the `Connect-AzAccount` command. Ensure that the account has the necessary permissions to remove Policy Assignments, Policy Definitions, and resources at the required Management Group scope.

6. Run the script with one of the following options:

  {{% include "PowerShell-ExecutionPolicy.md" %}}

  **Show output of what would happen if deletes executed:**

   ```powershell
   ./Remove-AMBANotificationAssets.ps1 -pseudoRootManagementGroup $pseudoRootManagementGroup -WhatIf
   ```

   **Execute the script asking for confirmation before deleting notification asset resources deployed by AMBA-ALZ:**

   ```powershell
   ./Remove-AMBANotificationAssets.ps1 -pseudoRootManagementGroup $pseudoRootManagementGroup
   ```

   **Execute the script <ins>without</ins> asking for confirmation before deleting notification asset resources deployed by AMBA-ALZ.**

   ```powershell
   ./Remove-AMBANotificationAssets.ps1 -pseudoRootManagementGroup $pseudoRootManagementGroup -Confirm:$false
   ```
