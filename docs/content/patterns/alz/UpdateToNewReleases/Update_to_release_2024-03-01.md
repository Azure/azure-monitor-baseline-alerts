---
title: Updating to release 2024-03-01
geekdocCollapseSection: true
weight: 100
---

## Post update actions

Updating to release [2024-03-01](../../Whats-New#2024-03-01) will require running a post update script to remove the old Service Health action group(s) no longer in use.

  To run the script, follow the following instructions:

  1. Open PowerShell
  2. Install the **Az.ResourceGraph** module: `Install-Module Az.ResourceGraph`
  3. Change directories to the location of the **Start-AMBAOldArpCleanup.ps1** script
  4. Configure the _**$pseudoRootManagementGroup**_ variable using the following command:

  ```powershell
  $pseudoRootManagementGroup = "The pseudo root management group id parenting the Platform and Landing Zones management groups"
  ```

  1. Sign in to the Azure with the `Connect-AzAccount` command. The account you sign in as needs to have permissions to remove Policy Assignments, Policy Definitions, and resources at the wanted Management Group scope.

  2. Execute the script using one of the following options:

  {{% include "PowerShell-ExecutionPolicy.md" %}}

  **Show output of what would happen if deletes executed:**

  ```powershell
  ./Start-AMBAOldArpCleanup.ps1 -pseudoRootManagementGroup $pseudoRootManagementGroup -WhatIf
  ```

  **Execute the script asking for confirmation before deleting old Service Health action group(s) deployed by AMBA-ALZ:**

  ```powershell
  ./Start-AMBAOldArpCleanup.ps1 -pseudoRootManagementGroup $pseudoRootManagementGroup
  ```

  **Execute the script <ins>without</ins> asking for confirmation before deleting old Service Health action group(s) deployed by AMBA-ALZ.**

  ```powershell
  ./Start-AMBAOldArpCleanup.ps1 -pseudoRootManagementGroup $pseudoRootManagementGroup -Confirm:$false
  ```
