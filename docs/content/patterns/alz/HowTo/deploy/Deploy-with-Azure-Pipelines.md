---
title: Deploy with Azure Pipelines
weight: 60
---

### In this page

> [Parameter Configuration](../Deploy-with-Azure-Pipelines#1-parameter-configuration) </br>
> [Sample Parameter File](../Deploy-with-Azure-Pipelines#2-sample-parameter-file) </br>
> [Configure and Run the Pipeline](../Deploy-with-Azure-Pipelines#3-configure-and-run-the-pipeline) </br>
> [Next Steps](../Deploy-with-Azure-Pipelines#next-steps) </br>

{{< hint type=Important >}}
Updating from the _**preview**_ version is not supported. If you deployed the _**preview**_ version, please follow the steps in [Moving from preview to GA](../../../HowTo/UpdateToNewReleases/Moving-from-preview-to-GA) before proceeding.
{{< /hint >}}

## 1. Parameter Configuration

{{% include "parameterConfiguration_1.md" %}}

## 2. Sample Parameter File

{{% include "parameterConfiguration_2.md" %}}

## 3. Configure and Run the Pipeline

To begin, configure your Azure DevOps project to use a pipeline hosted on GitHub by following the instructions [here](https://learn.microsoft.com/en-us/azure/devops/pipelines/repos/github?view=azure-devops&tabs=yaml#access-to-github-repositories). Ensure the pipeline is set up to use the [sample-pipeline.yml](https://github.com/Azure/azure-monitor-baseline-alerts/blob/main/patterns/alz/examples/sample-pipeline.yml) file.

{{< hint type=note >}}
If you have customized the policies as described in [How to modify individual policies](../Introduction-to-deploying-the-ALZ-Pattern#how-to-modify-individual-policies), ensure that the **inlineScript** in the pipeline file points to your repository and branch. For example:

  ```ActionScript
  inlineScript: |
    az deployment mg create --name "amba-MainDeployment" --template-uri https://raw.githubusercontent.com/___YourGithubFork___/azure-monitor-baseline-alerts/___MainOrBranchname___/patterns/alz/alzArm.json --location $(location) --management-group-id $(ManagementGroupPrefix) --parameters .\patterns\alz\alzArm.param.json
  ```

{{< /hint >}}

Additionally, configure a service connection to your Azure subscription in your Azure DevOps project by following the instructions in the [Connect to Azure by using an Azure Resource Manager service connection](https://docs.microsoft.com/en-us/azure/devops/pipelines/library/connect-to-azure?view=azure-devops&tabs=yaml) guide. Ensure that the service connection targets the intermediate root management group for ALZ-aligned deployments or the specific management group where you intend to deploy the policies and initiatives for ALZ-unaligned deployments.

### Modify Variables and Run the Pipeline

- Update the following values in [sample-pipeline.yml](https://github.com/Azure/azure-monitor-baseline-alerts/blob/main/patterns/alz/examples/sample-pipeline.yml):
  - Change _Location: "norwayeast"_ to your preferred Azure region.
  - Change _ManagementGroupPrefix: "alz"_ to the pseudo root management group.
- Navigate to Azure Pipelines and run the created pipeline.

{{< hint type=important >}}
Ensure that the `ManagementGroupPrefix` variable matches the `parPolicyPseudoRootMgmtGroup` parameter value set in the parameter files. This alignment is crucial for the correct deployment of policies.

The `Location` variable specifies the deployment region. It is not required to deploy to multiple regions since the policy definitions and assignments are scoped to a management group and are not region-specific.
{{< /hint >}}

## Next Steps

To remediate non-compliant policies, proceed with [Policy remediation](../Remediate-Policies).
