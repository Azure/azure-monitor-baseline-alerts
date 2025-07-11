---
title: Deploy with GitHub Actions
weight: 70
---

### In this page

> [Parameter Configuration](../Deploy-with-GitHub-Actions#1-parameter-configuration) </br>
> [Sample Parameter File](../Deploy-with-GitHub-Actions#2-sample-parameter-file) </br>
> [Configure and Run the Workflow](../Deploy-with-GitHub-Actions#3-configure-and-run-the-workflow) </br>
> [Next Steps](../Deploy-with-GitHub-Actions#next-steps) </br>

{{< hint type=Important >}}
Updating from the _**preview**_ version is not supported. If you deployed the _**preview**_ version, please follow the steps in [Moving from preview to GA](../../../HowTo/UpdateToNewReleases/Moving-from-preview-to-GA) before proceeding.
{{< /hint >}}

## 1. Parameter Configuration

{{% include "parameterConfiguration_1.md" %}}

## 2. Sample Parameter File

{{% include "parameterConfiguration_2.md" %}}

## 3. Configure and Run the Workflow

First, configure your OpenID Connect as described [here](https://learn.microsoft.com/en-us/azure/developer/github/connect-from-azure?tabs=azure-portal%2Cwindows#use-the-azure-login-action-with-openid-connect).

To deploy using GitHub Actions, refer to the [sample-workflow.yml](https://github.com/Azure/azure-monitor-baseline-alerts/blob/main/patterns/alz/examples/sample-workflow.yml).

{{< hint type=note >}}
If you have customized the policies as described in [How to modify individual policies](./Introduction-to-deploying-the-ALZ-Pattern.md#how-to-modify-individual-policies), ensure that the workflow file's **run** command points to your specific repository and branch. For example:

  ```ActionScript
  run: |
    az deployment mg create --name "amba-MainDeployment" --template-uri https://raw.githubusercontent.com/___YourGithubFork___/azure-monitor-baseline-alerts/___MainOrBranchname___/patterns/alz/alzArm.json --location ${{ env.Location }} --management-group-id ${{ env.ManagementGroupPrefix }} --parameters .\patterns\alz\alzArm.param.json
  ```
{{< /hint >}}

### Modify Variables and Run the Workflow

- Update the following values in [amba-sample-workflow.yml](https://github.com/Azure/azure-monitor-baseline-alerts/blob/main/patterns/alz/examples/sample-workflow.yml):
  - Change _Location: "norwayeast"_ to your preferred Azure region.
  - Change _ManagementGroupPrefix: "alz"_ to the pseudo root management group ID that parents the identity, management, and connectivity management groups.
- Save the customized [amba-sample-workflow.yml](https://github.com/Azure/azure-monitor-baseline-alerts/blob/main/patterns/alz/examples/sample-workflow.yml) in the _**.github/workflow**_ folder.

  {{< hint type=important >}}
  The file name <ins>_**must** perfectly_</ins> match the name at line **1** of the sample file. You may replace spaces with **-** if necessary.
  {{< /hint >}}

  ![Workflow file name](../../../media/WorkflowFileName.png)

  ![Workflow saved](../../../media/WorkflowSaved.png)

  For additional details on workflows, refer to the GitHub documentation: [Creating starter workflows for your organization](https://docs.github.com/en/actions/using-workflows/creating-starter-workflows-for-your-organization).

- Visit GitHub Actions and run the action _**Deploy AMBA**_.

  ![Deploy AMBA action](../../../media/DeployAmbaAction.png)

{{< hint type=important >}}
The value of the "ManagementGroupPrefix" variable, referred to as the "pseudo root management group ID," must match the value of the "parPolicyPseudoRootMgmtGroup" parameter set earlier in the parameter files.

The `Location` variable specifies the deployment region. It is not required to deploy to multiple regions since the definitions and assignments are scoped to a management group and are not region-specific.
{{< /hint >}}

## Next Steps

To remediate non-compliant policies, continue with [Policy Remediation](../Remediate-Policies).
