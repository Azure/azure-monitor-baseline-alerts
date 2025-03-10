---
title: Oracle on Azure IaaS
geekdocCollapseSection: true
---

## Overview

Monitoring Oracle on Azure IaaS enables timely actions to enhance performance, reliability, and security. This solution helps set up appropriate Azure Monitor alerts for virtual machine and disk utilization. Action owners will receive email notifications if utilization metrics exceed the set thresholds.

> [!NOTE]
> Please adhere to the thresholds provided below when operating Oracle on Azure IaaS solutions. Ignoring alerts for these threshold values may lead to performance degradation and compromise the availability of the database

**Current Version:**
v0 (Dec 6, 2024)

## Alerts Table

Table below shows the Alerts configured after the deployment.

| Name                                           | Threshold(s) (Severity) | Signal Type   | Frequency | \# Alert Rules |
| ---------------------------------------------- | ----------------------- | ------------- | --------- | -------------- |
| Percentage CPU > 95                            | 95 (1)                  | Log Analytics | 5 min     | Default        |
| Percentage CPU >= 85                           | 85 (1)                  | Log Analytics | 5 min     | Default        |
| Percentage CPU >= 75                           | 75 (2)                  | Log Analytics | 5 min     | Default        |
| VmAvailabilityMetric < 1                       | < 1 (0)                 | Log Analytics | 5 min     | Default        |
| OS Disk Bandwidth Consumed Percentage > 95     | 95 (1)                  | Log Analytics | 5 min     | Default        |
| OS Disk Bandwidth Consumed Percentage > 90     | 90 (1)                  | Log Analytics | 5 min     | Default        |
| Available Memory Bytes < 500000000             | < 500000000 (1)         | Log Analytics | 5 min     | Default        |
| VM cached Bandwidth Consumed Percentage > 95   | 95 (1)                  | Log Analytics | 5 min     | Default        |
| VM cached Bandwidth Consumed Percentage > 85   | 85 (2)                  | Log Analytics | 5 min     | Default        |
| VM cached Bandwidth Consumed Percentage > 75   | 75 (2)                  | Log Analytics | 5 min     | Default        |
| VM uncached Bandwidth Consumed Percentage > 95 | 95 (1)                  | Log Analytics | 5 min     | Default        |
| VM uncached Bandwidth Consumed Percentage > 85 | 85 (2)                  | Log Analytics | 5 min     | Default        |
| VM uncached Bandwidth Consumed Percentage > 75 | 75 (2)                  | Log Analytics | 5 min     | Default        |
| Data Disk IOPS Consumed Percentage > 95        | 95 (1)                  | Log Analytics | 5 min     | Default        |
| Data Disk IOPS Consumed Percentage > 85        | 85 (2)                  | Log Analytics | 5 min     | Default        |
| Data Disk IOPS Consumed Percentage > 75        | 75 (2)                  | Log Analytics | 5 min     | Default        |
| OS Disk Bandwidth Consumed Percentage > 95     | 95 (1)                  | Log Analytics | 5 min     | Default        |
| OS Disk Bandwidth Consumed Percentage > 85     | 85 (2)                  | Log Analytics | 5 min     | Default        |
| OS Disk Bandwidth Consumed Percentage > 75     | 75 (2)                  | Log Analytics | 5 min     | Default        |
| VolumeConsumedSizePercentage per Lun >= 95     | \>=95 (0)               | Log Analytics | 5 min     | Default        |
| VolumeConsumedSizePercentage >= 90             | \>=90 (2)               | Log Analytics | 5 min     | Default        |
| UnhealthyHostCount >=1                         | \>=1 (0)                | Log Analytics | 5 min     | Default        |


## 📣Feedback 📣

Once you've had an opportunity to deploy the solution we'd love to hear from you! Click [here](https://aka.ms/alz/monitor/feedback) to leave your feedback.

If you have encountered a problem please file an issue in our GitHub repo [GitHub Issue](https://github.com/Azure/azure-monitor-baseline-alerts/issues).

## Monitor Oracle on Azure IaaS

Review [Manage and Monitor Oracle](/azure/cloud-adoption-framework/scenarios/oracle-iaas/oracle-manage-monitor-iaas) for further guidance.

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
