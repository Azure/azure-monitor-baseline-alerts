---
title: FAQ
geekdocCollapseSection: true
weight: 80
---

## Do I need to have Azure Landing zones deployed for this to work?

> No but you will need to be using Azure Management groups and for now our focus is on the resources frequently deployed as part of Azure Landing Zone deployments.

## Can I deploy to Tenant Root Group?

> While it´s recommended to implement the alert policies and initiatives to an ALZ Management Group hierarchy, it is not a technical requirement. However, please avoid Tenant Root Group assignments, to minimize debugging inherited policies at lower-level mangement groups, see [CAF documentation](https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/ready/landing-zone/design-area/resource-org-management-groups).

## Do I need to deploy to each region that I want to monitor?

> No, deploying to multiple regions is not necessary. The definitions and assignments are scoped to a management group
> and are not region specific.

## Do I need to use the thresholds defined as default values in the metric rule alerts?

> It's provided as a starting point, we've based the initial thresholds on what we've seen and what Microsoft's documentation recommends. You will need to adjust the thresholds at some point.
> You will need to observe and if the alert is too chatty, adjust the threshold up; if it's not alerting when there's a problem, adjust the threshold down a bit, (or vice-versa depending on what metric or log error is being used as a monitoring source). Once you have decided upon an appropriate value, if you feel it's fit for more general consumption we would love to hear about it.

## Why are the availability alert thresholds lower than 100% in this solution when the product group documentation recommends 100%?

> Setting a threshold of 100% can, on occasion, cause erroneous alerts that generate un-necessary noise. Lowering the threshold slightly below 100% addresses this issue while still providing an alert for a service's availability. If the default threshold isn't aggressive enough we encourage you to adjust it upwards and/or provide us feedback by filing an issue in our GitHub repo [GitHub Issue](https://github.com/Azure/azure-monitor-baseline-alerts/issues).

## Do I need to use these metrics or can they be replaced with ones more suited to my environment?

> The metric rules we've created are based on recommendations from Microsoft documentation and field experience. How you're using Azure resources may also be different so tailor the alerts to suit your needs. The main goal of this project is to help you have a way to do Azure Monitor alerts at scale, create new rules with your own thresholds. We'd love to hear about your new rules too so feel free to share back.

## Can I disable the alerts being deployed for a resource or subscription?

> Yes, please refer to the disabling monitoring documentation [Disabling Policies](../Disabling-Policies)

## How much does it cost to run the ALZ Baseline solution?

> This depends on numerous factors including how many of the alert rules you choose to deploy into your environment, this combined with how many subscriptions inherit the baseline policies and resources deployed within each subscription that match the policy rules triggering an alert rule and action group deployment influence the cost.
> The solution is comprised of alert rules. Each alert rule costs ~0.1$/month<sup>1</sup>.
>
> - Alert rules are charged based on evaluations.
> - Assuming the alert rule had data to evaluate all throughout the month, it'll cost ~0.1$<sup>1</sup>.
> - If the rule was only evaluating during parts of the month (e.g. because the monitored resource was down and didn't send telemetry), the customer would pay for the prorated amount of time the rule was performing evaluations.
> - Dynamic Threshold doubles the cost of the alert rule (~0.2$/month in total<sup>1</sup>)
> - Our solution configures an email address as part of the Action groups deployment (one per subscription) and these are charged at ~2$/month per 1,000 emails<sup>1</sup>.
>
> {{< hint type=Note >}} Whilst it is not anticipated that the solution will incur significant costs, it is recommended that you assess costs as part of a deployment to a non-production environment to make sure you are clear on the costs incurred for your deployment.{{< /hint >}}
>
> For costings related to your deployment please visit [Pricing - Azure Monitor](https://azure.microsoft.com/en-us/pricing/details/monitor/) and work with your local Microsoft account team to define a rough order of magnitude (RoM) costings
>
> <sup>1</sup> Depending on the region you deploy to their may be a small difference in the associated cost, the costs provided here are based on prices captured as of April 2023

## Can I access the Visio diagrams displayed in the documentation?

> Yes, the Visio diagrams are available in the [media](https://github.com/Azure/azure-monitor-baseline-alerts/tree/main/docs/content/patterns/alz/media) folder

## Can I use AMBA without a GitHub repository

> <p>Yes, as long as the ARM templates are publicly accessible. There are several linked templates in this solution which require to be publicly accessible. This is because when the top level ARM template is submitted to Azure Resource Manager, the linked templates are not automatically uploaded and therefore need to pulled in at deploy time from Azure. This means they must be referenced using a URL which can be accessed from Azure (e.g. via a public GitHub repository)</p>
> <p>An alternative is to use Template specs. Instead of maintaining your linked templates at an accessible endpoint, you can create a template spec that packages the main template and its linked templates into a single entity you can deploy. The template spec is a resource in your Azure subscription. It makes it easy to securely share the template with users in your organization. You use Azure role-based access control (Azure RBAC) to grant access to the template spec. This feature is currently in preview.</p>
>
> References:
>
> - [Template specs](https://learn.microsoft.com/en-us/azure/azure-resource-manager/templates/linked-templates?>tabs=azure-powershell#template-specs)
> - [ARM Private deployment](https://github.com/Azure/ARM-private-deployment)

## Can I deploy a local template by using -TemplateFile

> No, it´s not possible to use the -TemplateFile parameter as the ARM template uses linked templates. When referencing a linked template, the value of URI can't be a local file or a file that is only available on your local network. Azure Resource Manager must be able to access the template. This means they must be referenced using a URL which can be accessed from Azure (e.g. via a public GitHub repository)

## What characters can I use when creating Azure resources or renaming Azure subscriptions?

> Not all the characters can be used when creating an Azure resource or renaming an Azure subscription. A list of supported characters for any resource can be found on the [Naming rules and restrictions for Azure resources](https://learn.microsoft.com/en-us/azure/azure-resource-manager/management/resource-name-rules) public documentation page. As an example that you can find in the referenced documentation, the alert suppression rules only allow alphanumerics, underscores, and hyphens as valid characters and at the beginning of the same page, alphanumeric is referring to:
>
> - **_a_** through **_z_** (lowercase letters)
> - **_A_** through **_Z_** (uppercase letters)
> - **_0_** through **_9_** (numbers)
>
> Creating an Azure resource or renaming a subscription using unsupported characters can hinder to one or more of the following problem:
>
> - Resource creation will fail
> - Action group and/or Alert Processing Rules deployment will fail. Specifically to AMBA we have this one documented in the specific [Failed to deploy action group(s) and/or alert processing rule(s)](../Known-Issues#failed-to-deploy-action-groups-andor-alert-processing-rules) article included in the [Known Issues](../Known-Issues)
> - Action group editing will result in Azure portal page error. Specifically to AMBA we have this one documented in the specific [Failed to edit action group(s)](../Known-Issues#failed-to-edit-action-groups) article included in the [Known Issues](../Known-Issues)
