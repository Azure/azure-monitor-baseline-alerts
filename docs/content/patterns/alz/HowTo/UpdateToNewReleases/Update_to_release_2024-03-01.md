---
title: Updating to release 2024-03-01
geekdocCollapseSection: true
weight: 100
---

## Update

Complete the activities documented in the [Steps to update to the latest release](.._index#steps-to-update-to-the-latest-release) page.

## Post update actions

Updating to release [2024-03-01](../../Whats-New#2024-03-01) will require running a post update script to remove the old Service Health action group(s) no longer in use.

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

**Get full help on script usage help:**

   ```powershell
   Get-help ./Start-AMBA-ALZ-Maintenance.ps1
   ```

   **Show output of what would happen if deletes executed:**

   ```powershell
   ./Start-AMBA-ALZ-Maintenance.ps1 -pseudoRootManagementGroup $pseudoRootManagementGroup -cleanItems NotificationAssets -WhatIf
   ```

   **Execute the script asking for confirmation before deleting the resources deployed by AMBA-ALZ:**

   ```powershell
   ./Start-AMBA-ALZ-Maintenance.ps1 -pseudoRootManagementGroup $pseudoRootManagementGroup -cleanItems NotificationAssets
   ```

   **Execute the script <ins>without</ins> asking for confirmation before deleting the resources deployed by AMBA-ALZ.**

   ```powershell
   ./Start-AMBA-ALZ-Maintenance.ps1 -pseudoRootManagementGroup $pseudoRootManagementGroup -cleanItems NotificationAssets -Confirm:$false
   ```
