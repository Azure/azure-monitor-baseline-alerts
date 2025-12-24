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

</br>

> [!warning]
> Updating from the _**preview**_ version is not supported. If you deployed the _**preview**_ version, please follow the steps in [Transitioning from Preview to General Availability (GA)](../../../HowTo/UpdateToNewReleases/Moving-from-preview-to-GA) before proceeding.

## 1. Parameter Configuration

{{< tabs groupid="Deploy_CLI_Param1" >}}

{{% tab title="Management Group (hierarchy or single)" %}}

{{% include "parameterConfiguration_1" %}}

{{% /tab %}}

{{% tab title="Cloud Solution Provider (CSP) or Azure Lighthouse" %}}

{{% include "parameterConfiguration_Subs_1" %}}

{{% /tab %}}

{{< /tabs >}}

## 2. Sample Parameter File

{{< tabs groupid="Deploy_CLI_Param2" >}}

{{% tab title="Management Group (hierarchy or single)" %}}

  {{% include "parameterConfiguration_2" %}}

{{% /tab %}}

{{% tab title="Cloud Solution Provider (CSP) or Azure Lighthouse" %}}

  {{% include "parameterConfiguration_Subs_2" %}}

{{% /tab %}}

{{< /tabs >}}

## 3. Configuring Variables for Deployment

{{< tabs groupid="Deploy_CLI_Variables" >}}

{{% tab title="Management Group (hierarchy or single)" %}}

The following commands are applicable to all scenarios, whether aligned with ALZ, unaligned, or managing a single management group.

Open your preferred command-line tool (Windows PowerShell, Cmd, Bash, or other Unix shells) to navigate to the folder where the parameter file was downloaded. Log in to Azure using an account with at least Resource Policy Contributor access at the root of the management group hierarchy where the policies and initiatives will be created.

Execute the following commands:

```bash
location="Your Azure location of choice"
pseudoRootManagementGroup="The pseudo root management group ID parenting the identity, management, and connectivity management groups"
```

> [!important]
> When executing Azure CLI commands from PowerShell, ensure that variables are prefixed with a `$` symbol.
>
> The `pseudoRootManagementGroup` variable should match the value of the `enterpriseScaleCompanyPrefix` parameter, as defined in the parameter files.
>
> The `location` variable specifies the deployment region. It is not required to deploy to multiple regions as the definitions and assignments are scoped to a management group and are not region-specific.
>

{{% /tab %}}

{{% tab title="Cloud Solution Provider (CSP) or Azure Lighthouse" %}}

Open your preferred command-line tool (Windows PowerShell, Cmd, Bash, or other Unix shells) to navigate to the folder where the parameter file was downloaded. Log in to Azure using an account with at least Resource Policy Contributor access at the root of the management group hierarchy where the policies and initiatives will be created.

Execute the following commands:

```bash
location="Your Azure location of choice"
targetSubscription="The subscription ID where to deploy AMBA-ALZ"
```

> [!important]
> When executing Azure CLI commands from PowerShell, ensure that variables are prefixed with a `$` symbol.
>
> The `targetSubscription` variable should match the value of the `topLevelSubscriptionId` parameter, as defined in the parameter files.
>
> The `location` variable specifies the deployment region. It is not required to deploy to multiple regions as the definitions and assignments are scoped to a subscription and are not region-specific.
>

{{% /tab %}}

{{< /tabs >}}

## 4. Deploying AMBA-ALZ

{{< tabs groupid="Deploy_CLI_Deploy" >}}

{{% tab title="Management Group (hierarchy or single)" %}}

The following commands are applicable to all scenarios, whether aligned with ALZ, unaligned, or managing a single management group.

Use your preferred command-line tool (Windows PowerShell, Cmd, Bash, or other Unix shells) to navigate to the folder where the parameter file was downloaded. Log in to Azure using an account with at least Resource Policy Contributor access at the root of the management group hierarchy where the policies and initiatives will be created.

> [!note]
> For testing purposes, it is recommended to deploy in a safe environment first. When preparing for a production deployment, refer to the [Customize Policy Assignment](../Customize-Policy-Assignment) guide to deploy and enable alerts in a controlled and secure manner.
>
> If you have customized the policies as described in [How to modify individual policies](../Introduction-to-deploying-the-ALZ-Pattern#how-to-modify-individual-policies), ensure that you run the deployment command using your own repository and branch in the `--template-uri` parameter. For example:
>
  > ```bash
  > az deployment mg create --name "amba-MainDeployment" --template-uri https://raw.githubusercontent.com/***YourGithubFork***/azure-monitor-baseline-alerts/***main or branchname***/patterns/alz/alzArm.json --location $location --management-group-id $pseudoRootManagementGroup --parameters ".\patterns\alz\alzArm.param.json"
  > ```
>

```bash
az deployment mg create --name "amba-MainDeployment" --template-uri https://raw.githubusercontent.com/Azure/azure-monitor-baseline-alerts/2025-10-01/patterns/alz/alzArm.json --location $location --management-group-id $pseudoRootManagementGroup --parameters "alzArm.param.json"
```

{{% /tab %}}

{{% tab title="Cloud Solution Provider (CSP) or Azure Lighthouse" %}}

Use your preferred command-line tool (Windows PowerShell, Cmd, Bash, or other Unix shells) to navigate to the folder where the parameter file was downloaded. Log in to Azure using an account with at least Resource Policy Contributor access at the root of the management group hierarchy where the policies and initiatives will be created.

> [!note]
> For testing purposes, it is recommended to deploy in a safe environment first. When preparing for a production deployment, refer to the [Customize Policy Assignment](../Customize-Policy-Assignment) guide to deploy and enable alerts in a controlled and secure manner.
>
> If you have customized the policies as described in [How to modify individual policies](../Introduction-to-deploying-the-ALZ-Pattern#how-to-modify-individual-policies), ensure that you run the deployment command using your own repository and branch in the `--template-uri` parameter. For example:
>
  > ```bash
  > az account set --subscription "$targetSubscription"
  > az deployment sub create --name "amba-MainDeployment" --template-uri https://raw.githubusercontent.com/***YourGithubFork***/azure-monitor-baseline-alerts/***main or branchname***/patterns/alz4Subs/alzArm4Subs.json --location $location --parameters ".\patterns\alz4Subs\alzArm4Subs.param.json"
  > ```
>

```bash
az account set --subscription "$targetSubscription"
az deployment sub create --name "amba-MainDeployment" --template-uri https://raw.githubusercontent.com/Azure/azure-monitor-baseline-alerts/2025-10-01/patterns/alz4Subs/alzArm4Subs.json --location $location --parameters "alzArm4Subs.param.json"
```

{{% /tab %}}

{{< /tabs >}}

## Next Steps

To remediate non-compliant policies, continue with [Policy Remediation](../Remediate-Policies)
