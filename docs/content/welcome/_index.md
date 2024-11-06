---
title: Welcome to AMBA!
weight: 0
---

---
Azure Monitor Baseline Alerts (AMBA) streamlines your Azure experience by providing a set of essential metrics and guidelines to ensure your Azure services are performing optimally. AMBA is your go-to for a proactive and informed Azure monitoring approach! Here's what you need to know:

- **Expert Recommendations**: Access a comprehensive list of alert recommendations and expert guidance for Azure resources.

- **Stay Alert**: Get near real-time notifications to quickly pinpoint issues and visualize alerts from Azure through dashboards.

- **Automation Policies**: Deploy alert policies easily and consistently with Azure Policy templates.

- **Guided Documentation**: Find detailed guidance to establish a solid alerting foundation.

- **Enhanced Resiliency**: Automate Service Health alerts deployment to tackle common resiliency challenges.

---
The site is organized into three main sections:

- **Azure Resources**: Find per resource level guidance on individual Azure services, including key alert metrics, recommended thresholds, deployment templates, and reference documentation.

- **Patterns / Scenarios**: Deploy monitoring at scale with specialized patterns such as Azure Landing Zones, along with policy definitions and initiatives for deploying alerts in your environment.

- **Visualizations**: Create data-driven monitoring solutions to visually understand your alerts and key metrics. Use Azure Managed Grafana and Azure Workbooks to deploy real-time, personalized dashboards.

Each main section of Azure Monitor Baseline Alerts can be considered as its own level, with associated monitoring subsections:

![Screenshot 2024-10-22 091245](https://github.com/user-attachments/assets/6d78b107-3592-430d-baeb-26990febf5cc)

---
AMBA supports three types of activity alerts to monitor your Azure resources. These alerts help you stay informed about the status and health of your Azure services:

- **Alerts for logs and metrics**: These keep track of your system's logs and performance metrics.

- **Alerts with static thresholds**: These trigger when certain predefined limits are reached.

- **Alerts with dynamic thresholds**: These adapt based on patterns and trends in your data.

---
**Learn more about monitoring and improve your observability story with these quick links:**

- Stay Updated on Service Health:

  - Set up [Azure Monitor Baseline Alerts](https://azure.github.io/azure-monitor-baseline-alerts/welcome/) for Azure Services.

  - Get insights on Microsoft 365 with [Microsoft 365 monitoring](https://learn.microsoft.com/en-us/microsoft-365/enterprise/microsoft-365-monitoring?view=o365-worldwide).

- Visualize your Service Health:

  - Explore the [Observability at Scale repository](https://github.com/microsoft/mcsa-observability) for monitoring at scale.

  - Follow best practices and [recommendations for designing and creating a monitoring system](https://learn.microsoft.com/en-us/azure/well-architected/operational-excellence/observability).

- Deep Insights into Critical Workloads:

  - Gain in-depth views with [Azure Mission Critical monitoring](https://learn.microsoft.com/en-us/azure/well-architected/mission-critical/).

- Specialized Workload Monitoring:

  - Keep an eye on your Azure specialized workloads with [Monitor Azure platform landing zone components](https://learn.microsoft.com/en-gb/azure/cloud-adoption-framework/ready/landing-zone/design-area/management-monitor#azure-landing-zone-monitoring-guidance).

---

**Explore your end-to-end monitoring journey:**

![Screenshot 2024-10-18 011630](https://github.com/user-attachments/assets/a9062189-77f1-46a5-94a4-7fd0a81560c6)


| **Customer and Partner outcomes​:**             | *I want to…* learn about Monitoring                                          | *I want to…* be notified on the health for every Microsoft Service consumed​             | *I want to…* visualize the health of every Microsoft Service consumed​              | *I want to…* monitor the health of my mission critical workloads for deep insights​    | *I want to…* monitor my specialized workloads (Teams + Azure, Power Platform + Azure)​ |
| --------------------------- | --------------------------------------- | ------------------------------------------------------------------------- | ------------------------------------------------------------------------------------- | -------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------- |
| ***Content:***                                               | Web, blogs, videos, e-books, evidence`​                                        | [Cloud Adoption Framework - ALZ Monitoring Guidance](https://learn.microsoft.com/en-gb/azure/cloud-adoption-framework/ready/landing-zone/design-area/management-monitor#azure-landing-zone-monitoring-guidance)                                                                                                 | [Cloud Adoption Framework - ALZ Monitoring Guidance](https://learn.microsoft.com/en-gb/azure/cloud-adoption-framework/ready/landing-zone/design-area/management-monitor#azure-landing-zone-monitoring-guidance) / [Azure Monitor Team Grafana Library](https://grafana.com/orgs/azure/dashboards)                                                                                      | [Well-Architected Framework](https://learn.microsoft.com/en-us/azure/well-architected/operational-excellence/observability) / [Microsoft Learn - Design a health model for your mission critical workload](https://learn.microsoft.com/en-us/training/modules/design-health-model-mission-critical-workload/)                                                                                                                                                            | [Well-Architected Framework](https://learn.microsoft.com/en-us/azure/well-architected/operational-excellence/observability) / Azure Architecture Center ([Application Landing Zone](https://learn.microsoft.com/en-us/azure/architecture/landing-zones/landing-zone-deploy#application))                                                                                                                                                                  |
| ***Azure Solution:***                                        |                                                                          | [Azure Monitor Baseline Alerts (AMBA)](https://azure.github.io/azure-monitor-baseline-alerts/welcome/)                                                                                                                                              | [Azure Infrastructure Monitoring Dashboard on Grafana (Azure Performance)](https://grafana.com/grafana/dashboards/19943-azure-infrastructure-compute-monitoring/) / [Microsoft Cloud Solution Advisor - Observability for ISVs (multi cloud service availability)​](https://github.com/microsoft/mcsa-observability)                                                                                                                                                                     | [Mission-critical reference architectures](https://learn.microsoft.com/en-us/azure/well-architected/mission-critical/) (Azure Workload [Health Model](https://learn.microsoft.com/en-us/azure/well-architected/mission-critical/mission-critical-health-modeling)) Private Preview                                                                                                                                                            | [Microsoft Cloud Solution Advisor - Observability for ISVs](https://github.com/microsoft/mcsa-observability)​ / Azure Landing zone accelerators (AVD, [SAP](https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/scenarios/sap/enterprise-scale-landing-zone), AVS, Oracle etc.)                                                                                                                                                                 |
| ***M365 / D365 Solution***                                     |                                                                          | [Microsoft 365 monitoring - Microsoft 365 Enterprise  Microsoft Learn](https://learn.microsoft.com/en-us/microsoft-365/enterprise/microsoft-365-monitoring?view=o365-worldwide)                                                                                                                                              | [Microsoft Cloud Solution Advisor - Observability for ISVs (M365 on roadmap)​](https://github.com/microsoft/mcsa-observability)                                                                                                                                                                     | [Microsoft Cloud Solution Advisor - Observability for ISVs (M365 on roadmap)](https://github.com/microsoft/mcsa-observability)​                                                                                                                                                           | [Microsoft Cloud Solution Advisor - Observability for ISVs (M365 on roadmap)](https://github.com/microsoft/mcsa-observability)​                                                                                                                                                                 |
| ***Product***                                                |                                                                        | Azure Monitor                                                                                                                                            | Azure Monitor, M365, D365                                                                                                                                                                       | Azure Monitor, M365, D365                                                                                                                                                          | Azure Monitor, M365, D365                                                                                                                                                                 |

---

{{< hint type=tip >}}
Please review and leave issues on things you find, via [GitHub Issues](https://github.com/Azure/azure-monitor-baseline-alerts/issues)
{{< /hint >}}
