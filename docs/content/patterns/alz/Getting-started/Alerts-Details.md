---
title: Alerts Details
geekdocCollapseSection: true
weight: 30
---

Download specific alerts for ALZ by clicking on the Download icon (highlighted in red below) in the top right corner of the page.

  ![Alert-Details Download icon](../../media/AlertDetailsDownloadReference.png)

To view which policy alert rules are part of the ALZ pattern, visit the [Policy-Initiatives](../Policy-Initiatives) page.

The resources, metric alerts, and their configurations serve as an initial guide to help you address key monitoring questions such as "What should we monitor in Azure?" and "What alert settings should we use?". These settings are designed to cover the most common components of an Azure Landing Zone. However, we recommend customising these settings to better align with your specific monitoring requirements and usage of Azure.

If you have suggestions for other resources that should be included, open an Issue on this page providing the Azure resource provider and settings you would like implemented. We can not guarantee their implementation but we will carefully consider them. Alternatively, if you would like to contribute directly, follow the steps in the [Contributor Guide](../../../../contributing).

## Azure Landing Zone Metric Alerts Settings

The values shown for Aggregation, Operator, Threshold, WindowSize, Frequency, and Severity are derived from field experience and customer implementations. Alerts are based on Microsoft public guidance where available (indicated by a 'Yes' in the Verified column) and practical application experience where public guidance is not available (indicated by a 'No' in the Verified column). Links to Product Group guidance are provided in the References column. Where no guidance is available, a link to the description of the Metric on learn.microsoft.com is included.

The Scope column indicates where we scoped the alerts as described in [Introduction to deploying the ALZ Pattern](../../HowTo/deploy/Introduction-to-deploying-the-ALZ-Pattern).

Only a limited number of resources support metric alert rules scoped at the subscription level, and these metric alerts are applicable only to resources deployed within the same region. The Support for Multiple Resources column indicates which resources support metric alerts at the subscription level. For a comprehensive list of resources that support metric alert rules at the subscription level, please click [here](https://learn.microsoft.com/en-us/azure/azure-monitor/alerts/alerts-types#monitor-multiple-resources).

{{< hint type=note >}}
We have designed the table to minimize the need for horizontal scrolling, but it still contains a substantial amount of information. We recommend clicking on the specific alert name to directly access the JSON definition of the alert you're interested in.
{{< /hint >}}

{{< alzMetricAlerts >}}

<sup>1</sup> See "Why are the availability alert thresholds lower than 100% in this solution when the product group document ion recommends 100%?" in the [FAQ](../../Resources/FAQ) for more details.

## Azure Landing Zone Activity Log Alerts

### Azure Landing Zone Activity Log Resource Health

Refer to the following two sections to promptly identify any Service Health issues with an Azure resource. This will save you the effort of further troubleshooting and allow you to focus on communicating with your user base or incorporating these alerts into your business continuity actions (remediations).

{{< alzActivityLogResourceHealthAlerts >}}

### Azure Landing Zone Service Health Alerts

{{< alzActivityLogServiceHealthAlerts >}}

### Azure Landing Zone Activity Log Administrative

The table below lists several operational Activity Log alerts designed to notify your team when specific resources are deleted.

While there is no specific guidance per resource type, the provided information offers general advice on alerting for the deletion of particular resources. This list may expand in the future, and you are encouraged to create your own alerts following the pattern used for these Activity Log alerts.

{{< alzActivityLogAdministrativeAlerts >}}

## VM Insights Log Alerts

Once VM Insights has been enabled in your environment, the following alert rules can be configured via the Baseline Alerts framework.

N/A: Not applicable, not used in the query or used as a parameter.

{{< alzVMInsightsLogAlerts >}}

## Recovery Vault Alerts

The following policy disables the classic alerts available in Azure Backup and enables the Azure Monitor alerts.

Security Alerts and Job Failure alerts are summarized in the "[Using Backup Center](https://learn.microsoft.com/en-us/azure/backup/backup-azure-monitoring-built-in-monitor?tabs=recovery-services-vaults#azure-monitor-alerts-for-azure-backup)" documentation.

| PolicyName                                                                                                                                                                                    | Component                         | Category                                                                                              | Scope    | Support for Multiple Resources | Verified | References                                                                                                                                                                                                                                                                                                            |
|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|-----------------------------------|-------------------------------------------------------------------------------------------------------|----------|--------------------------------|----------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| [Deploy RV Backup Health Monitoring Alerts](../../../services/RecoveryServices/vaults/Modify-RSV-BackupHealth-Alert.json) | Microsoft.RecoveryServices/Vaults | Microsoft.RecoveryServices/vaults/monitoringSettings.classicAlertSettings.alertsForCriticalOperations | Resource | No                             | Y        | [Azure Monitor Alerts for Azure Backup](https://learn.microsoft.com/en-us/azure/backup/backup-azure-monitoring-built-in-monitor?tabs=recovery-services-vaults#azure-monitor-alerts-for-azure-backup) <br> [Move to Azure Monitor Alerts](https://learn.microsoft.com/en-us/azure/backup/move-to-azure-monitor-alerts) |

[Back to top of page](.)
