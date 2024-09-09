---
title: Moving from preview to GA
geekdocCollapseSection: true
weight: 101
---

When moving from the preview version to GA, it is required to remove everything deployed by the ALZ Monitor solution. The instructions below detail execution of a PowerShell script to delete all resources deployed, including:

- Metric Alerts
- Activity Log Alerts
- Resource Groups (created for to contain alert resources)
- Policy Assignments
- Policy Definitions
- Policy Set Definitions
- Policy Assignment remediation identity role assignments

All resources deployed as part of the initial ALZ Monitor deployment and the resources created dynamically by 'deploy if not exist' policies are either tagged, marked in metadata, or in description (depending on what the resource supports) with the value `_deployed_by_alz_monitor` or `_deployed_by_alz_monitor=True`. This metadata is used to execute the cleanup of deployed resources; _if it has been removed or modified the cleanup script will not include those resources_.

## Cleanup Script Execution

{{< hint type=Important >}}
It is highly recommended to **thoroughly** test the script before running on production environments. The sample scripts are not supported under any Microsoft standard support program or service. The sample scripts are provided AS IS without warranty of any kind. Microsoft further disclaims all implied warranties including, without limitation, any implied warranties of merchantability or of fitness for a particular purpose. The entire risk arising out of the use or performance of the sample scripts and documentation remains with you. In no event shall Microsoft, its authors, or anyone else involved in the creation, production, or delivery of the scripts be liable for any damages whatsoever (including, without limitation, damages for loss of business profits, business interruption, loss of business information, or other pecuniary loss) arising out of the use of or inability to use the sample scripts or documentation, even if Microsoft has been advised of the possibility of such damages.
{{< /hint >}}

### Download the script file

Follow the instructions below to download the cleanup script file. Alternatively, clone the repo from GitHub and ensure you are working from the latest version of the file by fetching the latest `main` branch.

1. Navigate AMBA [project in GitHub](https://github.com/Azure/azure-monitor-baseline-alerts)
2. In the folder structure, browse to the `patterns/alz/scripts` directory
3. Open the **Start-ALZMonitorCleanup.ps1** script file
4. Click the **Raw** button
5. Save the open file as **Start-ALZMonitorCleanup.ps1**

### Executing the Script

1. Open PowerShell
2. Install the **Az.ResourceGraph** module: `Install-Module Az.ResourceGraph`
3. Change directories to the location of the **Start-ALZMonitorCleanup.ps1** script
4. Sign in to the Azure with the `Connect-AzAccount` command. The account you sign in as needs to have permissions to remove Policy Assignments, Policy Definitions, and resources at the desired Management Group scope.
5. Execute the script using the option below

  {{% include "PowerShell-ExecutionPolicy.md" %}}

  **Generate a list of the resource IDs which would be deleted by this script:**

  ```powershell
  ./Start-ALZMonitorCleanup.ps1 -ReportOnly
  ```

  **Show output of what would happen if deletes executed:**

  ```powershell
  ./Start-ALZMonitorCleanup.ps1 -WhatIf
  ```

  **Delete all resources deployed by the ALZ-Monitor IaC without prompting for confirmation:**

  ```powershell
  ./Start-ALZMonitorCleanup.ps1 -Force
  ```

## Next steps

- To customize policy assignments, please proceed with [Customize Policy Assignment](../deploy/Customize-Policy-Assignment)
- To deploy with GitHub Actions, please proceed with [Deploy with GitHub Actions](../deploy/Deploy-with-GitHub-Actions)
- To deploy with Azure DevOps Pipelines, please proceed with [Deploy with Azure Pipelines](../deploy/Deploy-with-Azure-Pipelines)
- To deploy with Azure CLI, please proceed with [Deploy with Azure CLI](../deploy/Deploy-with-Azure-CLI)
- To deploy with Azure PowerShell, please proceed with [Deploy with Azure PowerShell](../deploy/Deploy-with-Azure-PowerShell)
