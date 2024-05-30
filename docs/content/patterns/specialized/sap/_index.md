---
title: SAP on Azure
geekdocCollapseSection: true
---

## Overview

Monitoring SAP environment allows timely action and improves reliability and security of the environment. This solution helps in setting up Azure Monitor alerts for SAP on  Azure Solution. Action owners will receive email notifications if utilization metrics exceeds set threshold.

{{< hint type=note >}}
Please do not operate SAP on Azure Solution outside the thresholds provided below. If you ignore alerts for the threshold values below then in case of outage, Azure credits are not provided.
{{< /hint >}}

**Current Version:**
v0.0.2 (May 25, 2024)

## Alerts Table

Table below shows the Alerts configured after the deployment.

| Name                                                       | Threshold(s) (Severity)                    | Signal Type             | Frequency | \# Alert Rules |
| ---------------------------------------------------------- | ------------------------------------------ | ----------------------- | --------- | -------------- |
| Percentage CPU > 95                                        | 95 (2)                                     | Metric Alerts           | 5 min     | Default        |
| Percentage CPU >= 85                                       | 85 (1)                                     | Metric Alerts           | 5 min     | Default        |
| Percentage CPU >= 75                                       | 75 (2)                                     | Metric Alerts           | 5 min     | Default        |
| VmAvailabilityMetric < 1                                   | < 1 (0)                                    | Metric Alerts           | 5 min     | Default        |
| OS Disk Bandwidth Consumed Percentage >= 95                | 95 (0)                                     | Metric Alerts           | 5 min     | Default        |
| OS Disk Bandwidth Consumed Percentage >= 90                | 90 (1)                                     | Metric Alerts           | 5 min     | Default        |
| Available Memory Bytes < 500000000                         | < 500000000 (1)                            | Metric Alerts           | 5 min     | Default        |
| Data Disk IOPS Consumed Percentage > 95                    | \>95 (3)                                   | Metric Alerts           | 5 min     | Default        |
| OS Disk Bandwidth Consumed Percentage >= 90                | \>=90 (0)                                  | Metric Alerts           | 5 min     | Default        |
| OS Disk Bandwidth Consumed Percentage >= 80                | \>= 80 (2)                                 | Metric Alerts           | 5 min     | Default        |
| VolumeConsumedSizePercentage >= 95                         | \>=95 (0)                                  | Metric Alerts           | 5 min     | Default        |
| VolumeConsumedSizePercentage >= 90                         | \>=90 (2)                                  | Metric Alerts           | 5 min     | Default        |
| UnhealthyHostCount >=1                                     | \>=1 (0)                                   | Metric Alerts           | 5 min     | Default        |
| Netweaver [SOAP] SAP Netweaver System Availability         |                                            | Metric Alerts           | 5 min     | Default        |
| Netweaver [SOAP] SAP Netweaver Instance Availability       |                                            | Metric Alerts           | 5 min     | Default        |
| Netweaver [SOAP] SAP Netweaver EnqueueServer Availability  |                                            | Metric Alerts           | 5 min     | Default        |
| Netweaver [SOAP] SAP Netweaver Instance Work Process Utilization | > 70                                 | Metric Alerts           | 5 min     | Default        |
| Netweaver [SOAP] SAP Netweaver Instance Queue Wait         | > 5                                        | Metric Alerts           | 5 min     | Default        |
| SAP HANA High CPU Usage Percent                            | > 90                                       | Metric Alerts           | 5 min     | Default        |
| SAP HANA High Memory Usage Percent                         | > 90                                       | Metric Alerts           | 5 min     | Default        |
| Linux OS High CPU usage percent                            | > 90                                       | Metric Alerts           | 5 min     | Default        |
| Linux OS High memory usage MB                              | > 5000                                     | Metric Alerts           | 5 min     | Default        |
| Linux OS High Disk Read MB per Sec                         | > 10                                       | Metric Alerts           | 5 min     | Default        |
| MS SQL Server high CPU usage percent                       | > 90                                       | Metric Alerts           | 5 min     | Default        |
| MS SQL Server high IO write time ms                        | > 50                                       | Metric Alerts           | 5 min     | Default        |
| MS SQL Server high blocking time ms                        | > 50                                       | Metric Alerts           | 5 min     | Default        |
| MS SQL Server high IO read time ms                         | > 50                                       | Metric Alerts           | 5 min     | Default        |
| DB2 Log Usage Percent                                      | > 20                                       | Metric Alerts           | 5 min     | Default        |
| DB2 CPU Usage Percent                                      | > 20                                       | Metric Alerts           | 5 min     | Default        |
| DB2 Availability                                           |                                            | Metric Alerts           | 5 min     | Default        |
| DB2 Data Disk filesystem utilization percent               | > 80                                       | Metric Alerts           | 5 min     | Default        |
| DB2 memory utilization percent                             | > 90                                       | Metric Alerts           | 5 min     | Default        |





## 📣Feedback 📣

Once you've had an opportunity to deploy the solution we'd love to hear from you! Click [here](https://aka.ms/alz/monitor/feedback) to leave your feedback.

If you have encountered a problem please file an issue in our GitHub repo [GitHub Issue](https://github.com/Azure/azure-monitor-baseline-alerts/issues).

## Deployment Guide

We have a [Deployment Guide](./deploy/deploy.md#deployment-guide) available for guidance on how to consume the contents of this repo.

## Known Issues

Please see the [Known Issues](Known-Issues).

## Frequently Asked Questions

Please see the [Frequently Asked Questions](../avs/FAQ.md).

## Contributing

This project welcomes contributions and suggestions.
Most contributions require you to agree to a Contributor License Agreement (CLA)
declaring that you have the right to, and actually do, grant us the rights to use your contribution.
For details, visit [https://cla.opensource.microsoft.com](https://cla.opensource.microsoft.com).

When you submit a pull request, a CLA bot will automatically determine whether you need to provide
a CLA and decorate the PR appropriately (e.g., status check, comment).
Simply follow the instructions provided by the bot.
You will only need to do this once across all repos using our CLA.

This project has adopted the [Microsoft Open Source Code of Conduct](https://opensource.microsoft.com/codeofconduct/).
For more information see the [Code of Conduct FAQ](https://opensource.microsoft.com/codeofconduct/faq/) or
contact [opencode@microsoft.com](mailto:opencode@microsoft.com) with any additional questions or comments.

{{< hint type=note >}}
Details on contributing to this repo can be found [here](../../../contributing)
{{< /hint >}}

## Telemetry

When you deploy the IP located in this repo, Microsoft can identify the installation of said IP with the deployed Azure resources. Microsoft can correlate these resources used to support the software. Microsoft collects this information to provide the best experiences with their products and to operate their business. The telemetry is collected through customer usage attribution. The data is collected and governed by [Microsoft's privacy policies](https://www.microsoft.com/trustcenter).

If you don't wish to send usage data to Microsoft, or need to understand more about its' use details can be found [here](./Telemetry).

## Trademarks

This project may contain trademarks or logos for projects, products, or services.
Authorized use of Microsoft trademarks or logos is subject to and must follow
[Microsoft's Trademark & Brand Guidelines](https://www.microsoft.com/legal/intellectualproperty/trademarks/usage/general).
Use of Microsoft trademarks or logos in modified versions of this project must not cause confusion or imply Microsoft sponsorship.
Any use of third-party trademarks or logos are subject to those third-party's policies.
