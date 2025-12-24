---
title: Deploy with GitHub Actions
weight: 70
---

### In this page

> [Parameter Configuration](#1-parameter-configuration) </br>
> [Sample Parameter File](#2-sample-parameter-file) </br>
> [Configure and Run the Workflow](#3-configure-and-run-the-workflow) </br>
> [Next Steps](#next-steps) </br>

</br>

> [!warning]
> Updating from the _**preview**_ version is not supported. If you deployed the _**preview**_ version, please follow the steps in [Moving from preview to GA](../../../HowTo/UpdateToNewReleases/Moving-from-preview-to-GA) before proceeding.

## 1. Parameter Configuration

{{< tabs groupid="Deploy_GHA_Param1" >}}

{{% tab title="Management Group (hierarchy or single)" %}}

{{% include "parameterConfiguration_1" %}}

{{% /tab %}}

{{% tab title="Cloud Solution Provider (CSP) or Azure Lighthouse" %}}

{{% include "parameterConfiguration_Subs_1" %}}

{{% /tab %}}

{{< /tabs >}}

## 2. Sample Parameter File

{{< tabs groupid="Deploy_GHA_Param2" >}}

{{% tab title="Management Group (hierarchy or single)" %}}

{{% include "parameterConfiguration_2" %}}

{{% /tab %}}

{{% tab title="Cloud Solution Provider (CSP) or Azure Lighthouse" %}}

{{% include "parameterConfiguration_Subs_2" %}}

{{% /tab %}}

{{< /tabs >}}

## 3. Configure and Run the Workflow

{{< tabs groupid="Deploy_GHA_Variables" >}}

{{% tab title="Management Group (hierarchy or single)" %}}

First, configure your OpenID Connect as described [here](https://learn.microsoft.com/en-us/azure/developer/github/connect-from-azure?tabs=azure-portal%2Cwindows#use-the-azure-login-action-with-openid-connect).

To deploy using GitHub Actions, refer to the [sample-workflow.yml](https://github.com/Azure/azure-monitor-baseline-alerts/blob/main/patterns/alz/examples/sample-workflow.yml).

> [!note]
> If you have customized the policies as described in [How to modify individual policies](./Introduction-to-deploying-the-ALZ-Pattern.md#how-to-modify-individual-policies), ensure that the workflow file's **run** command points to your specific repository and branch. For example:
>
>   ```ActionScript
>   run: |
>     az deployment mg create --name "amba-MainDeployment" --template-uri https://raw.githubusercontent.com/___YourGithubFork___/azure-monitor-baseline-alerts/___MainOrBranchname___/patterns/alz/alzArm.json --location ${{ env.Location }} --management-group-id ${{ env.ManagementGroupPrefix }} --parameters .\patterns\alz\alzArm.param.json
>   ```

### Modify Variables and Run the Workflow

- Update the following values in [amba-sample-workflow.yml](https://github.com/Azure/azure-monitor-baseline-alerts/blob/main/patterns/alz/examples/sample-workflow.yml):
  - Change _Location: "norwayeast"_ to your preferred Azure region.
  - Change _ManagementGroupPrefix: "alz"_ to the pseudo root management group ID that parents the identity, management, and connectivity management groups.
- Save the customized [amba-sample-workflow.yml](https://github.com/Azure/azure-monitor-baseline-alerts/blob/main/patterns/alz/examples/sample-workflow.yml) in the _**.github/workflow**_ folder.

  > [!warning]
  > The file name <ins>_**must** perfectly_</ins> match the name at line **1** of the sample file. You may replace spaces with **-** if necessary.

  ![Workflow file name](../../../media/WorkflowFileName.png)

  ![Workflow saved](../../../media/WorkflowSaved.png)

  For additional details on workflows, refer to the GitHub documentation: [Creating starter workflows for your organization](https://docs.github.com/en/actions/using-workflows/creating-starter-workflows-for-your-organization).

- Visit GitHub Actions and run the action _**Deploy AMBA**_.

  ![Deploy AMBA action](../../../media/DeployAmbaAction.png)

> [!warning]
> The value of the "ManagementGroupPrefix" variable, referred to as the "pseudo root management group ID," must match the value of the "parPolicyPseudoRootMgmtGroup" parameter set earlier in the parameter files.
>
> The `Location` variable specifies the deployment region. It is not required to deploy to multiple regions since the definitions and assignments are scoped to a management group and are not region-specific.

{{% /tab %}}

{{% tab title="Cloud Solution Provider (CSP) or Azure Lighthouse" %}}

First, configure your OpenID Connect as described [here](https://learn.microsoft.com/en-us/azure/developer/github/connect-from-azure?tabs=azure-portal%2Cwindows#use-the-azure-login-action-with-openid-connect).

To deploy using GitHub Actions, refer to the [sample-workflow-subs.yml](https://github.com/Azure/azure-monitor-baseline-alerts/blob/main/patterns/alz/examples/sample-workflow-subs.yml).

> [!note]
> If you have customized the policies as described in [How to modify individual policies](./Introduction-to-deploying-the-ALZ-Pattern.md#how-to-modify-individual-policies), ensure that the workflow file's **run** command points to your specific repository and branch. For example:
>
>   ```ActionScript
>   run: |
>     az account set --subscription "$targetSubscription"
>     az deployment mg create --name "amba-MainDeployment" --template-uri https://raw.githubusercontent.com/___YourGithubFork___/azure-monitor-baseline-alerts/___MainOrBranchname___/patterns/alz4Subs/alzArm4Subs.json --location ${{ env.Location }} --parameters .\patterns\alz4Subs\alzArm4Subs.param.json
>   ```

### Modify Variables and Run the Workflow

- Update the following values in [amba-sample-workflow-subs.yml](https://github.com/Azure/azure-monitor-baseline-alerts/blob/main/patterns/alz/examples/sample-workflow-subs.yml):
  - Change _Location: "norwayeast"_ to your preferred Azure region.
  - Change _targetSubscription: "00000000-0000-0000-0000-000000000000"_ to the subscription ID where AMBA-ALZ is being deployed.
- Save the customized [amba-sample-workflow-subs.yml](https://github.com/Azure/azure-monitor-baseline-alerts/blob/main/patterns/alz/examples/sample-workflow-subs.yml) in the _**.github/workflow**_ folder.

  > [!warning]
  > The file name <ins>_**must** perfectly_</ins> match the name at line **1** of the sample file. You may replace spaces with **-** if necessary.

  ![Workflow file name](../../../media/WorkflowFileName.png)

  ![Workflow saved](../../../media/WorkflowSaved.png)

  For additional details on workflows, refer to the GitHub documentation: [Creating starter workflows for your organization](https://docs.github.com/en/actions/using-workflows/creating-starter-workflows-for-your-organization).

- Visit GitHub Actions and run the action _**Deploy AMBA**_.

  ![Deploy AMBA action](../../../media/DeployAmbaAction.png)

> [!warning]
>The value of the "targetSubscription" variable, must match the value of the "topLevelSubscriptionId" parameter set earlier in the parameter files.
>
>The `Location` variable specifies the deployment region. It is not required to deploy to multiple regions since the definitions and assignments are scoped to a subscription and are not region-specific.

{{% /tab %}}

{{< /tabs >}}

## Next Steps

To remediate non-compliant policies, continue with [Policy Remediation](../Remediate-Policies).
