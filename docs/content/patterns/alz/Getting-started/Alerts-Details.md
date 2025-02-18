---
title: Alerts Details
geekdocCollapseSection: true
weight: 30
---

### In this page

> [AMBA-ALZ Pattern Metric Alerts Settings](../Alerts-Details#amba-alz-pattern-metric-alerts-settings) </br>
> [AMBA-ALZ Pattern Activity Log Alerts](../Alerts-Details#amba-alz-pattern-activity-log-alerts) </br>
> [VM Insights Log Alerts](../Alerts-Details#vm-insights-log-alerts) </br>
> [Recovery Vault Alerts](../Alerts-Details#recovery-vault-alerts) </br>

To download specific alerts for the AMBA-ALZ pattern, click the Download icon (highlighted in red below) in the top right corner of the page.

  ![Alert-Details Download icon](../../media/AlertDetailsDownloadReference.png)

For details on which policy alert rules are included in the AMBA-ALZ pattern, visit the [Policy-Initiatives](../Policy-Initiatives) page.

The provided resources, metric alerts, and configurations are intended as a starting point to address key monitoring questions such as "What should we monitor in Azure?" and "What alert settings should we use?". These settings cover the most common components of an Azure Landing Zone. However, we recommend customizing these settings to better suit your specific monitoring needs and Azure usage.

If you have suggestions for additional resources to include, open an Issue on this page with the Azure resource provider and settings you would like to see implemented. While we cannot guarantee implementation, we will carefully consider all suggestions. Alternatively, if you wish to contribute directly, follow the steps in the [Contributor Guide](../../../../contributing).

## AMBA-ALZ Pattern Metric Alerts Settings

The values for Aggregation, Operator, Threshold, WindowSize, Frequency, and Severity are based on field experience and customer implementations. Alerts are derived from Microsoft public guidance where available (indicated by 'Yes' in the Verified column) and practical application experience where public guidance is not available (indicated by 'No' in the Verified column). Links to Product Group guidance are provided in the References column. Where no guidance is available, a link to the metric description on learn.microsoft.com is included.

The Scope column indicates where alerts are scoped as described in [Introduction to deploying the AMBA-ALZ Pattern](../../HowTo/deploy/Introduction-to-deploying-the-ALZ-Pattern).

Only a limited number of resources support metric alert rules scoped at the subscription level, and these metric alerts apply only to resources deployed within the same region. The Support for Multiple Resources column indicates which resources support metric alerts at the subscription level. For a comprehensive list of resources that support metric alert rules at the subscription level, click [here](https://learn.microsoft.com/en-us/azure/azure-monitor/alerts/alerts-types#monitor-multiple-resources).

{{< hint type=note >}}
The table is designed to minimize horizontal scrolling, but it contains substantial information. We recommend clicking on the specific alert name to directly access the JSON definition of the alert.
{{< /hint >}}

{{< alzMetricAlerts >}}

<sup>1</sup> For more details on why the availability alert thresholds are lower than 100% in this solution when the product group documentation recommends 100%, see the [FAQ](../../Resources/FAQ).

## AMBA-ALZ Pattern Activity Log Alerts

### Activity Log Resource Health

Refer to the following sections to quickly identify any Service Health issues with an Azure resource. This will save you time troubleshooting and allow you to focus on communicating with your user base or incorporating these alerts into your business continuity actions (remediations).

{{< alzActivityLogResourceHealthAlerts >}}

### Service Health Alerts

{{< alzActivityLogServiceHealthAlerts >}}

### Activity Log Administrative

The table below lists several operational Activity Log alerts designed to notify your team when specific resources are deleted.

While there is no specific guidance per resource type, the provided information offers general advice on alerting for the deletion of particular resources. This list may expand in the future, and you are encouraged to create your own alerts following the pattern used for these Activity Log alerts.

{{< alzActivityLogAdministrativeAlerts >}}

## VM Insights Log Alerts

Once VM Insights is enabled in your environment, the following alert rules can be configured via the Baseline Alerts framework.

N/A: Not applicable, not used in the query or used as a parameter.

{{< alzVMInsightsLogAlerts >}}

## Recovery Vault Alerts

The following policy disables the classic alerts available in Azure Backup and enables the Azure Monitor alerts.

Security Alerts and Job Failure alerts are summarized in the "[Using Backup Center](https://learn.microsoft.com/en-us/azure/backup/backup-azure-monitoring-built-in-monitor?tabs=recovery-services-vaults#azure-monitor-alerts-for-azure-backup)" documentation.

| PolicyName                                                                                                                                                                                    | Component                         | Category                                                                                              | Scope    | Support for Multiple Resources | Verified | References                                                                                                                                                                                                                                                                                                            |
|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|-----------------------------------|-------------------------------------------------------------------------------------------------------|----------|--------------------------------|----------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| [Deploy RV Backup Health Monitoring Alerts](../../../services/RecoveryServices/vaults/Modify-RSV-BackupHealth-Alert.json) | Microsoft.RecoveryServices/Vaults | Microsoft.RecoveryServices/vaults/monitoringSettings.classicAlertSettings.alertsForCriticalOperations | Resource | No                             | Y        | [Azure Monitor Alerts for Azure Backup](https://learn.microsoft.com/en-us/azure/backup/backup-azure-monitoring-built-in-monitor?tabs=recovery-services-vaults#azure-monitor-alerts-for-azure-backup) <br> [Move to Azure Monitor Alerts](https://learn.microsoft.com/en-us/azure/backup/move-to-azure-monitor-alerts) |
