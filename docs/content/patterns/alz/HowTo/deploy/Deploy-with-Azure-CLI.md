---
title: Deploy with Azure CLI
weight: 40
---

### In this page

> [Parameter Configuration](../Deploy-with-Azure-CLI#1-parameter-configuration) </br>
> [Sample Parameter File](../Deploy-with-Azure-CLI#2-sample-parameter-file) </br>
> [Configuring Variables for Deployment](../Deploy-with-Azure-CLI#3-configuring-variables-for-deployment) </br>
> [Deploying AMBA-ALZ](../Deploy-with-Azure-CLI#4-deploying-amba-alz) </br>
> [Next Steps](../Deploy-with-Azure-CLI#next-steps) </br>

{{< hint type=Important >}}
Updating from the _**preview**_ version is not supported. If you deployed the _**preview**_ version, please follow the steps in [Moving from preview to GA](../../../HowTo/UpdateToNewReleases/Moving-from-preview-to-GA) before proceeding.
{{< /hint >}}

## 1. Parameter Configuration

{{% include "parameterConfiguration_1.md" %}}

## 2. Sample Parameter File

{{% include "parameterConfiguration_2.md" %}}

## 3. Configuring Variables for Deployment

The following commands are applicable to all scenarios, whether aligned with ALZ, unaligned, or managing a single management group.

Open your preferred command-line tool (Windows PowerShell, Cmd, Bash, or other Unix shells) to navigate to the folder where the parameter file was downloaded. Log in to Azure using an account with at least Resource Policy Contributor access at the root of the management group hierarchy where the policies and initiatives will be created.

Execute the following commands:

```bash
location="Your Azure location of choice"
pseudoRootManagementGroup="The pseudo root management group ID parenting the identity, management, and connectivity management groups"
```

{{< hint type=Important >}}
When executing Azure CLI commands from PowerShell, ensure that variables are prefixed with a `$` symbol.

The `pseudoRootManagementGroup` variable should match the value of the `enterpriseScaleCompanyPrefix` parameter, as defined in the parameter files.

The `location` variable specifies the deployment region. It is not required to deploy to multiple regions as the definitions and assignments are scoped to a management group and are not region-specific.
{{< /hint >}}

## 4. Deploying AMBA-ALZ

The following commands are applicable to all scenarios, whether aligned with ALZ, unaligned, or managing a single management group.

Use your preferred command-line tool (Windows PowerShell, Cmd, Bash, or other Unix shells) to navigate to the folder where the parameter file was downloaded. Log in to Azure using an account with at least Resource Policy Contributor access at the root of the management group hierarchy where the policies and initiatives will be created.

{{< hint type=note >}}
For testing purposes, it is recommended to deploy in a safe environment first. When preparing for a production deployment, refer to the [Customize Policy Assignment](../Customize-Policy-Assignment) guide to deploy and enable alerts in a controlled and secure manner.

If you have customized the policies as described in [How to modify individual policies](../Introduction-to-deploying-the-ALZ-Pattern#how-to-modify-individual-policies), ensure that you run the deployment command using your own repository and branch in the `--template-uri` parameter. For example:

  ```bash
  az deployment mg create --name "amba-MainDeployment" --template-uri https://raw.githubusercontent.com/***YourGithubFork***/azure-monitor-baseline-alerts/***main or branchname***/patterns/alz/alzArm.json --location $location --management-group-id $pseudoRootManagementGroup --parameters ".\patterns\alz\alzArm.param.json"
  ```

{{< /hint >}}

```bash
az deployment mg create --name "amba-MainDeployment" --template-uri https://raw.githubusercontent.com/Azure/azure-monitor-baseline-alerts/2025-07-02/patterns/alz/alzArm.json --location $location --management-group-id $pseudoRootManagementGroup --parameters "alzArm.param.json"
```

## Next Steps

To remediate non-compliant policies, continue with [Policy Remediation](../Remediate-Policies)
