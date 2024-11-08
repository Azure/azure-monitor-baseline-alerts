---
title: Updating from release 2024-03-01
geekdocCollapseSection: true
weight: 99
---
{{< hint type=Important >}}
<ins>***No post update action required***</ins> for Greenfield or Brownfield customers that prefer to continue using notification assets deployed by the ALZ pattern code.
{{< /hint >}}

# Post update actions

If you are updating from release [2024-03-01](../../../Overview/Whats-New#2024-03-01), you may need to run a post-update script to remove the notification assets deployed by the ALZ pattern. This is necessary only if you have chosen to use existing action groups and alert processing rules. In such cases, the Service Health alerts will be reconfigured to use your action groups according to the ***Bring Your Own Notifications (BYON)*** feature.

To execute the script, follow these steps:
1. Open PowerShell.
2. Install the **Az.ResourceGraph** module if it is not already installed by running: `Install-Module Az.ResourceGraph`.
3. Navigate to the directory containing the **Remove-AMBANotificationAssets.ps1** script.
4. Set the ***$pseudoRootManagementGroup*** variable using the following command:

  ```powershell
  $pseudoRootManagementGroup = "The pseudo root management group ID parenting the identity, management and connectivity management groups"
  ```
  1. Sign in to your Azure account using the `Connect-AzAccount` command. Ensure that the account has the necessary permissions to remove Policy Assignments, Policy Definitions, and resources at the required Management Group scope.

  2. Run the script with one of the following options:

  {{% include "PowerShell-ExecutionPolicy.md" %}}

  **Generate a list of the resource IDs which would be deleted by this script:**

  ```powershell
  ./Remove-AMBANotificationAssets.ps1 -pseudoRootManagementGroup $pseudoRootManagementGroup -ReportOnly
  ```

  **Show output of what would happen if deletes executed:**

  ```powershell
  ./Remove-AMBANotificationAssets.ps1 -pseudoRootManagementGroup $pseudoRootManagementGroup -WhatIf
  ```

  **Delete notification asset resources deployed by the ALZ pattern without prompting for confirmation:**

  ```powershell
  ./Remove-AMBANotificationAssets.ps1 -pseudoRootManagementGroup $pseudoRootManagementGroup -Force
  ```

[Back to top of page](.)
