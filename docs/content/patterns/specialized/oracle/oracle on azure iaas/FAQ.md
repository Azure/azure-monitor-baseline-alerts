---
title: Frequently Asked Questions
geekdocCollapseSection: true
weight: 80
---

> ## Do I need to use the thresholds defined as default values in the metric rule alerts?
>
The initial thresholds are based on our observations and Microsoft's documentation recommendations. These thresholds are intended as a starting point and should be adjusted over time.

Monitor the alerts closely to fine-tune the thresholds. If the alerts are too frequent, increase the threshold. Conversely, if the alerts do not trigger when issues arise, decrease the threshold accordingly. The adjustments will depend on the metrics or log errors used as monitoring sources.

Once you have determined an appropriate threshold value, we encourage you to share it with us if you think it could benefit broader use.

>
> ## Do I need to use these metrics or can they be replaced with ones more suited to my environment?
>
> The metric rules provided are based on Microsoft's documentation recommendations and real-world field experience. These rules are intended as a starting point, and you may need to adjust the thresholds over time.

You can tailor the alerts to suit your specific environment and how you use Azure resources. The main goal of this project is to help you implement Azure Monitor alerts at scale. You can create new rules specific to your thresholds.

We would love to hear about any new rules you develop, so please share them with us if you believe they could benefit others.
>
> ## How much does it cost to run the ALZ Baseline solution?
>
> The cost of running the ALZ Baseline solution depends on several factors, including the number of alert rules you deploy, the number of subscriptions inheriting the baseline policies, and the resources within each subscription that match the policy rules.

Each alert rule costs approximately $0.10 monthly based on continuous data evaluation. If the rule only evaluates data intermittently, the cost is prorated. Dynamic Thresholds double the price to around $0.20 per month. Additionally, Action groups configured with an email address are charged about $2 monthly for every 1,000 emails.

**While significant costs are not anticipated, it is recommended that you assess costs in a non-production environment to understand the expenses for your deployment.**

For detailed cost information, visit the Azure Monitor [Pricing - Azure Monitor](https://azure.microsoft.com/en-us/pricing/details/monitor/) pricing and consult with your local Microsoft account team to estimate the costs for your deployment.
>
Depending on the region you deploy to their may be a small difference in the associated cost, the costs provided here are based on prices captured as of April 2023
>
> ## Can I use AMBA without a GitHub repository
>
You can use AMBA without a GitHub repository if the ARM templates are publicly accessible. The linked templates in this solution must be accessible via a URL when the top-level ARM template is submitted to Azure Resource Manager. This ensures they can be pulled in at deployment time.

Alternatively, you can use Template specs. This allows you to package the main template and its linked templates into a single entity within your Azure subscription. Template specs make it easy to securely share the template with users in your organization using Azure role-based access control (Azure RBAC). This feature is currently in preview.
>
> References:
> - [Template specs](https://learn.microsoft.com/en-us/azure/azure-resource-manager/templates/linked-templates?tabs=azure-powershell#template-specs)
> - [ARM Private deployment](https://github.com/Azure/ARM-private-deployment)
