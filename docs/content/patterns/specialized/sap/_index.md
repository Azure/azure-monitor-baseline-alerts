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
| Percentage CPU > 95                                        | 95 (2)                                     | Log Analytics           | 5 min     | Default        |
| Percentage CPU >= 85                                       | 85 (1)                                     | Log Analytics           | 5 min     | Default        |
| Percentage CPU >= 75                                       | 75 (2)                                     | Log Analytics           | 5 min     | Default        |
| VmAvailabilityMetric < 1                                   | < 1 (0)                                    | Log Analytics           | 5 min     | Default        |
| OS Disk Bandwidth Consumed Percentage >= 95                | 95 (0)                                     | Log Analytics           | 5 min     | Default        |
| OS Disk Bandwidth Consumed Percentage >= 90                | 90 (1)                                     | Log Analytics           | 5 min     | Default        |
| Available Memory Bytes < 500000000                         | < 500000000 (1)                            | Log Analytics           | 5 min     | Default        |
| Data Disk IOPS Consumed Percentage > 95                    | \>95 (3)                                   | Log Analytics           | 5 min     | Default        |
| OS Disk Bandwidth Consumed Percentage >= 90                | \>=90 (0)                                  | Log Analytics           | 5 min     | Default        |
| OS Disk Bandwidth Consumed Percentage >= 80                | \>= 80 (2)                                 | Log Analytics           | 5 min     | Default        |
| VolumeConsumedSizePercentage >= 95                         | \>=95 (0)                                  | Log Analytics           | 5 min     | Default        |
| VolumeConsumedSizePercentage >= 90                         | \>=90 (2)                                  | Log Analytics           | 5 min     | Default        |
| UnhealthyHostCount >=1                                     | \>=1 (0)                                   | Log Analytics           | 5 min     | Default        |
| Netweaver [SOAP] SAP Netweaver System Availability         | boolean                                    | Log Analytics           | 5 min     | Default        |
| Netweaver [SOAP] SAP Netweaver Instance Availability       | boolean                                    | Log Analytics           | 5 min     | Default        |
| Netweaver [SOAP] SAP Netweaver EnqueueServer Availability  | boolean                                    | Log Analytics           | 5 min     | Default        |
| Netweaver [SOAP] SAP Netweaver Instance Work Process Utilization | > 70                                 | Log Analytics           | 5 min     | Default        |
| Netweaver [SOAP] SAP Netweaver Instance Queue Wait         | > 5                                        | Log Analytics           | 5 min     | Default        |
| SAP HANA High CPU Usage Percent                            | > 90                                       | Log Analytics           | 5 min     | Default        |
| SAP HANA High Memory Usage Percent                         | > 90                                       | Log Analytics           | 5 min     | Default        |
| MS SQL Server high CPU usage percent                       | > 90                                       | Log Analytics           | 5 min     | Default        |
| MS SQL Server high IO write time ms                        | > 50                                       | Log Analytics           | 5 min     | Default        |
| MS SQL Server high blocking time ms                        | > 50                                       | Log Analytics           | 5 min     | Default        |
| MS SQL Server high IO read time ms                         | > 50                                       | Log Analytics           | 5 min     | Default        |
| DB2 Log Usage Percent                                      | > 20                                       | Log Analytics           | 5 min     | Default        |
| DB2 CPU Usage Percent                                      | > 20                                       | Log Analytics           | 5 min     | Default        |
| DB2 Availability                                           | boolean                                    | Log Analytics           | 5 min     | Default        |
| DB2 Data Disk filesystem utilization percent               | > 80                                       | Log Analytics           | 5 min     | Default        |
| DB2 memory utilization percent                             | > 90                                       | Log Analytics           | 5 min     | Default        |





## 📣Feedback 📣

Once you've had an opportunity to deploy the solution we'd love to hear from you! Click [here](https://aka.ms/alz/monitor/feedback) to leave your feedback.

If you have encountered a problem please file an issue in our GitHub repo [GitHub Issue](https://github.com/Azure/azure-monitor-baseline-alerts/issues).

## Deployment Guide

We have a [Deployment Guide](https://learn.microsoft.com/en-us/azure/sap/monitor/quickstart-portal) for guidance on how to deploy Azure Monitor for SAP.

[Managed Alerts](https://github.com/Azure/Azure-Monitor-for-SAP-solutions-preview/wiki/9-.b.-Managed-alerts-enabling-bulk-alerts) simplifies alert configuration by allowing bulk view and edits across providers.

## Known Issues

Please see the [Known Issues](Known-Issues.md)

## Frequently Asked Questions

Please see the [Frequently Asked Questions](FAQ.md).

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

## Trademarks

This project may contain trademarks or logos for projects, products, or services.
Authorized use of Microsoft trademarks or logos is subject to and must follow
[Microsoft's Trademark & Brand Guidelines](https://www.microsoft.com/legal/intellectualproperty/trademarks/usage/general).
Use of Microsoft trademarks or logos in modified versions of this project must not cause confusion or imply Microsoft sponsorship.
Any use of third-party trademarks or logos are subject to those third-party's policies.
