---
title: Preview Deploy Changes
geekdocCollapseSection: true
weight: 25
---

### In this page

> [Introduction](../Preview-Deploy-Changes#introduction) </br>
> [ARM What-If Deployment](../Preview-Deploy-Changes#arm-what-if-deployment) </br>
> [Parsing ARM What-If Output](../Preview-Deploy-Changes#parsing-arm-what-if-output) </br>
> [Next Steps](../Preview-Deploy-Changes#next-steps) </br>

## Introduction

This document provides guidance on using the `az cli what-if` parameter to preview changes before deploying the Azure Monitor Baseline Alerts (AMBA) pattern.

### ARM What-If Deployment

The `az deployment mg what-if` command allows you to preview the changes that would be made by an ARM template deployment without actually applying those changes. This is particularly useful for understanding the impact of deploying the Azure Monitor Baseline Alerts (AMBA) pattern.

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
      --parameters ./azure_monitor_baseline_alerts/alzArm.param.json
```

### Parsing ARM What-If Output

The output of the `az deployment mg what-if` command will provide detailed output of the changes that would be made if the deployment were to proceed. This includes information about resources that will be created, modified, or deleted, along with their properties.

However, this output can be quite verbose and may not be easily readable. To make it more manageable, you can capture the output to a file, and then parse it for the specific changes that will occur.

**Capture Output to a File:**
You can modify the command to redirect the `az deployment mg what-if` output to a file for easier analysis. Here’s how you can do that:

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

**Parse the Output:**
The following PowerShell script can be used to parse the output file and summarize the changes:

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

- To deploy using Azure Portal UI, visit [Deploy via the Azure Portal Accelerator](../Deploy-via-Azure-Portal-UI)
- To deploy with GitHub Actions, visit [Deploy with GitHub Actions](../Deploy-with-GitHub-Actions)
- To deploy with Azure DevOps Pipelines, visit [Deploy with Azure Pipelines](../Deploy-with-Azure-Pipelines)
- To deploy with Azure CLI, visit [Deploy with Azure CLI](../Deploy-with-Azure-CLI)
- To deploy with Azure PowerShell, visit [Deploy with Azure PowerShell](../Deploy-with-Azure-PowerShell)
