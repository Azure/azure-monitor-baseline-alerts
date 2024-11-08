---
title: Updating from release 2023-11-14
geekdocCollapseSection: true
weight: 100
---

## Post update actions

Updating from release [2023-11-14](../../../Overview/Whats-New#2023-11-14) will require running a post update script to remove the old Service Health action group(s) no longer in use.

To execute the script, follow these steps:
1. Launch PowerShell.
2. Install the **Az.ResourceGraph** module by executing the following command:
  ```powershell
  Install-Module Az.ResourceGraph
  ```
3. Navigate to the directory containing the **Start-AMBAOldArpCleanup.ps1** script.
4. Set the _**$pseudoRootManagementGroup**_ variable with the following command:

  ```powershell
  $pseudoRootManagementGroup = "The pseudo root management group id parenting the identity, management and connectivity management groups"
  ```
  1. Sign in to your Azure account using the `Connect-AzAccount` command. Ensure that the account has the necessary permissions to remove Policy Assignments, Policy Definitions, and resources at the required Management Group scope.

  2. Run the script with one of the following options:

  {{% include "PowerShell-ExecutionPolicy.md" %}}

  **Generate a list of the resource IDs which would be deleted by this script:**

  ```powershell
  ./Start-AMBAOldArpCleanup.ps1 -pseudoRootManagementGroup $pseudoRootManagementGroup -ReportOnly
  ```

  **Show output of what would happen if deletes executed:**

  ```powershell
  ./Start-AMBAOldArpCleanup.ps1 -pseudoRootManagementGroup $pseudoRootManagementGroup -WhatIf
  ```

  **Delete all resources deployed by the ALZ-Monitor IaC without prompting for confirmation:**

  ```powershell
  ./Start-AMBAOldArpCleanup.ps1 -pseudoRootManagementGroup $pseudoRootManagementGroup -Force
  ```

[Back to top of page](.)
