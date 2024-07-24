---
title: Welcome
weight: 0
---

---

## Our Mission

Welcome to the **Azure Monitor Baseline Alerts (AMBA)** site!  The purpose of this site is to provide best practice guidance around key alerts and thresholds for your azure resources.

This sites is broken down into three main sections:

1. **Azure Resources:** this section provides guidance for individual Azure resources.  For each service, there is a list of key alert and the recommended thresholds.
2. **Patterns / Scenarios:** This section provides guidance for common patterns / scenarios (like Azure Landing Zones), as well as policy definition and initiatives for deploying the alerts in your environment.
3. **Visualizations**: This section provides different options to visualize the data from your connected sources.

To learn more as to why alerts are important and how to get started with your Azure Monitor journey, keep reading the sections below!

## Why is configuring alerts important?

---
When deploying Azure resources, it is crucial to configure alerts to ensure the health, performance, and security of your resources. By setting up alerts, you can proactively monitor your resources and take timely actions to address any issues that may arise.

Here are the key reasons why configuring alerts is important:

1. **Early detection of issues**: Alerts enable you to identify potential problems or anomalies in your Azure resources at an early stage. By monitoring key metrics and logs, you can detect issues such as high CPU usage, low memory, network connectivity problems, or security breaches. This allows you to take immediate action and prevent any negative impact on your applications or services.

2. **Reduced downtime**: By configuring alerts, you can minimize downtime by being notified of critical events or failures in real-time. This allows you to quickly investigate and resolve issues before they escalate, ensuring the availability and reliability of your applications.

3. **Optimized resource utilization**: Alerts help you optimize resource utilization by providing insights into resource usage patterns and trends. By monitoring metrics such as CPU utilization, memory consumption, or storage capacity, you can identify opportunities for optimization and cost savings.

4. **Compliance and security**: Configuring alerts is essential for maintaining compliance with regulatory requirements and ensuring the security of your Azure resources. By monitoring security logs and detecting suspicious activities or unauthorized access attempts, you can take immediate action to mitigate potential risks and protect your data.

5. **Proactive capacity planning**: Alerts provide valuable information for capacity planning and scaling your resources. By monitoring resource utilization trends over time, you can identify patterns and forecast future resource requirements. This helps you avoid performance bottlenecks and ensure a smooth user experience.

## Monitor your environment

---
I want to:

* [Learn about Monitoring](#learn-about-monitoring)
* Be notified on the health for every [Microsoft Service consumed](https://learn.microsoft.com/en-us/azure/service-health/overview)
* [Visualize](https://grafana.com/orgs/azuremonitorteam/dashboards) the health of every Microsoft Service consumed
* Monitor the health of my [mission critical](https://learn.microsoft.com/azure/well-architected/operational-excellence/observability) workloads for deep insights. [Module.](https://learn.microsoft.com/training/modules/design-health-model-mission-critical-workload/)
* Monitor my [specialized workloads](https://learn.microsoft.com/azure/architecture/landing-zones/landing-zone-deploy#application) (Teams + Azure, Power Platform + Azure)

## Learn about Monitoring
---
{{< figure src="../img/datasources-azmon.png" >}}

Begin your journey monitoring by reviewing the following reference documentation:

* [Getting started with Azure Monitor](https://learn.microsoft.com/azure/azure-monitor/getting-started#getting-started-workflow)
* [Collect the right monitoring data](https://learn.microsoft.com/azure/cloud-adoption-framework/manage/monitor/data-collection)
* [Azure Monitor data sources and data collection methods](https://learn.microsoft.com/azure/azure-monitor/data-sources)
* [Data collection rules (DCRs) in Azure Monitor](https://learn.microsoft.com/azure/azure-monitor/essentials/data-collection-rule-overviewn)
* [Diagnostic Setting in Azure Monitor](https://learn.microsoft.com/azure/azure-monitor/essentials/diagnostic-settings)

{{< figure src="../img/amba_logo.png" width="20%" >}}

{{< hint type=tip >}}
Please review and leave issues on things you find, via [GitHub Issues](https://github.com/Azure/azure-monitor-baseline-alerts/issues)
{{< /hint >}}
