---
title: Updating to release 2024-04-12
geekdocCollapseSection: true
weight: 99
---

{{< hint type=Important >}}
**_No post-update action_** is required if you wish to continue using the notification assets deployed by the ALZ pattern.
{{< /hint >}}

## Update

Complete the activities documented in the [Steps to update to the latest release](.._index#steps-to-update-to-the-latest-release) page.

## Post update actions

Updating to release [2024-04-12](../../Whats-New#2024-04-12) might require running a post update script to remove the notification assets deployed by ALZ pattern <ins>**_if and only if_**</ins> customer decided to use existing action groups and alert processing rule. In this case, the Service Health alerts will be reconfigured to use the customer' action groups as per the _**B**ring **Y**our **O**wn **N**otifications_ (BYON) feature.

To run the script, complete the following step:

1. Open PowerShell
2. Install the **Az.ResourceGraph** module: `Install-Module Az.ResourceGraph` (if not present)
3. Change directories to the location of the **Remove-AMBANotificationAssets.ps1** script
4. Configure the **_$pseudoRootManagementGroup_** variable using the command below:

   ```powershell
   $pseudoRootManagementGroup = "The pseudo root management group id parenting the Platform and Landing Zones management groups"
   ```

5. Sign in to the Azure with the `Connect-AzAccount` command. The account you sign in as needs to have permissions to remove Policy Assignments, Policy Definitions, and resources at the desired Management Group scope.

6. Execute the script using one of the options below:

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
