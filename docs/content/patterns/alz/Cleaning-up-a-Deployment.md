---
title: Cleaning up a Deployment
geekdocCollapseSection: true
weight: 70
---

In some scenarios, it might be necessary to remove everything deployed by the AMBA-ALZ solution. The instructions below detail execution of a PowerShell script to delete all resources deployed, including:

- Metric Alerts
- Activity Log Alerts
- Policy Assignments
- Policy Definitions
- Policy Set Definitions
- Policy Assignment remediation identity role assignments
- Action Groups
- Alert Processing Rules

All resources deployed as part of the initial AMBA-ALZ deployment and the resources created dynamically by 'deploy if not exist' policies are either tagged, marked in metadata, or in description (depending on what the resource supports) with the value `_deployed_by_amba` or `_deployed_by_amba=True`. This metadata is used to execute the cleanup of deployed resources; _if it has been removed or modified the cleanup script will not include those resources_.

## Cleanup Script Execution

{{< hint type=Important >}}
It is highly recommended to **thoroughly** test the script before running on production environments. The sample scripts are not supported under any Microsoft standard support program or service. The sample scripts are provided AS IS without warranty of any kind. Microsoft further disclaims all implied warranties including, without limitation, any implied warranties of merchantability or of fitness for a particular purpose. The entire risk arising out of the use or performance of the sample scripts and documentation remains with you. In no event shall Microsoft, its authors, or anyone else involved in the creation, production, or delivery of the scripts be liable for any damages whatsoever (including, without limitation, damages for loss of business profits, business interruption, loss of business information, or other pecuniary loss) arising out of the use of or inability to use the sample scripts or documentation, even if Microsoft has been advised of the possibility of such damages.
{{< /hint >}}

### Download the script file

Execute the following instructions to download the cleanup script file. Alternatively, clone the repo from GitHub and ensure you are working from the latest version of the file by fetching the latest `main` branch.

1. Navigate the AMBA [project in GitHub](https://github.com/Azure/azure-monitor-baseline-alerts)
2. In the folder structure, browse to the `patterns/alz/scripts` directory
3. Open the **Start-AMBA-ALZ-Maintenance.ps1** script file
4. Click the **Raw** button
5. Save the open file as **Start-AMBA-ALZ-Maintenance.ps1**

### Executing the Script

1. Open PowerShell
2. Make sure the following modules are installed:
   1. **Az.Accounts**: if not installed, use the `Install-Module Az.Accounts` to install it
   2. **Az.Resources**: if not installed, use the `Install-Module Az.Resources` to install it
   3. **Az.ResourceGraph**: if not installed, use the `Install-Module Az.ResourceGraph` to install it
   4. **Az.ManagedServiceIdentity**: if not installed, use the `Install-Module Az.ManagedServiceIdentity` to install it
3. Change directory to the location of the **Start-ALZ-Maintenance.ps1** script
4. Configure the _**$pseudoRootManagementGroup**_ variable using the following command:

   ```powershell
   $pseudoRootManagementGroup = "The pseudo root management group id parenting the Platform and Landing Zones management groups"
   ```

5. Sign in to Azure with the `Connect-AzAccount` command. The account you sign in with needs to have permissions to remove all the aforementioned resources (Policy Assignments, Policy Definitions, and other resources) at the desired Management Group scope.
6. Execute the script using one of the following options:

   {{% include "PowerShell-ExecutionPolicy.md" %}}

   **Get full help on script usage help:**

   ```powershell
   Get-help ./Start-AMBA-ALZ-Maintenance.ps1
   ```

   **Show output of what would happen if deletes executed:**

   ```powershell
   ./Start-AMBA-ALZ-Maintenance.ps1 -pseudoRootManagementGroup $pseudoRootManagementGroup -cleanItems Amba-Alz -WhatIf
   ```

   **Execute the script asking for confirmation before deleting the resources deployed by AMBA-ALZ:**

   ```powershell
   ./Start-AMBA-ALZ-Maintenance.ps1 -pseudoRootManagementGroup $pseudoRootManagementGroup -cleanItems Amba-Alz
   ```

   **Execute the script <ins>without</ins> asking for confirmation before deleting the resources deployed by AMBA-ALZ.**

   ```powershell
   ./Start-AMBA-ALZ-Maintenance.ps1 -pseudoRootManagementGroup $pseudoRootManagementGroup -cleanItems Amba-Alz -Confirm:$false
   ```
