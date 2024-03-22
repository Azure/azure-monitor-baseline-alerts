---
title: Deploy with Azure Pipelines
weight: 50
---

{{% include "parameterConfiguration.md" %}}

## 3. Configure and run the pipeline

First configure your Azure DevOps project with a pipeline hosted in GitHub as described [here](https://learn.microsoft.com/en-us/azure/devops/pipelines/repos/github?view=azure-devops&tabs=yaml#access-to-github-repositories). The pipeline should be configured to use the [sample-pipeline.yml](https://github.com/Azure/azure-monitor-baseline-alerts/blob/main/patterns/alz/examples/sample-pipeline.yml) file.

{{< hint type=note >}}
If you customized the policies as documented at [How to modify individual policies](./Introduction-to-deploying-the-ALZ-Pattern.md#how-to-modify-individual-policies), make sure to modify the pipeline file to have the **inlineScript** pointing to your own repository and branch. Example:

    inlineScript: |
      az deployment mg create --name "amba-GeneralDeployment" --template-uri https://raw.githubusercontent.com/***YourGithubFork***/azure-monitor-baseline-alerts/***main
      or branchname***/patterns/alz/alzArm.json --location $(location) --management-group-id $(ManagementGroupPrefix) --parameters .\patterns\alz\alzArm.param.json

{{< /hint >}}

Also in your Azure DevOps project, configure a service connection to your Azure subscription as described [here](https://docs.microsoft.com/en-us/azure/devops/pipelines/library/connect-to-azure?view=azure-devops&tabs=yaml). The service connection should target the intermediate root management group for ALZ aligned deployments or the management group where you wish to deploy the policies and the initiatives for ALZ unaligned deployments.

### Modify variables and run the pipeline

- Modify the following values in [sample-pipeline.yml](https://github.com/Azure/azure-monitor-baseline-alerts/blob/main/patterns/alz/examples/sample-pipeline.yml):
  - Change _Location: "norwayeast"_, to your preferred Azure region
  - Change _ManagementGroupPrefix: "alz"_, to the pseudo root management
- Go to Azure Pipelines and run the pipeline you just created.

{{< hint type=important >}}
Above-mentioned "ManagementGroupPrefix" variable value, being the so called "pseudo root management group id", should _coincide_ with the value of the "parPolicyPseudoRootMgmtGroup" parameter, as set previously within the parameter files.

The location variable refers to the deployment location. Deploying to multiple regions is not necessary as the definitions and assignments are scoped to a management group and are not region-specific.
{{< /hint >}}

## Next steps

To remediate non-compliant policies, please continue with [Policy remediation](../Remediate-Policies)
