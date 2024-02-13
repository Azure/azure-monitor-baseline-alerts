---
title: Deploy with GitHub Actions
weight: 60
---

{{% include "parameterConfiguration.md" %}}

## 3. Configure and run the workflow

First, configure your OpenID Connect as described [here](https://learn.microsoft.com/en-us/azure/developer/github/connect-from-azure?tabs=azure-portal%2Cwindows#use-the-azure-login-action-with-openid-connect).

To deploy through GitHub actions, refer to the [sample-workflow.yml](https://github.com/Azure/azure-monitor-baseline-alerts/blob/main/patterns/alz/examples/sample-workflow.yml).

{{< hint type=note >}}
If you customized the policies as documented at [How to modify individual policies](./Introduction-to-deploying-the-ALZ-Pattern.md#how-to-modify-individual-policies), make sure to modify the workflow file to have the **run** pointing to your own repository and branch. Example:

    run: |
      az deployment mg create --name "amba-GeneralDeployment" --template-uri https://raw.githubusercontent.com/***YourGithubFork***/azure-monitor-baseline-alerts/***main or
      branchname***/patterns/alz/alzArm.json --location ${{ env.Location }} --management-group-id ${{ env.ManagementGroupPrefix }} --parameters .\patterns\alz\alzArm.param.json

{{< /hint >}}

### Modify variables and run the workflow

- Modify the following values in [amba-sample-workflow.yml](https://github.com/Azure/azure-monitor-baseline-alerts/blob/main/patterns/alz/examples/sample-workflow.yml):
  - Change _Location: "norwayeast"_, to your preferred Azure region
  - Change _ManagementGroupPrefix: "alz"_, to the pseudo root management group id parenting the identity, management and connectivity management groups.
- Go to GitHub actions and run the action *Deploy AMBA*

{{< hint type=important >}}
Above-mentioned "ManagementGroupPrefix" variable value, being the so called "pseudo root management group id", should _coincide_ with the value of the "parPolicyPseudoRootMgmtGroup" parameter, as set previously within the parameter files.

The location variable refers to the deployment location. Deploying to multiple regions is not necessary as the definitions and assignments are scoped to a management group and are not region-specific.
{{< /hint >}}

## Next steps

To remediate non-compliant policies, continue with [Policy remediation](../Remediate-Policies)
