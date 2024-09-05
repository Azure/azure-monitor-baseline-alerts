---
title: Azure Managed Grafana
geekdocCollapseSection: true
---

## Overview
Grafana, built by [Grafana Labs](https://grafana.com/), is an open-source platform for data visualization, monitoring, and analysis. It allows you to query, visualize, alert on, and understand your metrics no matter where they are stored.  [Azure Managed Grafana](https://learn.microsoft.com/azure/managed-grafana/overview) is a fully managed service built on top of the Grafana software that provides built-in support for Azure Monitor and Azure Data Explorer data sources.  Azure Managed Grafana further provides user authentication and access control using Microsoft Entra identities and provides high availability, SLA guarantees and automatic software updates.

Listed below are some examples of Grafana dashboards that visualize alerts from Azure.  These dashboards can be [imported](https://learn.microsoft.com/azure/managed-grafana/how-to-create-dashboard?tabs=azure-portal#import-a-grafana-dashboard) into your own Grafana instance.

You can also find information [below](#using-the-grafana-tab-in-the-services-section) on utilizing the Grafana tab found in the Services section of this site.

## Azure Monitor Team Dashboards
The Azure Monitor Team has built a [library](https://grafana.com/orgs/azure/dashboards) of dashboards that can be imported into your own instance of Grafana.  Below are some examples from that library that help visualize alerting from Azure Monitor.

- Azure Infrastructure Monitoring Dashboards
  - [Compute Monitoring](https://grafana.com/grafana/dashboards/19943-azure-infrastructure-compute-monitoring/)
  - [Network Monitoring](https://grafana.com/grafana/dashboards/21255-azure-infrastructure-network-monitoring/)
  - [Apps Monitoring](https://grafana.com/grafana/dashboards/21257-azure-infrastructure-apps-monitoring/)
  - [Data Monitoring](https://grafana.com/grafana/dashboards/21256-azure-infrastructure-data-monitoring/)
  - [Storage and Key Vaults Monitoring](https://grafana.com/grafana/dashboards/21253-azure-infrastructure-storage-and-key-vaults-monitoring/)

  Displays traffic-light indicators showing the health of your Azure infrastructure resources based on key performance indicators and thresholds defined for each infrastructure resource type.  This is a collection of dashboards linked together via dashboard links for easy navigation between views.

![Infrastructure Monitoring Gif](../../img/azure_infra_monitor.gif)

- [Alert Consumption](https://grafana.com/grafana/dashboards/15128-azure-alert-consumption/)

  A summary of all alerts for the subscription and other filters selected.

  ![Alert Consumption Image](https://grafana.com/api/dashboards/15128/images/11874/image)

- [SCOM Managed Instance Operational Dashboard](https://grafana.com/grafana/dashboards/19919-azure-scom-managed-instance-operational-dashboard/)

  Operational dashboard for summary of alerts, heath, and performance of monitored resources connected to SCOM managed instance.

  ![SCOM Managed Instance Operational Dashboard Image](https://grafana.com/api/dashboards/19919/images/15100/image)
<br/>

## Using the Grafana Tab in the Services Section
In the [Services](https://azure.github.io/azure-monitor-baseline-alerts/services/) section of this site where guidance is provided for each individual Azure service, you can find a "Grafana" tab which can be used to import a dashboard that contains a visualization for each alert threshold.  As an example, if you go to the [services/Compute/virtualMachines](https://azure.github.io/azure-monitor-baseline-alerts/services/Compute/virtualMachines/) page, you will find a "Dashboard" section with a "Grafana" tab.  Copy the JSON and use it to import a new dashboard in Grafana.  See yellow highlight in screenshot below:

![Screenshot of Grafana Tab](../../img/grafana-tab.png)
