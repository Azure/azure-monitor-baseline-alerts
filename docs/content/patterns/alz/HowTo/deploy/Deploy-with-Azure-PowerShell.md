---
title: Deploy with Azure PowerShell
weight: 50
---

### In this page

> [Parameter Configuration](#1-parameter-configuration) </br>
> [Sample Parameter File](#2-sample-parameter-file) </br>
> [Configuring Variables for Deployment](#3-configuring-variables-for-deployment) </br>
> [Deploy Policy Definitions, Initiatives, and Policy Assignments with Default Settings](#4-deploy-policy-definitions-initiatives-and-policy-assignments-with-default-settings) </br>
> [Next Steps](#next-steps) </br>

{{< hint type=Important >}}
Updating from the _**preview**_ version is not supported. If you deployed the _**preview**_ version, please follow the steps in [Moving from preview to GA](../../../HowTo/UpdateToNewReleases/Moving-from-preview-to-GA) before proceeding.
{{< /hint >}}

## 1. Parameter Configuration

{{< tabs "Deploy_PSH_Param1" >}}

{{% tab "Management Group (hierarchy or single)" %}}

{{% include "parameterConfiguration_1.md" %}}

{{% /tab %}}

{{% tab "Cloud Solution Provider (CSP) or Azure Lighthouse" %}}

{{% include "parameterConfiguration_Subs_1.md" %}}

{{% /tab %}}

{{< /tabs >}}

## 2. Sample Parameter File

{{< tabs "Deploy_PSH_Param2" >}}

{{% tab "Management Group (hierarchy or single)" %}}

{{% include "parameterConfiguration_2.md" %}}

{{% /tab %}}

{{% tab "Cloud Solution Provider (CSP) or Azure Lighthouse" %}}

{{% include "parameterConfiguration_Subs_2.md" %}}

{{% /tab %}}

{{< /tabs >}}

## 3. Configuring Variables for Deployment

{{< tabs "Deploy_PSH_Variables" >}}

{{% tab "Management Group (hierarchy or single)" %}}

These steps are applicable to all scenarios, whether aligned or unaligned with ALZ, or if you have a single management group.

1. Open a PowerShell prompt and navigate to the folder where the parameter file was downloaded.
2. Log in to Azure with an account that has at least Resource Policy Contributor access at the root of the management group hierarchy where you will be creating the policies and initiatives.

Execute the following commands:

```powershell
$location = "Your Azure location of choice"
$pseudoRootManagementGroup = "The pseudo root management group ID parenting the identity, management, and connectivity management groups"
```

{{< hint type=important >}}
The `pseudoRootManagementGroup` variable must match the value of the `parPolicyPseudoRootMgmtGroup` parameter as defined in the parameter files.

The `location` variable specifies the deployment region. It is not required to deploy to multiple regions since the definitions and assignments are scoped to a management group and are not region-specific.
{{< /hint >}}

{{% /tab %}}

{{% tab "Cloud Solution Provider (CSP) or Azure Lighthouse" %}}

1. Open a PowerShell prompt and navigate to the folder where the parameter file was downloaded.
2. Log in to Azure with an account that has at least Owner access on the subscription where you will be creating the policies and initiatives.

Execute the following commands:

```powershell
$location = "Your Azure location of choice"
$targetSubscription="The subscription ID where to deploy AMBA-ALZ"
```

{{< hint type=important >}}
The `targetSubscription` variable should match the value of the `topLevelSubscriptionId` parameter, as defined in the parameter files.

The `location` variable specifies the deployment region. It is not required to deploy to multiple regions since the definitions and assignments are scoped to a subscription and are not region-specific.
{{< /hint >}}

{{% /tab %}}

{{< /tabs >}}

## 4. Deploy Policy Definitions, Initiatives, and Policy Assignments with Default Settings

{{< tabs "Deploy_PSH_Deploy" >}}

{{% tab "Management Group (hierarchy or single)" %}}

{{< hint type=important >}}
Deploying through PowerShell requires authentication to Azure and the following modules:

- Az.Accounts
- Az.Resources

Before starting the deployment, ensure you have logged in using the `Connect-AzAccount` PowerShell command and that the modules above have been imported.
{{< /hint >}}

These steps are applicable to all scenarios, whether aligned or unaligned with ALZ, or if you have a single management group.

If you have closed your previous session, open a PowerShell prompt and navigate to the folder where the parameter file was downloaded. Log in to Azure with an account that has at least Resource Policy Contributor access at the root of the management group hierarchy where you will be creating the policies and initiatives. Then, run the following command:

{{< hint type=note >}}
For testing purposes, it is recommended to deploy in a safe environment first. When preparing for production deployment, refer to the [Customize Policy Assignment](../Customize-Policy-Assignment) guide to deploy and enable alerts in a controlled manner.

If you have customized the policies as described in [How to Modify Individual Policies](../Introduction-to-deploying-the-ALZ-Pattern#how-to-modify-individual-policies), ensure that you run the deployment command using your own repository and branch in the `-TemplateUri` parameter. For example:

```powershell
New-AzManagementGroupDeployment -Name "amba-MainDeployment" -ManagementGroupId $pseudoRootManagementGroup -Location $location -TemplateUri "https://raw.githubusercontent.com/***YourGithubFork***/azure-monitor-baseline-alerts/***main or branchname***/patterns/alz/alzArm.json" -TemplateParameterFile ".\patterns\alz\alzArm.param.json"
```

{{< /hint >}}

```powershell
New-AzManagementGroupDeployment -Name "amba-MainDeployment" -ManagementGroupId $pseudoRootManagementGroup -Location $location -TemplateUri "https://raw.githubusercontent.com/Azure/azure-monitor-baseline-alerts/2025-10-01/patterns/alz/alzArm.json" -TemplateParameterFile "alzArm.param.json"
```

{{% /tab %}}

{{% tab "Cloud Solution Provider (CSP) or Azure Lighthouse" %}}

{{< hint type=important >}}
Deploying through PowerShell requires authentication to Azure and the following modules:

- Az.Accounts
- Az.Resources

Before starting the deployment, ensure you have logged in using the `Connect-AzAccount` PowerShell command and that the modules above have been imported.
{{< /hint >}}

If you have closed your previous session, open a PowerShell prompt and navigate to the folder where the parameter file was downloaded. Log in to Azure with an account that has at least Owner access on the subscription where you will be creating the policies and initiatives. Then, run the following command:

{{< hint type=note >}}
For testing purposes, it is recommended to deploy in a safe environment first. When preparing for production deployment, refer to the [Customize Policy Assignment](../Customize-Policy-Assignment) guide to deploy and enable alerts in a controlled manner.

If you have customized the policies as described in [How to Modify Individual Policies](../Introduction-to-deploying-the-ALZ-Pattern#how-to-modify-individual-policies), ensure that you run the deployment command using your own repository and branch in the `-TemplateUri` parameter. For example:

```powershell
Set-AzContext -Subscription $targetSubscription
New-AzSubscriptionDeployment -Name "amba-MainDeployment" -Location $location -TemplateUri "https://raw.githubusercontent.com/***YourGithubFork***/azure-monitor-baseline-alerts/***main or branchname***/patterns/alz/alzArm.json" -TemplateParameterFile ".\patterns\alz\alzArm.param.json"
```

{{< /hint >}}

```powershell
Set-AzContext -Subscription $targetSubscription
New-AzSubscriptionDeployment -Name "amba-MainDeployment" -Location $location -TemplateUri "https://raw.githubusercontent.com/Azure/azure-monitor-baseline-alerts/2025-10-01/patterns/alz/alzArm.json" -TemplateParameterFile "alzArm.param.json"
```

{{% /tab %}}

{{< /tabs >}}

## Next Steps

To remediate non-compliant policies, continue with [Policy Remediation](../Remediate-Policies).
