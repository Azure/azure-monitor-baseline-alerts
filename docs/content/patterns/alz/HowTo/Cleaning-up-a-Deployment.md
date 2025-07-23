---
title: Clean-up AMBA-ALZ Deployment
geekdocCollapseSection: true
weight: 52
---

### In this page

> [Why clean-up a deployment](#why-clean-up-a-deployment)</br>
> [Clean-up an ARM-based deployemnt](#clean-up-an-arm-based-deployment)</br>
> [Clean-up a Terraform-based deployment](#clean-up-a-terraform-deployment)</br>
> [Clean-up Script Execution](#clean-up-script-execution)</br>

## Why clean-up a deployment

In some cases, you may need to remove all resources deployed by the AMBA-ALZ solution. The following instructions provide a detailed guide on cleaning up an existing environment using two different approaches based on the method used to deploy the AMBA-ALZ pattern.

Available deployment methods can be summarized into two big categories:

- ARM-based deployments including Azure PowerShell, Azure CLI, Azure Pipelines and GitHub Actions
- Terraform-based deployment

Because of this, a different guidance is required to ensure a proper clean-up of the existing environment.

## Clean-up an ARM-based deployment

The instructions in the [Clean-up Script Execution](#clean-up-script-execution) provide a detailed guide on cleaning up ARM-based deployments by executing a PowerShell script to delete all deployed resources, including:

- Resource Groups (only if empty)
- Alerts
- Policy Assignments
- Policy Set Definitions
- Policy Definitions
- Role Assignments
- User assigned Managed Identity
- Action Groups
- Alert Processing Rules

All resources deployed as part of the initial AMBA-ALZ deployment, as well as those created dynamically by 'deploy if not exist' policies, are tagged, marked in metadata, or described (depending on resource capabilities) with the value `_deployed_by_amba` or `_deployed_by_amba=True`. This metadata is crucial for the cleanup process; if it has been removed or altered, the cleanup script will not target those resources.

## Clean-up a Terraform deployment

Terraform has a native feature to remove resources it deploy. Thanks to this capability, it is enough to run the `terraform destroy` command to remove the following resources:

- Resource Groups (only if empty)
- Policy Assignments
- Policy Set Definitions
- Policy Definitions
- Role Assignments
- User assigned Managed Identity

However, there are resources created outside of the Terraform deployment such as Alerts, Action Group and Alert Processing Rules, which are created during the policy remediation tasks. For these resources it is necessary to follow the guidance at [Clean-up Script Execution](#clean-up-script-execution) and run the script after the `terraform destroy`.

## Clean-up Script Execution

{{< hint type=Important >}}
It is strongly advised to **thoroughly** test the script in a non-production environment before deploying it to production. These sample scripts are not covered by any Microsoft standard support program or service. They are provided "AS IS" without any warranty, express or implied. Microsoft disclaims all implied warranties, including but not limited to, implied warranties of merchantability or fitness for a particular purpose. The user assumes all risks associated with the use or performance of the sample scripts and documentation. Microsoft, its authors, or any contributors to the creation, production, or delivery of the scripts shall not be liable for any damages, including but not limited to, loss of business profits, business interruption, loss of business information, or other financial losses, arising from the use or inability to use the sample scripts or documentation, even if Microsoft has been advised of the possibility of such damages.
{{< /hint >}}

### Download the Script File

To download the cleanup script file, follow these steps. Alternatively, you can clone the repository from GitHub and ensure you are working with the latest version by fetching the latest `main` branch.

1. Navigate to the [AMBA project on GitHub](https://aka.ms/amba/repo).
2. Browse to the `patterns/alz/scripts` directory.
3. Open the **Start-AMBA-ALZ-Maintenance.ps1** script file.
4. Click the **Raw** button.
5. Save the file as **Start-AMBA-ALZ-Maintenance.ps1**.

### Executing the Script

1. Launch PowerShell.
2. Ensure the following modules are installed:

   - **Az.Accounts**: if not installed, use `Install-Module Az.Accounts` to install it.
   - **Az.Resources**: if not installed, use `Install-Module Az.Resources` to install it.
   - **Az.ResourceGraph**: if not installed, use `Install-Module Az.ResourceGraph` to install it.
   - **Az.ManagedServiceIdentity**: if not installed, use `Install-Module Az.ManagedServiceIdentity` to install it.

3. Navigate to the directory containing the **Start-ALZ-Maintenance.ps1** script.
4. Set the _**$pseudoRootManagementGroup**_ variable using the following command:

  ```powershell
  $pseudoRootManagementGroup = "The pseudo root management group ID parenting the identity, management and connectivity management groups"
  ```

5. Sign in to your Azure account using the `Connect-AzAccount` command. Ensure that the account has the necessary permissions to remove Policy Assignments, Policy Definitions, and resources at the required Management Group scope.
6. Run the script with one of the following options:

   {{% include "PowerShell-ExecutionPolicy.md" %}}

   **Get full help on script usage:**

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

  **Execute the script <ins>without</ins> asking for confirmation before deleting the resources deployed by AMBA-ALZ:**

  ```powershell
  ./Start-AMBA-ALZ-Maintenance.ps1 -pseudoRootManagementGroup $pseudoRootManagementGroup -cleanItems Amba-Alz -Confirm:$false
  ```
