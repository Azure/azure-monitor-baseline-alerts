---
title: Deploy with Azure PowerShell
weight: 40
---

{{% include "parameterConfiguration.md" %}}

## 3. Configuring variables for deployment

The following changes apply to all scenarios, whether you are aligned or unaligned with ALZ or have a single management group.

Open a PowerShell prompt, navigate to the root of the cloned repo and log on to Azure with an account with at least Resource Policy Contributor access at the root of the management group hierarchy where you will be creating the policies and initiatives.

Run the following commands:

```powershell
$location = "Your Azure location of choice"
$pseudoRootManagementGroup = "The pseudo root management group id parenting the Platform and Landing Zones management groups"
```

{{< hint type=important >}}
Above-mentioned "pseudoRootManagementGroup" variable value, being the so called "pseudo root management group id", should _coincide_ with the value of the "parPolicyPseudoRootMgmtGroup" parameter, as set previously within the parameter files.

The location variable refers to the deployment location. Deploying to multiple regions is not necessary as the definitions and assignments are scoped to a management group and are not region-specific.
{{< /hint >}}

## 4. Deploy the policy definitions, initiatives and policy assignments with default settings

{{< hint type=Important >}}
Deploying through PowerShell, requires authentication to Azure and the following modules:

- Az.Accounts
- Az.Resources

Before starting the deployment, make sure you logged in using the Connect-AzAccount PowerShell command and that the modules above are imported.
{{< /hint >}}

The following changes apply to all scenarios, whether you are aligned or unaligned with ALZ or have a single management group.

Using a PowerShell prompt, if you closed your previous session, navigate again to the root of the cloned repo and log on to Azure with an account with at least Resource Policy Contributor access at the root of the management group hierarchy where you will be creating the policies and initiatives and run the command below.

{{< hint type=note >}}
This should be tested in a safe environment. If you are later looking to deploy to prod environments, consider using the guidance found in [Customize Policy Assignment](../Customize-Policy-Assignment), to deploy and enable alerts in a controlled manner.

If you customized the policies as documented at [How to modify individual policies](./Introduction-to-deploying-the-ALZ-Pattern.md#how-to-modify-individual-policies), make sure the run the deployment command using your own repository and branch in the _***-TemplateUri***_ parameter value. Example:

    New-AzManagementGroupDeployment -Name "amba-GeneralDeployment" -ManagementGroupId $pseudoRootManagementGroup -Location $location
    -TemplateUri "https://raw.githubusercontent.com/***YourGithubFork***/azure-monitor-baseline-alerts/***main or branchname***/patterns/alz/alzArm.json"
    -TemplateParameterFile ".\patterns\alz\alzArm.param.json"
{{< /hint >}}

```powershell
New-AzManagementGroupDeployment -Name "amba-GeneralDeployment" -ManagementGroupId $pseudoRootManagementGroup -Location $location -TemplateUri "https://raw.githubusercontent.com/Azure/azure-monitor-baseline-alerts/2024-09-02/patterns/alz/alzArm.json" -TemplateParameterFile ".\patterns\alz\alzArm.param.json"
```

## Next steps

To remediate non-compliant policies, continue with [Policy remediation](../Remediate-Policies)
