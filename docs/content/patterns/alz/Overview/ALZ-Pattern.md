---
title: The Azure Landing Zones (ALZ) Pattern
geekdocCollapseSection: true
weight: 10
---

{{< hint type=Info >}}
Accessing Security Advisories in Azure Service Health now requires elevated access across the Summary, Impacted Resources, and Issue Updates tabs. Users who have subscription reader access, or tenant roles at tenant scope, aren't able anymore to view security advisory details until they get the required roles. Complete details can be found at [Elevated access for viewing Security Advisories](https://learn.microsoft.com/en-us/azure/service-health/security-advisories-elevated-access?branch=pr-en-us-255499).
</br>
</br>
***This is not impacting AMBA-ALZ configuration that will continue to work independently.***
{{< /hint >}}

### In this page

> [Overview](../ALZ-Pattern#overview) </br>
> [Feedback](../ALZ-Pattern#-feedback-) </br>
> [Deployment Guide](../ALZ-Pattern#deployment-guide) </br>
> [Known Issues](../ALZ-Pattern#known-issues) </br>
> [Frequently Asked Questions](../ALZ-Pattern#frequently-asked-questions) </br>
> [Contributing](../ALZ-Pattern#contributing) </br>
> [Telemetry](../ALZ-Pattern#telemetry) </br>
> [Trademarks](../ALZ-Pattern#trademarks) </br>

## Overview

The Azure Monitor Baseline Alerts (AMBA) for Azure Landing Zones (ALZ) is a best practice collection of alerts for resources commonly deployed in Azure landing zones. It demonstrates how to deploy alerts at scale using Azure Policy.

A frequent question from customers is, "What should we monitor in Azure?" and "What thresholds should we set for our alerts?"

There is not a definitive list of what to monitor when deploying to Azure because it depends on the services used and their usage patterns. This dictates what to monitor, the metrics to collect, and the errors to alert on.

Microsoft addresses this with various 'insights or solutions' for popular services, such as [Storage Insights](https://learn.microsoft.com/en-us/azure/storage/common/storage-insights-overview), [VM Insights](https://learn.microsoft.com/en-us/azure/azure-monitor/vm/vminsights-overview), and [Container Insights](https://learn.microsoft.com/en-us/azure/azure-monitor/containers/container-insights-overview). However, this does not cover everything.

This project focuses on monitoring for Azure Landing Zones, providing a common set of Azure resources/services configured similarly across organizations. It also includes guidance for custom brownfield scenarios that do not align with ALZ. This serves as a starting point for addressing "What should be monitored in Azure?" and demonstrates how to monitor at scale using Infrastructure-as-Code principles.

This project offers an opinionated view on monitoring key components of your Azure Landing Zone within the Platform and Landing Zone scope, including:

- Express Route Circuits
- Express Route Gateways
- Express Route Ports
- Azure Firewalls
- Application Gateways
- Load Balancers
- Virtual Networks
- Virtual Network Gateways
- Log Analytics Workspaces
- Private DNS Zones
- Azure Key Vaults
- Virtual Machines
- Service Health

Monitoring baselines for these components are deployed using Azure Policy and bundled into Azure Policy initiatives for ease of deployment and management. Additional component alerts included in the repository, but outside any initiatives or disabled by default, are:

- Storage Accounts
- Network Security Groups
- Azure Route Tables

The repository also contains policies for deploying service health alerts by subscription.

Alerts are based on Microsoft public guidance where available and practical application experience where not. For details on included alerts, refer to [Alert Details](../../Getting-started/Alerts-Details).

For information on how policies are grouped into initiatives, refer to [Azure Policy Initiatives](../../Getting-started/Policy-Initiatives).

Alerts need to be directed somewhere. A generic action group and alert processing rule is deployed to every subscription in scope via policy. For more details and the reasoning behind this approach, refer to [Monitoring and Alerting](../../Getting-started/Monitoring-and-Alerting).

## 📣 Feedback 📣

We welcome your feedback after deploying the solution. Click [here](https://aka.ms/alz/monitor/feedback) to leave your feedback.

If you encounter a problem, please file an issue in our GitHub repository [GitHub Issue](https://github.com/Azure/azure-monitor-baseline-alerts/issues).

## Deployment Guide

Refer to [Introduction to deploying the AMBA-ALZ Pattern](../../HowTo/deploy/Introduction-to-deploying-the-ALZ-Pattern) for guidance on consuming the contents of this repository.

## Known Issues

See the [Known Issues](../../Resources/Known-Issues) section.

## Frequently Asked Questions

Refer to the [Frequently Asked Questions](../../Resources/FAQ) section.

## Contributing

We welcome contributions and suggestions. Most contributions require a Contributor License Agreement (CLA) to grant us the rights to use your contribution. For details, visit [https://cla.opensource.microsoft.com](https://cla.opensource.microsoft.com).

When you submit a pull request, a CLA bot will determine if you need to provide a CLA and guide you through the process. You only need to do this once across all repositories using our CLA.

This project follows the [Microsoft Open Source Code of Conduct](https://opensource.microsoft.com/codeofconduct/). For more information, see the [Code of Conduct FAQ](https://opensource.microsoft.com/codeofconduct/faq/) or contact [opencode@microsoft.com](mailto:opencode@microsoft.com) with any questions or comments.

{{< hint type=note >}}
Details on contributing to this repository can be found in the [Contributor Guide](../../../../contributing).
{{< /hint >}}

## Telemetry

When you deploy the IP located in this repository, Microsoft can identify the installation with the deployed Azure resources. Microsoft collects this information to provide the best experiences with their products and to operate their business. The telemetry is collected through customer usage attribution and governed by [Microsoft's privacy policies](https://www.microsoft.com/trustcenter).

If you do not wish to send usage data to Microsoft or need more details, refer to the [Disable telemetry tracking](./../../../../Howto/Telemetry) guide.

## Trademarks

This project may contain trademarks or logos for projects, products, or services. Authorized use of Microsoft trademarks or logos must follow [Microsoft's Trademark & Brand Guidelines](https://www.microsoft.com/legal/intellectualproperty/trademarks/usage/general). Use of Microsoft trademarks or logos in modified versions of this project must not cause confusion or imply Microsoft sponsorship. Any use of third-party trademarks or logos is subject to those third-party's policies.
