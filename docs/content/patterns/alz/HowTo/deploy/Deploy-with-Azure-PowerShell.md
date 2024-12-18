---
title: Deploy with Azure PowerShell
weight: 40
---

{{% include "parameterConfiguration.md" %}}

## 3. Configuring Variables for Deployment

These steps are applicable to all scenarios, whether aligned or unaligned with ALZ, or if you have a single management group.

1. Open a PowerShell prompt and navigate to the root of the cloned repository.
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

## 4. Deploy Policy Definitions, Initiatives, and Policy Assignments with Default Settings

{{< hint type=important >}}
Deploying through PowerShell requires authentication to Azure and the following modules:

- Az.Accounts
- Az.Resources

Before starting the deployment, ensure you have logged in using the `Connect-AzAccount` PowerShell command and that the modules above have been imported.
{{< /hint >}}

These steps are applicable to all scenarios, whether aligned or unaligned with ALZ, or if you have a single management group.

If you have closed your previous session, open a PowerShell prompt and navigate to the root of the cloned repository. Log in to Azure with an account that has at least Resource Policy Contributor access at the root of the management group hierarchy where you will be creating the policies and initiatives. Then, run the following command:

{{< hint type=note >}}
For testing purposes, it is recommended to deploy in a safe environment first. When preparing for production deployment, refer to the [Customize Policy Assignment](../Customize-Policy-Assignment) guide to deploy and enable alerts in a controlled manner.

If you have customized the policies as described in [How to Modify Individual Policies](../Introduction-to-deploying-the-ALZ-Pattern#how-to-modify-individual-policies), ensure that you run the deployment command using your own repository and branch in the `-TemplateUri` parameter. For example:

```powershell
New-AzManagementGroupDeployment -Name "amba-GeneralDeployment" -ManagementGroupId $pseudoRootManagementGroup -Location $location -TemplateUri "https://raw.githubusercontent.com/***YourGithubFork***/azure-monitor-baseline-alerts/***main or branchname***/patterns/alz/alzArm.json" -TemplateParameterFile ".\patterns\alz\alzArm.param.json"
```
{{< /hint >}}

```powershell
New-AzManagementGroupDeployment -Name "amba-GeneralDeployment" -ManagementGroupId $pseudoRootManagementGroup -Location $location -TemplateUri "https://raw.githubusercontent.com/Azure/azure-monitor-baseline-alerts/2024-12-10/patterns/alz/alzArm.json" -TemplateParameterFile ".\patterns\alz\alzArm.param.json"
```

## Next Steps

To remediate non-compliant policies, continue with [Policy Remediation](../Remediate-Policies).