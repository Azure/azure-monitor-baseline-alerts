---
title: Updating from release 2023-11-14
geekdocCollapseSection: true
weight: 100
---

## Post update actions

Updating from release 2023-11-14 will require running a post update script to remove the old Service Health action group(s) no longer in use.

  To run the script, follow the instructions below:

  1. Open PowerShell
  2. Install the **Az.ResourceGraph** module: `Install-Module Az.ResourceGraph`
  3. Change directories to the location of the **Start-AMBAOldArpCleanup.ps1** script
  4. Configure the _**$pseudoRootManagementGroup**_ variable using the command below:

  ```powershell
  $pseudoRootManagementGroup = "The pseudo root management group id parenting the identity, management and connectivity management groups"
  ```

  1. Sign in to the Azure with the `Connect-AzAccount` command. The account you sign in as needs to have permissions to remove Policy Assignments, Policy Definitions, and resources at the desired Management Group scope.

  2. Execute the script using one of the options below:

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
