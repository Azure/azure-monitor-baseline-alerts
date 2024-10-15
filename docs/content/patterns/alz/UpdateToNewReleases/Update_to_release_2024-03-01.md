---
title: Updating to release 2024-03-01
geekdocCollapseSection: true
weight: 100
---

## Update

Complete the activities documented in the [Steps to update to the latest release](.._index#steps-to-update-to-the-latest-release) page.

## Post update actions

Updating to release [2024-03-01](../../Whats-New#2024-03-01) will require running a post update script to remove the old Service Health action group(s) no longer in use.

To run the script, follow the following instructions:

1. Open PowerShell
2. Make sure the following modules are installed:
   1. **Az.Accounts**: if not installed, use the `Install-Module Az.Accounts` to install it
   2. **Az.Resources**: if not installed, use the `Install-Module Az.Resources` to install it
3. Change directory to the location of the **Start-AMBA-ALZ-Maintenance.ps1** script
4. Configure the _**$pseudoRootManagementGroup**_ variable using the following command:

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
