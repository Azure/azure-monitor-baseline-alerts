---
title: FAQ
geekdocCollapseSection: true
weight: 80
---

### In this page

> [Do I need to have Azure Landing zones deployed for this to work?](../FAQ#do-i-need-to-have-azure-landing-zones-deployed-for-this-to-work) </br>
> [Can I deploy to the Tenant Root Group?](../FAQ#can-i-deploy-to-the-tenant-root-group) </br>
> [Do I need to deploy to each region that I want to monitor?](../FAQ#do-i-need-to-deploy-to-each-region-that-i-want-to-monitor) </br>
> [Do I need to use the thresholds defined as default values in the metric rule alerts?](../FAQ#do-i-need-to-use-the-thresholds-defined-as-default-values-in-the-metric-rule-alerts) </br>
> [Why are the availability alert thresholds lower than 100% in this solution when the product group documentation recommends 100%?](../FAQ#why-are-the-availability-alert-thresholds-lower-than-100-in-this-solution-when-the-product-group-documentation-recommends-100) </br>
> [Do I need to use these metrics or can they be replaced with ones more suited to my environment?](../FAQ#do-i-need-to-use-these-metrics-or-can-they-be-replaced-with-ones-more-suited-to-my-environment) </br>
> [Can I disable the alerts being deployed for a resource or subscription?](../FAQ#can-i-disable-the-alerts-being-deployed-for-a-resource-or-subscription) </br>
> [How much does it cost to run the ALZ Baseline solution?](../FAQ#how-much-does-it-cost-to-run-the-alz-baseline-solution) </br>
> [Can I access the Visio diagrams displayed in the documentation?](../FAQ#can-i-access-the-visio-diagrams-displayed-in-the-documentation) </br>
> [Can I use AMBA-ALZ without cloning/forking a GitHub repository](../FAQ#can-i-use-amba-alz-without-cloningforking-a-github-repository) </br>
> [Can I deploy a local template by using -TemplateFile](../FAQ#can-i-deploy-a-local-template-by-using--templatefile) </br>
> [What characters can I use when creating Azure resources or renaming Azure subscriptions?](../FAQ#what-characters-can-i-use-when-creating-azure-resources-or-renaming-azure-subscriptions) </br>
> [Can I exclude Management Groups or Subscriptions from policy assignment?](../FAQ#can-i-exclude-management-groups-or-subscriptions-from-policy-assignment) </br>

## Do I need to have Azure Landing zones deployed for this to work?

> No, Azure Landing Zones are not required. However, you must use Azure Management Groups. Currently, our focus is on resources commonly deployed as part of Azure Landing Zone implementations.

## Can I deploy to the Tenant Root Group?

> Although it is recommended to implement the alert policies and initiatives within an Azure Landing Zone (ALZ) Management Group hierarchy, it is not a technical requirement. However, avoid assigning policies to the Tenant Root Group to minimize the complexity of debugging inherited policies at lower-level management groups. For more information, refer to the [CAF documentation](https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/ready/landing-zone/design-area/resource-org-management-groups).

## Do I need to deploy to each region that I want to monitor?

> No, deployment to multiple regions is not required. The definitions and assignments are scoped at the management group level and are not specific to any region.

## Do I need to use the thresholds defined as default values in the metric rule alerts?

> The provided thresholds are intended as a starting point, based on Microsoft's recommendations and field experience. You may need to adjust these thresholds to suit your specific environment. Monitor the alerts and adjust the thresholds accordingly: increase the threshold if the alerts are too frequent, or decrease it if the alerts are not triggering when they should. Once you have determined an appropriate threshold, consider sharing your findings with us for broader use.

## Why are the availability alert thresholds lower than 100% in this solution when the product group documentation recommends 100%?

> Setting a threshold of 100% can sometimes result in false alerts, creating unnecessary noise. By lowering the threshold slightly below 100%, this issue can be mitigated while still ensuring alerts for service availability. If the default threshold is not stringent enough, you are encouraged to adjust it upwards. Additionally, you can provide feedback by filing an issue in our GitHub repository: [GitHub Issue](https://github.com/Azure/azure-monitor-baseline-alerts/issues).

## Do I need to use these metrics or can they be replaced with ones more suited to my environment?

> The metric rules provided are based on Microsoft's recommendations and field experience. Your usage of Azure resources may vary, so it is advisable to customize the alerts to meet your specific requirements. The primary objective of this project is to facilitate scalable Azure Monitor alerts. You are encouraged to create new rules with your own thresholds. We welcome feedback on your custom rules, so please share your findings with us.

## Can I disable the alerts being deployed for a resource or subscription?

> Yes, you can disable the alerts for a specific resource or subscription. For detailed instructions, please refer to the [Disabling Policies](../../HowTo/Disabling-Policies) documentation.

## How much does it cost to run the ALZ Baseline solution?

> The cost of running the ALZ Baseline solution varies based on several factors, including the number of alert rules deployed, the number of subscriptions inheriting the baseline policies, and the resources within each subscription that match the policy rules. Each alert rule costs approximately $0.1 per month<sup>1</sup>.
>
> - Alert rules are charged based on the number of evaluations.
> - If the alert rule evaluates data continuously throughout the month, the cost is approximately $0.1<sup>1</sup>.
> - If the rule evaluates data intermittently (e.g., due to the monitored resource being down and not sending telemetry), the cost is prorated based on the time the rule was actively evaluating data.
> - Using Dynamic Thresholds doubles the cost of the alert rule, resulting in a total cost of approximately $0.2 per month<sup>1</sup>.
> - The solution configures an email address as part of the Action Groups deployment (one per subscription), with a charge of approximately $2 per month for every 1,000 emails<sup>1</sup>.
>
> {{< hint type=Note >}} It is advisable to evaluate the costs in a non-production environment before full deployment to ensure a clear understanding of the potential expenses.{{< /hint >}}
>
> For detailed cost estimates related to your deployment, please refer to the [Azure Monitor Pricing](https://azure.microsoft.com/en-us/pricing/details/monitor/) page. Additionally, you can collaborate with your local Microsoft account team to develop a rough order of magnitude (RoM) cost estimate.
> <sup>1</sup> Note that costs may vary slightly depending on the deployment region. The costs mentioned are based on pricing as of April 2023.

## Can I access the Visio diagrams displayed in the documentation?

> Yes, you can access the Visio diagrams in the [media](https://github.com/Azure/azure-monitor-baseline-alerts/tree/main/docs/content/patterns/alz/media) folder.

## Can I use AMBA-ALZ without cloning/forking a GitHub repository

> <p> Yes, as long as the ARM templates are publicly accessible. This solution includes several linked templates that must be accessible publicly. When the top-level ARM template is submitted to Azure Resource Manager, the linked templates are not automatically uploaded and need to be pulled in at deploy time from Azure. Therefore, they must be referenced using a URL accessible from Azure (e.g., via a public GitHub repository). <p>
>
> <p> Alternatively, you can use Template specs. Instead of maintaining your linked templates at an accessible endpoint, you can create a template spec that packages the main template and its linked templates into a single entity for deployment. The template spec is a resource in your Azure subscription, making it easy to securely share the template with users in your organization. You can use Azure role-based access control (Azure RBAC) to grant access to the template spec. This feature is currently in preview.<p>
>
> References:
>
> - [Template specs](https://learn.microsoft.com/en-us/azure/azure-resource-manager/templates/linked-templates?>tabs=azure-powershell#template-specs)
> - [ARM Private deployment](https://github.com/Azure/ARM-private-deployment)

## Can I deploy a local template by using -TemplateFile

> No, using the `-TemplateFile` parameter is not feasible because the ARM template includes linked templates. When referencing a linked template, the URI value cannot be a local file or a file accessible only on your local network. Azure Resource Manager must have access to the template, which requires the templates to be referenced using a URL accessible from Azure (e.g., a public GitHub repository).

## What characters can I use when creating Azure resources or renaming Azure subscriptions?

> Not all characters are allowed when creating Azure resources or renaming Azure subscriptions. For a comprehensive list of supported characters, refer to the [Naming rules and restrictions for Azure resources](https://learn.microsoft.com/en-us/azure/azure-resource-manager/management/resource-name-rules) documentation. For example, alert suppression rules permit only alphanumeric characters, underscores, and hyphens.
>
> - **_a_** through **_z_** (lowercase letters)
> - **_A_** through **_Z_** (uppercase letters)
> - **_0_** through **_9_** (numbers)
>
> Using unsupported characters when creating an Azure resource or renaming a subscription can lead to the following issues:
>
> - Resource creation will fail.
> - Deployment of action groups and/or alert processing rules will fail. For AMBA-specific issues, refer to the [Failed to deploy action group(s) and/or alert processing rule(s)](../Known-Issues#failed-to-deploy-action-groups-andor-alert-processing-rules) section in the [Known Issues](../Known-Issues) documentation.
> - Editing action groups will result in an Azure portal page error. For AMBA-specific issues, refer to the [Failed to edit action group(s)](../Known-Issues#failed-to-edit-action-groups) section in the [Known Issues](../Known-Issues) documentation.

## Can I exclude Management Groups or Subscriptions from policy assignment?

> {{< hint type=Note >}} For deployments (update or new) happening after <ins>**March 2025 the 25th**</ins> using the code in either the _**main**_ branch or any _**new**_ release, it is possible to configure some new parameters to perform the exclusion at scale during the deployment. Read more at [Exclude Management Groups and/or Subscription from Policy Assignment](../../HowTo/Exclude_resources_from_policy_assignment).{{< /hint >}}
>
> When deploying at scale, we include all management groups and subscriptions under the pseudo root management group hierarchy. This might results in the inclusion of unwanted or unnecessary resources. Should this be the case, it is possible to exclude them after the deployment. To do so, it is necessary to:
>
> 1. Open the <a href="https://portal.azure.com" target="_blank">Azure portal</a> and navigate to _**Policy**_
>
>     ![Policy](../../media/ManualExclusion-1.png)
>
> 2. Click on _**Assignment**_
>
>     ![Assignments blade](../../media/ManualExclusion-2.png)
>
> 3. Click on _**Scope**_, set the scope to management group the relevant assignment is targeted to (for example the **Identity**) and click _**Select**_
>
>     ![Scope](../../media/ManualExclusion-3.png)
>
> 4. Select and click on the assignment to perform the exclusion on. _Notice that the list will include both the assignments inherited from the parent MG those applied to child management groups._
>
>     ![Assignments items](../../media/ManualExclusion-4.png)
>
> 5. In the assignment blade, click on _**Edit**_
>
>     ![Edit assignment](../../media/ManualExclusion-5.png)
>
> 6. Click on the ellipsis next to the _**Exclusion**_ box to select what to exclude. A new context windows, will show the hierarchy of resouces that could be added to the exclusion scope based on the assigned scope. _Notice that the list will include the parent scope and only child resources._ Make the selection, click _**Add to Selected Scope**_ and then click _**Save**_
>
>     ![Set exclusion scope](../../media/ManualExclusion-6.png)
>
> 7. Now the _**Exclusion**_ contains the excluded resource names. Click on _**Review + Save**_
>
>     ![Review + Save](../../media/ManualExclusion-7.png)
>
> 8. and then _**Save**_
>
>     ![Save](../../media/ManualExclusion-8.png)
>
> 9. If remediation has been already performed, it will be necessary to delete the related alerts. If not, perform the remediation according to guidance provided at [Remediate Policies](../../HowTo/deploy/Remediate-Policies). Alerts for resources in the excluded scope will not be created.
>
