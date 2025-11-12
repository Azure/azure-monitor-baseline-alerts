---
title: Transitioning from Preview to General Availability (GA)
geekdocCollapseSection: true
weight: 101
---

### In this page

> [Prerequisites](#prerequisites) </br>
> [Cleanup Script Execution](#cleanup-script-execution) </br>
> [Next Steps](#next-steps) </br>

## Prerequisites

To transition from the preview version to the General Availability (GA) version of the ALZ Monitor solution, you must remove all previously deployed resources. Follow these instructions to execute a PowerShell script that deletes the following resources:

- Metric Alerts
- Activity Log Alerts
- Policy Assignments
- Policy Definitions
- Policy Set Definitions
- Policy Assignment remediation identity role assignments
- Action Groups
- Alert Processing Rules

All resources deployed by the ALZ Monitor solution, including those created dynamically by 'deploy if not exist' policies, are tagged or marked with `_deployed_by_alz_monitor` or `_deployed_by_alz_monitor=True`. This metadata is essential for the cleanup script to identify and remove the resources. If this metadata has been altered or removed, the script will not recognize those resources for deletion.

## Cleanup Script Execution

{{< hint type=Important >}}
It is strongly recommended to **thoroughly** test the script in a non-production environment before deploying it to production. These sample scripts are not covered by any Microsoft standard support program or service. They are provided "AS IS" without any warranty, express or implied. Microsoft disclaims all implied warranties, including but not limited to, implied warranties of merchantability or fitness for a particular purpose. The user assumes all risks associated with the use or performance of the sample scripts and documentation. Microsoft, its authors, or any contributors to the creation, production, or delivery of the scripts shall not be liable for any damages, including but not limited to, loss of business profits, business interruption, loss of business information, or other financial losses, arising from the use or inability to use the sample scripts or documentation, even if Microsoft has been advised of the possibility of such damages.
{{< /hint >}}

### Download the Script File

Follow these steps to download the cleanup script file. Alternatively, you can clone the repository from GitHub and ensure you have the latest version by fetching the `main` branch.

1. Navigate to the [AMBA project on GitHub](https://aka.ms/amba/repo).
2. Browse to the `patterns/alz/scripts/old-scripts` directory.
3. Locate and open the **Start-ALZMonitorCleanup.ps1** script file.
4. Click on the **Raw** button to view the raw content of the script.
5. Save the file as **Start-ALZMonitorCleanup.ps1**.

### Executing the Script

1. Launch PowerShell.
2. Install the **Az.ResourceGraph** module by running: `Install-Module Az.ResourceGraph`.
3. Navigate to the directory containing the **Start-ALZMonitorCleanup.ps1** script.
4. Sign in to Azure using the `Connect-AzAccount` command. Ensure the account has the necessary permissions to remove Policy Assignments, Policy Definitions, and resources at the required Management Group scope.
5. Execute the script with one of the following options:

  {{% include "PowerShell-ExecutionPolicy.md" %}}

  **Generate a list of the resource IDs that would be deleted by this script:**

  ```powershell
  ./Start-ALZMonitorCleanup.ps1 -ReportOnly
  ```

  **Show output of what would happen if deletes were executed:**

  ```powershell
  ./Start-ALZMonitorCleanup.ps1 -WhatIf
  ```

  **Delete all resources deployed by the ALZ-Monitor IaC without prompting for confirmation:**

  ```powershell
  ./Start-ALZMonitorCleanup.ps1 -Force
  ```

## Next Steps

- For customizing policy assignments, refer to [Customize Policy Assignment](../../deploy/Customize-Policy-Assignment).
- For deplyment using Azure Portal, refer to [Deploy via the Azure Portal Accelerator](../../deploy/Deploy-via-Azure-Portal-UI)  (recommended method)
- For deployment using GitHub Actions, refer to [Deploy with GitHub Actions](../../deploy/Deploy-with-GitHub-Actions).
- For deployment using Azure DevOps Pipelines, refer to [Deploy with Azure Pipelines](../../deploy/Deploy-with-Azure-Pipelines).
- For deployment using Azure CLI, refer to [Deploy with Azure CLI](../../deploy/Deploy-with-Azure-CLI).
- For deployment using Azure PowerShell, refer to [Deploy with Azure PowerShell](../../deploy/Deploy-with-Azure-PowerShell).
