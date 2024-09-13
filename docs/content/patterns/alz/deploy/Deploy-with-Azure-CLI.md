---
title: Deploy with Azure CLI
weight: 30
---

{{% include "parameterConfiguration.md" %}}

## 3. Configuring variables for deployment

The following commands apply to all scenarios, whether you are aligned or unaligned with ALZ or have a single management group.

Open your preferred command-line tool (Windows PowerShell, Cmd, Bash or other Unix shells), and navigate to the root of the cloned repo and log on to Azure with an account with at least Resource Policy Contributor access at the root of the management group hierarchy where you will be creating the policies and initiatives.

Run the following commands:

```bash
location="Your Azure location of choice"
pseudoRootManagementGroup="The pseudo root management group id parenting the Platform and Landing Zones management groups"
```

{{< hint type=Important >}}
When running Azure CLI from PowerShell the variables have to start with a $.

Above-mentioned "pseudoRootManagementGroup" variable value, being the so called "pseudo root management group id", should _coincide_ with the value of the "enterpriseScaleCompanyPrefix" parameter, as set previously within the parameter files.

The location variable refers to the deployment location. Deploying to multiple regions is not necessary as the definitions and assignments are scoped to a management group and are not region-specific.
{{< /hint >}}

## 4. Deploying AMBA

The following commands apply to all scenarios, whether you are aligned or unaligned with ALZ or have a single management group.

Using your preferred command-line tool (Windows PowerShell, Cmd, Bash or other Unix shells), if you closed your previous session, navigate again to the root of the cloned repo and log on to Azure with an account with at least Resource Policy Contributor access at the root of the management group hierarchy where you will be creating the policies and initiatives.

{{< hint type=note >}}
This should be tested in a safe environment. If you are subsequently looking to deploy to prod environments, consider leveraging the guidance found in [Customize Policy Assignment](../Customize-Policy-Assignment), to deploy and enable alerts in a controlled manner.

If you customized the policies as documented at [How to modify individual policies](./Introduction-to-deploying-the-ALZ-Pattern.md#how-to-modify-individual-policies), make sure the run the deployment command using your own repository and branch in the ***--template-uri*** parameter value. Example:

    az deployment mg create --name "amba-GeneralDeployment" --template-uri  https://raw.githubusercontent.com/***YourGithubFork***/azure-monitor-baseline-alerts/***main
    or branchname***/patterns/alz/alzArm.json --location $location --management-group-id $pseudoRootManagementGroup --parameters ".\patterns\alz\alzArm.param.json"
{{< /hint >}}

```bash
az deployment mg create --name "amba-GeneralDeployment" --template-uri https://raw.githubusercontent.com/Azure/azure-monitor-baseline-alerts/2024-09-02/patterns/alz/alzArm.json --location $location --management-group-id $pseudoRootManagementGroup --parameters ".\patterns\alz\alzArm.param.json"
```

## Next steps

To remediate non-compliant policies, continue with [Policy remediation](../Remediate-Policies)
