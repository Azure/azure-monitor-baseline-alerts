---
title: Frequently Asked Questions
geekdocCollapseSection: true
weight: 80
---

> ## Do I need to use the thresholds defined as default values in the metric rule alerts?
>
> It's provided as a starting point, we've based the initial thresholds on what we've seen and what Microsoft's documentation recommends. You will need to adjust the thresholds at some point.
> You will need to observe and if the alert is too chatty, adjust the threshold up; if it's not alerting when there's a problem, adjust the threshold down a bit, (or vice-versa depending on what metric or log error is being used as a monitoring source). Once you have decided upon an appropriate value, if you feel it's fit for more general consumption we would love to hear about it.
>
> ## Do I need to use these metrics or can they be replaced with ones more suited to my environment?
>
> The metric rules we've created are based on recommendations from Microsoft documentation and field experience. How you're using Azure resources may also be different so tailor the alerts to suit your needs. The main goal of this project is to help you have a way to do Azure Monitor alerts at scale, create new rules with your own thresholds. We'd love to hear about your new rules too so feel free to share back.
>
> ## How much does it cost to run the ALZ Baseline solution?
>
> This depends on numerous factors including how many of the alert rules you choose to deploy into your environment, this combined with how many subscriptions inherit the baseline policies and resources deployed within each subscription that match the policy rules triggering an alert rule and action group deployment influence the cost.
>
> The solution is comprised of alert rules. Each alert rule costs ~0.1$/month<sup>1</sup>.
>
> - Alert rules are charged based on evaluations.
> - Assuming the alert rule had data to evaluate all throughout the month, it'll cost ~0.1$<sup>1</sup>.
> - If the rule was only evaluating during parts of the month (e.g. because the monitored resource was down and didn't send telemetry), the customer would pay for the prorated amount of time the rule was performing evaluations.
> - Dynamic Threshold doubles the cost of the alert rule (~0.2$/month in total<sup>1</sup>)
> - Our solution configures an email address as part of the Action groups deployment (one per subscription) and these are charged at ~2$/month per 1,000 emails<sup>1</sup>.
>
> **Whilst it is not anticipated that the solution will incur significant costs, it is recommended that you assess costs as part of a deployment to a non-production environment to make sure you are clear on the costs incurred for your deployment**
>
> For costings related to your deployment please visit [Pricing - Azure Monitor](https://azure.microsoft.com/en-us/pricing/details/monitor/) and work with your local Microsoft account team to define a rough order of magnitude (RoM) costings
>
> <sup>1</sup> Depending on the region you deploy to their may be a small difference in the associated cost, the costs provided here are based on prices captured as of April 2023
>
> ## Can I use AMBA without a GitHub repository
>
> <p>Yes, as long as the ARM templates are publicly accessible. There are several linked templates in this solution which require to be publicly accessible. This is because when the top level ARM template is submitted to Azure Resource Manager, the linked templates are not automatically uploaded and therefore need to pulled in at deploy time from Azure. This means they must be referenced using a URL which can be accessed from Azure (e.g. via a public GitHub repository)</p>
> <p>An alternative is to use Template specs. Instead of maintaining your linked templates at an accessible endpoint, you can create a template spec that packages the main template and its linked templates into a single entity you can deploy. The template spec is a resource in your Azure subscription. It makes it easy to securely share the template with users in your organization. You use Azure role-based access control (Azure RBAC) to grant access to the template spec. This feature is currently in preview.</p>
>
> References:
> - [Template specs](https://learn.microsoft.com/en-us/azure/azure-resource-manager/templates/linked-templates?tabs=azure-powershell#template-specs)
> - [ARM Private deployment](https://github.com/Azure/ARM-private-deployment)
