---
title: Preview Deployment Changes
geekdocCollapseSection: true
weight: 25
---

### In this page

> [Introduction](#introduction) </br>
> [How does it work](#how-does-it-work) </br>
> [Preview deployment changes using PowerShell](#preview-deployment-changes-using-powershell) </br>
> [Preview deployment changes using the GitHub workflow](#preview-deployment-changes-using-the-github-workflow) </br>
> [Next Steps](#next-steps) </br>

## Introduction

Per the [ARM template deployment what-if operation](https://learn.microsoft.com/en-us/azure/azure-resource-manager/templates/deploy-what-if) documentation, you can preview the changes that will happen with an Azure Resource Manager (ARM) template deployment, using the `what-if` command. The what-if operation doesn't make any changes to existing resources. Instead, it predicts the changes if the specified template is deployed.

We can use this command to preview the changes that would be made by deploying the Azure Monitor Baseline Alerts (AMBA).

## How does it work

The `what-if` command allows you to preview the changes that would be made by an ARM template deployment without actually applying those changes. This is particularly useful for understanding the impact of deploying the Azure Monitor Baseline Alerts (AMBA) pattern.

By capturing the output of the `what-if` command, you can analyze the changes that would occur, including resources that will be created, modified, or deleted. This helps in assessing the impact of the deployment and ensuring that it aligns with your expectations before proceeding with the actual deployment.

Set up your parameters and variable as required for your target environment. If using the **Azure CLI**, follow the steps in the [Deploy with Azure CLI](../Deploy-with-Azure-CLI) section. If using **PowerShell**, follow the steps in the [Deploy with Azure PowerShell](../Deploy-with-Azure-PowerShell) section. On the final "Deploy" step, use the following what-if command instead of the deployment command to preview the changes.

**Azure CLI:**

```bash
az deployment mg what-if \
  --template-uri https://raw.githubusercontent.com/Azure/azure-monitor-baseline-alerts/${AMBA_VERSION}/patterns/alz/alzArm.json \
  --location $location \
  --management-group-id $pseudoRootManagementGroup \
  --parameters "alzArm.param.json"
```

**Azure PowerShell:**

```powershell
New-AzManagementGroupDeployment `
  -Location $location `
  -ManagementGroupId $pseudoRootManagementGroup `
  -TemplateFile "https://raw.githubusercontent.com/Azure/azure-monitor-baseline-alerts/${AMBA_VERSION}/patterns/alz/alzArm.json" `
  -TemplateParameterFile "alzArm.param.json" `
  -WhatIf
```

## Preview deployment changes using PowerShell

Using PowerShell for deployments uses the following syntax: `New-AzManagementGroupDeployment -ManagementGroupId <String> -Location <String>`. This example PowerShell script expects an input, which is the output from the `New-AzManagementGroupDeployment -WhatIf` command. You can capture the output to a file by appending `| Tee-Object -FilePath amba-what-if-output.txt` to the command.

```powershell
New-AzManagementGroupDeployment `
  -Location $location `
  -ManagementGroupId $pseudoRootManagementGroup `
  -TemplateFile "https://raw.githubusercontent.com/Azure/azure-monitor-baseline-alerts/${AMBA_VERSION}/patterns/alz/alzArm.json" `
  -TemplateParameterFile "alzArm.param.json" `
  -WhatIf | Tee-Object -FilePath amba-what-if-output.txt
```

Using the output from the `New-AzManagementGroupDeployment -WhatIf` command, you can parse it using the following PowerShell script to summarize the changes that would occur if the deployment were to proceed.

```powershell
# Get the content from the log file
    $content = Get-Content -Path "./amba-what-if-output.txt"

    # Define the patterns to search for and their corresponding messages
    $patternMessageMap = @{
      # Patterns for policies that will be added
      '\+ Microsoft\.Authorization/policyDefinitions/.*' = "Policies will be added:"
      '\+ Microsoft\.Authorization/policySetDefinitions/.*' = "Policy Sets will be added:"
      '\+ Microsoft\.Authorization/policyAssignments/.*' = "Policy Assignments will be added:"
      '\+ Microsoft\.Authorization/roleAssignments/.*' = "Role Assignments will be added:"

      # Patterns for policies that will be modified
      '~ Microsoft\.Authorization/policyDefinitions/.*' = "Policies will be modified:"
      '~ Microsoft\.Authorization/policySetDefinitions/.*' = "Policy Sets will be modified:"
      '~ Microsoft\.Authorization/policyAssignments/.*' = "Policy Assignments will be modified:"
      '~ Microsoft\.Authorization/roleAssignments/.*' = "Role Assignments will be modified:"

      # Patterns for policies that will be removed
      '- Microsoft\.Authorization/policyDefinitions/.*' = "Policies will be removed:"
      '- Microsoft\.Authorization/policySetDefinitions/.*' = "Policy Sets will be removed:"
      '- Microsoft\.Authorization/policyAssignments/.*' = "Policy Assignments will be removed:"
      '- Microsoft\.Authorization/roleAssignments/.*' = "Role Assignments will be removed:"
    }

    # Iterate through each pattern in the map
    foreach ($pattern in $patternMessageMap.Keys) {
      # Use Select-String to find matches for the current pattern in the content
      $matches = $content | Select-String -Pattern $pattern
      if ($matches) {
        # Get the count of matches and output the message with the count
        $count = $matches.Count
        Write-Host "$count $($patternMessageMap[$pattern])"

        # Process each match to remove the timestamp and write the clean line
        $matches | ForEach-Object {
          # Remove the timestamp using a regex pattern
          $cleanLine = $_.Line -replace '^\d{4}-\d{2}-\d{2}T\d{2}:\d{2}:\d{2}\.\d+Z\s+', ''
          # Output the clean line
          Write-Output $cleanLine
        }

        # Output a blank line for readability
        Write-Output ""
      }
    }
```

## Preview deployment changes using the GitHub workflow

{{< hint type=Note >}}
In the same GitHub Action Workflow file, you will need to customize the enviornment variables for your specific environment.

For example, `ARM_CLIENT_ID`, `ARM_TENANT_ID`, `ARM_SUBSCRIPTION_ID`, and `ARM_USE_OIDC` all control the authentication to your Azure subscription. You will need to set these variables in your GitHub repository secrets or environment variables.

The `Location` variable is used by the `az deployment mg` command, and specifies the deployment region. It is not required to deploy to multiple regions as the definitions and assignments are scoped to a management group and are not region-specific.

The `ManagementGroupPrefix` variable should match the value of the `enterpriseScaleCompanyPrefix` parameter, as defined in the parameter files.

Finally, the `AMBA_VERSION` variable should be set to the version of the Azure Monitor Baseline Alerts (AMBA) pattern you wish to deploy. This corresponds to the **Releases tag** in the AMBA GitHub repository, such as `2025-07-02`. You can find the latest release version in the [AMBA GitHub repository](https://github.com/Azure/azure-monitor-baseline-alerts/releases).
{{< /hint >}}

Using the same method described in the [Preview deployment changes using PowerShell](#preview-deployment-changes-using-powershell) section, you can also implement this in a GitHub Action Workflow, and include the output in the GitHub Actions summary.

{{< hint type=Note >}}
The GitHub Action Workflow file is provided as-is, and should be customized to suit your specific requirements. The example below is a starting point and may not include all necessary configurations for your deployment.
{{< /hint >}}

```yaml
- name: Azure CLI What-If Deploy AMBA ARM Template
  id: deploy_amba
  shell: bash
  run: |
    az deployment mg what-if \
      --template-uri https://raw.githubusercontent.com/Azure/azure-monitor-baseline-alerts/${{ env.AMBA_VERSION }}/patterns/alz/alzArm.json \
      --location ${{ env.Location }} \
      --management-group-id ${{ env.ManagementGroupPrefix }} \
      --parameters ./azure_monitor_baseline_alerts/alzArm.param.json | tee amba-what-if-output.txt
```

```yaml
- name: Parse What-If Output for Changes
  id: amba_changes
  shell: pwsh
  run: |
    # Get the content from the log file
    $content = Get-Content -Path "./amba-what-if-output.txt"

    # Define the patterns to search for and their corresponding messages
    $patternMessageMap = @{
      # Patterns for policies that will be added
      '\+ Microsoft\.Authorization/policyDefinitions/.*' = "Policies will be added:"
      '\+ Microsoft\.Authorization/policySetDefinitions/.*' = "Policy Sets will be added:"
      '\+ Microsoft\.Authorization/policyAssignments/.*' = "Policy Assignments will be added:"
      '\+ Microsoft\.Authorization/roleAssignments/.*' = "Role Assignments will be added:"

      # Patterns for policies that will be modified
      '~ Microsoft\.Authorization/policyDefinitions/.*' = "Policies will be modified:"
      '~ Microsoft\.Authorization/policySetDefinitions/.*' = "Policy Sets will be modified:"
      '~ Microsoft\.Authorization/policyAssignments/.*' = "Policy Assignments will be modified:"
      '~ Microsoft\.Authorization/roleAssignments/.*' = "Role Assignments will be modified:"

      # Patterns for policies that will be removed
      '- Microsoft\.Authorization/policyDefinitions/.*' = "Policies will be removed:"
      '- Microsoft\.Authorization/policySetDefinitions/.*' = "Policy Sets will be removed:"
      '- Microsoft\.Authorization/policyAssignments/.*' = "Policy Assignments will be removed:"
      '- Microsoft\.Authorization/roleAssignments/.*' = "Role Assignments will be removed:"
    }

    "# Azure Monitor Baseline Alerts (AMBA) What-If Summary" >> $env:GITHUB_STEP_SUMMARY
    "" >> $env:GITHUB_STEP_SUMMARY # this is a blank line

    # Iterate through each pattern in the map
    foreach ($pattern in $patternMessageMap.Keys) {
      # Use Select-String to find matches for the current pattern in the content
      $matches = $content | Select-String -Pattern $pattern
      if ($matches) {
        # Get the count of matches and output the message with the count
        $count = $matches.Count
        Write-Host "$count $($patternMessageMap[$pattern])"
        "## $count $($patternMessageMap[$pattern])" >> $env:GITHUB_STEP_SUMMARY
        '```' >> $env:GITHUB_STEP_SUMMARY

        # Process each match to remove the timestamp and write the clean line
        $matches | ForEach-Object {
          # Remove the timestamp using a regex pattern
          $cleanLine = $_.Line -replace '^\d{4}-\d{2}-\d{2}T\d{2}:\d{2}:\d{2}\.\d+Z\s+', ''
          # Output the clean line
          Write-Output $cleanLine
          "$cleanLine" >> $env:GITHUB_STEP_SUMMARY
        }

        # Output a blank line for readability
        Write-Output ""
        '```' >> $env:GITHUB_STEP_SUMMARY
        "" >> $env:GITHUB_STEP_SUMMARY # this is a blank line
      }
    }
```

A full example of the GitHub Action Workflow file can be found in the AMBA repo under [patterns/alz/examples/sample-workflow-whatif.yml](https://github.com/Azure/azure-monitor-baseline-alerts/blob/main/patterns/alz/examples/sample-workflow-whatif.yml).

By using the `$env:GITHUB_STEP_SUMMARY` variable, the output will be formatted and displayed in the GitHub Actions summary, making it easier to review the changes that would be applied by the deployment.

![ALZ Management group structure](../../../media/AMBA-Deploy-WhatIf-Summary-1.png)

![ALZ Management group structure](../../../media/AMBA-Deploy-WhatIf-Summary-2.png)

## Next Steps

- To deploy AMBA-ALZ using Azure Portal UI, visit [Deploy via the Azure Portal Accelerator](../Deploy-via-Azure-Portal-UI)
- To deploy AMBA-ALZ using GitHub Actions, visit [Deploy with GitHub Actions](../Deploy-with-GitHub-Actions)
- To deploy AMBA-ALZ using Azure DevOps Pipelines, visit [Deploy with Azure Pipelines](../Deploy-with-Azure-Pipelines)
- To deploy AMBA-ALZ using Azure CLI, visit [Deploy with Azure CLI](../Deploy-with-Azure-CLI)
- To deploy AMBA-ALZ using Azure PowerShell, visit [Deploy with Azure PowerShell](../Deploy-with-Azure-PowerShell)
- To deploy AMBA-ALZ using Terraform, please proceed with [Deploy with Terraform](../Deploy-with-Terraform)
