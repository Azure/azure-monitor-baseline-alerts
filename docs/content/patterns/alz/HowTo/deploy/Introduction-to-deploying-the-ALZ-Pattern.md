---
title: Introduction to deploying the AMBA-ALZ Pattern
weight: 10
---

### In this page

> [Background](../Introduction-to-deploying-the-ALZ-Pattern#background) </br>
> [Prerequisites](../Introduction-to-deploying-the-ALZ-Pattern#prerequisites) </br>
> [Getting Started](../Introduction-to-deploying-the-ALZ-Pattern#getting-started) </br>
> [Determining your Management Group Hierarchy](../Introduction-to-deploying-the-ALZ-Pattern#determining-your-management-group-hierarchy) </br>
> [Customizing Policy Assignments](../Introduction-to-deploying-the-ALZ-Pattern#customizing-policy-assignments) </br>
> [Customizing the AMBA-ALZ Policies](../Introduction-to-deploying-the-ALZ-Pattern#customizing-the-amba-alz-policies) </br>
> [Disabling Monitoring](../Introduction-to-deploying-the-ALZ-Pattern#disabling-monitoring) </br>
> [Cleaning up an ALZ Deployment](../Introduction-to-deploying-the-ALZ-Pattern#cleaning-up-an-amba-alz-deployment) </br>
> [Next Steps](../Introduction-to-deploying-the-ALZ-Pattern#next-steps) </br>

## Background

This guide provides instructions on how to begin implementing alert policies and initiatives in your environment for testing and validation. It assumes that you will use GitHub Actions or manual deployment methods to implement policies, initiatives, and policy assignments in your environment.

The repository currently includes code and detailed instructions for the following:

- Policies to automatically create alerts, action groups, and alert processing rules for various Azure resource types, based on a recommended Azure Monitor Baseline for Alerting in a customer's newly created or existing brownfield ALZ deployment.
- Initiatives that group these policies into appropriate categories for easier policy assignment, aligned with the ALZ Platform structure (Networking, Identity, and Management).

Alerts, action groups, and alert processing rules are created as follows:

1. Metric alerts are created in the resource group where the monitored resource resides. For instance, if an ER circuit is created in a resource group governed by the policies, the corresponding alerts will be created in that same resource group.
2. Activity log alerts are created in a designated resource group (specifically created and used for this solution) within each subscription upon deployment. The resource group name is parameterized, with a default value of `rg-amba-monitoring-001`.
3. Resource health alerts are created in a designated resource group (specifically created and used for this solution) within each subscription upon deployment. The resource group name is parameterized, with a default value of `rg-amba-monitoring-001`.
4. Action groups and alert processing rules are created in a designated resource group (specifically created and used for this solution) within each subscription upon deployment. The resource group name is parameterized, with a default value of `rg-amba-monitoring-001`.

## Prerequisites

1. A Microsoft Entra ID Tenant.
2. An ALZ Management group hierarchy deployed as outlined in the [Azure landing zone design areas and conceptual architecture](https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/ready/landing-zone/design-areas) documentation.
3. At least one subscription for deploying alerts through policies.
4. A Deployment Identity with `Owner` permissions to the pseudo root management group. This permission is necessary for the Service Principal Account to create role-based access control assignments.
5. If deploying manually via Azure CLI or PowerShell, ensure [Bicep](https://learn.microsoft.com/en-us/azure/azure-resource-manager/bicep/overview?tabs=bicep) is installed and configured. Refer to the configuration guides for [Azure CLI](https://learn.microsoft.com/en-us/azure/azure-resource-manager/bicep/install#azure-cli) and [PowerShell](https://learn.microsoft.com/en-us/azure/azure-resource-manager/bicep/install#azure-powershell).
6. The following Azure resource providers must be registered on all subscriptions in scope for the policies to function correctly:
   - Microsoft.AlertsManagement
   - Microsoft.Insights

  For instructions on registering a resource provider, refer to the [resource provider registration guide](https://learn.microsoft.com/en-us/azure/azure-resource-manager/management/resource-providers-and-types#register-resource-provider).

7. To utilize log alerts for virtual machines (both Azure and Azure Arc), ensure that VM Insights is enabled for the virtual machines to be monitored. For more information on deploying VM Insights, refer to the [VM Insights deployment guide](https://learn.microsoft.com/en-us/azure/azure-monitor/vm/vminsights-enable-overview). Note that only the performance collection aspect of the VM Insights solution is required for the current alerts to function.

{{< hint type=note >}}
While it is recommended to implement the alert policies and initiatives within an ALZ Management Group hierarchy, it is not a strict technical requirement. Avoid assigning policies to the Tenant Root Group to minimize debugging inherited policies at lower-level management groups (refer to the [CAF documentation](https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/ready/landing-zone/design-area/resource-org-management-groups)). These policies and initiatives can also be applied in existing brownfield scenarios that do not follow the ALZ Management Group hierarchy, such as hierarchies with a single management group or those that do not align with ALZ. At least one management group is required. If management groups have not been implemented, guidance on how to get started is provided.
{{< /hint >}}

## Getting Started

- Fork this repository to your own GitHub organization. Do not create a direct clone of the repository, as pull requests from direct clones will not be accepted.
- Clone the repository from your GitHub organization to your local development environment.
- Review your current configuration to identify the applicable scenario. We provide guidance for deploying these policies and initiatives whether you are aligned with Azure Landing Zones, use a different management group hierarchy, or do not use management groups at all. If you already know your management group hierarchy type, proceed to your preferred deployment method:

  - [Deploy via the Azure Portal Accelerator](../Deploy-via-Azure-Portal-UI)  (recommended method)
  - [Automated deployment with GitHub Actions](../Deploy-with-GitHub-Actions) (recommended method)
  - [Automated deployment with Azure Pipelines](../Deploy-with-Azure-Pipelines) (recommended method)
  - [Manual deployment with Azure CLI](../Deploy-with-Azure-CLI)
  - [Manual deployment with Azure PowerShell](../Deploy-with-Azure-PowerShell)

## Determining your Management Group Hierarchy

Azure Landing Zones provide a framework of best practices, patterns, and tools for establishing a secure, Well-Architected, and manageable cloud environment. A crucial element of Azure Landing Zones is the use of management groups, which enable the organization and management of subscriptions and resources in a hierarchical structure. Management groups facilitate the application of policies and access controls across multiple subscriptions and resources, simplifying the governance and management of your Azure environment.

The initiatives in this repository are designed to align with the management group hierarchy guidelines of Azure Landing Zones. This alignment results in the following assignment mapping between the initiatives and the management groups:

- Identity Initiative is assigned to the Identity management group.
- Management Initiative is assigned to the Management management group.
- Connectivity Initiative is assigned to the Connectivity management group.
- Landing Zone Initiative is assigned to the Landing Zone management group.
- Service Health Initiative is assigned to the intermediate (ALZ) root management group.

The image below illustrates a management group hierarchy that aligns with Azure Landing Zone guidance. It also shows the default recommended assignments for the initiatives.

![ALZ Management group structure](../../../media/alz-management-groups.png)

The following diagram illustrates the flow of policy initiatives and their associated policy definitions, represented by the orange dash-lines. Note that the Service Health Initiative is assigned at the pseudo root of the management group structure, in this case, the Contoso management group. This initiative includes the policy that deploys the alert processing rules and action group to each subscription.

The other monitoring initiatives are assigned to specific platform landing zone management groups and workload landing zones. These flows are represented by blue dashed lines.

![Azure Monitor Baseline Alerts policy initiative flows](../../../media/azure-monitor-baseline-alerts-policy-initiative-flow.svg)

*Download a [Visio file](../../../media/AMBA-Diagrams.vsdx) of this architecture.*

If your management group hierarchy matches this structure, you can proceed directly to your preferred deployment method:

- [Deploy via the Azure Portal Accelerator](../Deploy-via-Azure-Portal-UI)
- [Deploy with GitHub Actions](../Deploy-with-GitHub-Actions)
- [Deploy with Azure Pipelines](../Deploy-with-Azure-Pipelines)
- [Deploy with Azure CLI](../Deploy-with-Azure-CLI)
- [Deploy with Azure PowerShell](../Deploy-with-Azure-PowerShell)

It is crucial to understand the rationale behind assigning initiatives to specific management groups. In the previous example, the assignment mapping was structured based on the purpose of the associated resources within a subscription under a management group. For instance, the Connectivity management group typically contains subscriptions with networking components such as Firewalls, Virtual WAN, and Hub Networks. Therefore, the connectivity initiative is assigned to this management group to ensure relevant alerting for those services. Assigning the connectivity initiative to other management groups without relevant networking services would not be logical.

We understand that Azure offers flexibility and choice, and your environment may not align with the Azure Landing Zone (ALZ) framework. For instance, you might have:

- A management group structure that does not align with ALZ, where you might only have a Platform management group without sub-management groups like Identity, Management, or Connectivity.
- No management group structure.

{{< hint type=note >}}
If you are looking to align your Azure environment with Azure landing zones, refer to [Transition existing Azure environments to the Azure landing zone conceptual architecture](http://aka.ms/alz/brownfield).
{{< /hint >}}

In scenarios where Identity, Management, and Connectivity are combined into a single Platform Management Group, you can assign the corresponding initiatives to the Platform management group. Alternatively, if your hierarchy is organized by geography or business units instead of specific landing zones, the assignment mapping could be as follows:

- Identity Initiative is assigned to the Platform management group.
- Management Initiative is assigned to the Platform management group.
- Connectivity Initiative is assigned to the Platform management group.
- Landing Zone Initiative is assigned to the Geography management group.
- Service Health Initiative is assigned to the top-most level(s) in your management group hierarchy.

The following image illustrates an example of how the assignments might appear when the management group hierarchy does not align with Azure Landing Zones (ALZ).

![Management group structure - unaligned](../../../media/alz-management-groups-unaligned.png)

We suggest reviewing the [initiative definitions](https://github.com/Azure/azure-monitor-baseline-alerts/tree/main/patterns/alz/policySetDefinitions) to identify the optimal placement of initiatives within your management group hierarchy.

If your management group hierarchy matches this structure, you can proceed directly to your preferred deployment method:

- [Deploy via the Azure Portal Accelerator](../Deploy-via-Azure-Portal-UI)
- [Deploy with GitHub Actions](../Deploy-with-GitHub-Actions)
- [Deploy with Azure Pipelines](../Deploy-with-Azure-Pipelines)
- [Deploy with Azure CLI](../Deploy-with-Azure-CLI)
- [Deploy with Azure PowerShell](../Deploy-with-Azure-PowerShell)

If management groups have not been configured in your environment, you will need to take additional steps. To deploy the policies and initiatives using the provided guidance and code, you must create at least one management group. This action will automatically create the tenant root management group. We highly recommend following the [Azure Landing Zones guidance](https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/ready/landing-zone/design-area/resource-org-management-groups) for management group design.

For detailed instructions on creating management groups, refer to the [official documentation](https://learn.microsoft.com/en-us/azure/governance/management-groups/create-management-group-portal).

If you have adopted the recommended management group design, you can proceed directly to your preferred deployment method, adhering to the ALZ-aligned guidance.

- [Deploy via the Azure Portal Accelerator](../Deploy-via-Azure-Portal-UI)
- [Deploy with GitHub Actions](../Deploy-with-GitHub-Actions)
- [Deploy with Azure Pipelines](../Deploy-with-Azure-Pipelines)
- [Deploy with Azure CLI](../Deploy-with-Azure-CLI)
- [Deploy with Azure PowerShell](../Deploy-with-Azure-PowerShell)

If you have implemented a single management group, it is recommended to move your production subscriptions into that management group. For guidance on adding subscriptions, refer to the [official documentation](https://learn.microsoft.com/en-us/azure/governance/management-groups/manage#add-an-existing-subscription-to-a-management-group-in-the-portal).

{{< hint type=important >}}
To avoid generating unnecessary alerts, it is advisable to place development, sandbox, and other non-production subscriptions in a separate management group or under the tenant root group.
{{< /hint >}}

The following image illustrates an example of how the assignments appear when utilizing a single management group.

![Management group structure - single](../../../media/alz-management-groups-single.png)

## Customizing Policy Assignments

For instructions on customizing policy and initiative assignments, please refer to [Customize Policy Assignment](../Customize-Policy-Assignment).

## Customizing the AMBA-ALZ Policies

We encourage customers and partners to tailor the policies to meet their specific needs and requirements. Customize the policies in your local copies to align with your design preferences.

If you need to include additional thresholds, metrics, or activity log alerts beyond what the parameters allow, you can open the individual policy or initiative definitions. By reviewing and understanding the relevant lines, you can easily customize them to meet your specific requirements.

You can then deploy this customized policy into your environment to achieve the desired functionality.

### How to Modify Individual Policies

Policy files are located in the `services` directory. This directory contains baseline alert definitions, guidance, and example deployment scripts. The structure is organized by resource category (e.g., Compute) and then by resource type (e.g., virtualMachines). The example folder structure below shows the location of individual policy files:

```plaintext
├── patterns
└── services
    └── Compute
        └── virtualMachines
            ├── Deploy-VM-AvailableMemory-Alert.json
            └── Deploy-VM-DataDiskReadLatency-Alert.json
```

To modify settings that are not parameterized, follow these steps:

1. Fork the repository. For detailed instructions, refer to the [Fork a repo](https://docs.github.com/en/get-started/quickstart/fork-a-repo) page.
2. Adjust current policies or introduce new ones as needed.
  {{< hint type=note >}}
  Regardless of whether you are modifying existing policies or adding new ones, you must update the ***policies.bicep*** file.
  {{< /hint >}}
3. Execute the following command to update the ***policies.bicep*** file:

    `bicep build .\patterns\alz\templates\policies.bicep --outfile .\patterns\alz\policyDefinitions\policies.json`

4. Commit and synchronize the changes to your fork.
5. Execute the following command to deploy your locally modified copy:

    ```AZ CLI
    az deployment mg create --template-uri https://raw.githubusercontent.com/***YourGithubFork***/azure-monitor-baseline-alerts/***main or branchname***/patterns/alz/alzArm.json
    --name "amba-MainDeployment" --location $location --management-group-id $pseudoRootManagementGroup --parameters .\patterns\alz\alzArm.param.json
    ```

## Disabling Monitoring

To disable monitoring for a specific resource or for alerts at the subscription level (such as Activity Log, Service Health, and Resource Health), you can create a tag named `MonitorDisable` with the value `true` at the desired scope. This tag will exclude the resource or subscription from the policy compliance check.

{{< hint type=Important >}}
If you think the changes you have made should be customizable via parameters in the policies, open a [GitHub Issue](https://github.com/Azure/azure-monitor-baseline-alerts/issues) to request this feature.

If you have suggestions or feature requests, consider submitting a pull request. We will review and collaborate with you to potentially implement the proposed changes.
{{< /hint >}}

## Cleaning up an AMBA-ALZ Deployment

In certain situations, you may need to remove all resources deployed by the AMBA-ALZ solution. For detailed instructions on how to clean-up an AMBA-ALZ deployment, refer to the [Clean-up an AMBA-ALZ Deployment](../../Cleaning-up-a-Deployment) guide.

## Next Steps

- For instructions on customizing policy assignments, refer to [Customize Policy Assignment](../Customize-Policy-Assignment).
- For deploying using Azure Portal UI, refer to [Deploy via the Azure Portal Accelerator](../Deploy-via-Azure-Portal-UI).
- For deploying with GitHub Actions, refer to [Deploy with GitHub Actions](../Deploy-with-GitHub-Actions).
- For deploying with Azure Pipelines, refer to [Deploy with Azure Pipelines](../Deploy-with-Azure-Pipelines).
- For deploying with Azure CLI, refer to [Deploy with Azure CLI](../Deploy-with-Azure-CLI).
- For deploying with Azure PowerShell, refer to [Deploy with Azure PowerShell](../Deploy-with-Azure-PowerShell).
