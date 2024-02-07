---
title: Azure Virtual Desktop
geekdocCollapseSection: true
---

## Overview

This solution provides a baseline of alerts for AVD that are disabled by default and for ensuring administrators and staff get meaningful and timely alerts when there are problems related to an AVD deployment. The deployment has been tested in Azure Global and Azure US Government and will incorporate storage alerts for either or both Azure Files and/or Azure Netapp Files.  This solution initially was part of the Azure Virtual Desktop Solution Accelerator as a brownfield and moved to this location.

**Current Version:**  
v2.1.5 (Dec 5, 2023)

## Alerts Table

Table below shows the Alert Names however the number of alert rules created may be multiple based on different severity and/or additional volume or storage name designators. For example, a deployment with a single Azure Files Storage Account and an Azure NetApp Files Volume would yield 20 alert rules created. [(Excel Table)](https://github.com/Azure/azure-monitor-baseline-alerts/raw/main/docs/static/img/Avd/alerts.xlsx)

| Name                                                                      | Threshold(s) (Severity)    |  Signal Type   |  Frequency    |  # Alert Rules |
|---                                                                        |---                         |---             |---            |---  
| AVD-HostPool-Capacity (1.)                                                | 95% (1) / 85% (2) / 50% (3)| Log Analytics  |  5 min        |  3/hostpool |
| AVD-HostPool-Disconnected User over n Hours (hostpoolname)                | 24 (1) / 72 (2)            | Log Analytics  |  1 hour       |  2/hostpool |
| AVD-HostPool-No Resources Available (hostpoolname)                        | Any are Sev1               | Log Analytics  |  15 min       |  1/hostpool |
| AVD-HostPool-VM-Available Memory Less Than nGB (hostpoolname)             | 1gb (Sev1) / 2gb (Sev2)    | Metric Alerts  |  5 min        |  2/hostpool |
| AVD-HostPool-VM-FSLogix Profile DiskCompactFailed (hostpoolname)          | (2)                        | Log Analytics  |  5 min        |  1/hostpool |
| AVD-HostPool-VM-FSLogix Profile FailedAttachVHD (hostpoolname)            | (1)                        | Log Analytics  |  5 min        |  1/hostpool |
| AVD-HostPool-VM-FSLogix Profile Less Than n% Free Space (hostpoolname)    | 2% (1) / 5% (2)            | Log Analytics  |  5 min        |  2/hostpool |
| AVD-HostPool-VM-FSLogix Profile Failed due to Network Issue (hostpoolname)| (1)                        | Log Analytics  |  5 min        |  1/hostpool |
| AVD-HostPool-VM-FSLogix Profile Service Disabled (hostpoolname)           | (1)                        | Log Analytics  |  5 min        |  1/hostpool |
| AVD-HostPool-VM-Health Check Failure (hostpoolname)                       | (1)                        | Log Analytics  |  5 min        |  1/hostpool |
| AVD-HostPool-VM-High CPU nn Percent (hostpoolname)                        | 95 (1) / 85 (2)            | Metric Alerts  |  5 min        |  2/hostpool |
| AVD-HostPool-VM-Local Disk Free Space n% (hostpoolname)                   | 5 (1) / 10 (2)             | Log Analytics  |  15 min       |  2/hostpool |
| AVD-HostPool-VM-Personal Assigned Not Healthy (hostpoolname)              | Any are Sev 1              | Log Analytics  |  5 min        |  1/hostpool |
| AVD-HostPool-VM-OS Disk Bandwidth Avg n% (hostpoolname)                   | 95 (1) / 85 (2)            | Metric Alerts  |  5 min        |  2/hostpool |
| AVD-HostPool-VM-User Connection Failed (hostpoolname)                     | Any are Sev 3              | Log Analytics  |  15 min       |  1/hostpool |
| AVD-HostPool-VM-Missing Critical Updates (hostpoolname)                   | Any are Sev 1              | Log Analytics  |  1 day        |  1/hostpool |
| AVD-Storage-Low Space on ANF Share-XX Percent Remaining-{volumename}      | 5 / 15                     | Metric Alerts  |  1 hour       |  2/vol  |
| AVD-Storage-Low Space on Azure File Share-X% Remaining-{volumename} (1.)  | 5 / 15                     | Log Analytics  |  1 hour       |  2/share  |
| AVD-Storage-Over XXms Latency for Storage Act-{storacctname}              | 100ms / 50ms               | Metric Alerts  |  15 min       |  2/stor acct |
| AVD-Storage-Over XXms Latency Between Client-Storage-{storacctname}       | 100ms / 50ms               | Metric Alerts  |  15 min       |  2/stor acct |
| AVD-Storage-Possible Throttling Due to High IOPs-{storacctname}  (2.)     | na / custom :two:          | Metric Alerts  |  15 min       |  1/stor acct |
| AVD-Storage-Azure Files Availability-{storacctname}                       | 99 / na                    | Metric Alerts  |  5 min        |  1/stor acct |
| AVD-ServiceHealth-Health Advisory                                         | na                         | Service Health |  na           |   4  |
| AVD-ServiceHealth-Planned Maintenance                                     | na                         | Service Health |  na           |   4  |
| AVD-ServiceHealth-Security                                                | na                         | Service Health |  na           |   4  |
| AVD-ServiceHealth-Service Issue                                           | na                         | Service Health |  na           |   4  |

**NOTES:**  
1. Alert based on associated Automation Account / Runbook  
2. See the following for custom condition. Note that both Standard and Premium values are incorporated into the alert rule. ['How to create an alert if a file share is throttled'](https://docs.microsoft.com/azure/storage/files/storage-troubleshooting-files-performance#how-to-create-an-alert-if-a-file-share-is-throttled)  
Service Health - The alert severity cannot be set or changed from 'Verbose'  

## 📣Feedback 📣

Once you've had an opportunity to deploy the solution we'd love to hear from you! Click [here](https://aka.ms/alz/monitor/feedback) to leave your feedback.

If you have encountered a problem please file an issue in our GitHub repo [GitHub Issue](https://github.com/Azure/azure-monitor-baseline-alerts/issues).

## Deployment Guide

We have a [Deployment Guide](./deploy/Avd-Deploy) available for guidance on how to consume the contents of this repo.

## Known Issues

Please see the [Known Issues](Known-Issues).

## Frequently Asked Questions

Please see the [Frequently Asked Questions](../avd/FAQ).

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
