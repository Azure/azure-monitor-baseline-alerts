---
title: Alerts Details
geekdocCollapseSection: true
weight: 30
---

Specific alerts for ALZ can be downloaded by clicking on the Download icon (highlighted in red below) in the top right corner of the AMBA documentation.

  ![Alert-Details Download icon](../media/AlertDetailsDownloadReference.png)

The best way to see which policy alert rules are part of the ALZ pattern it is best to go to the [Policy-Initiatives](../Policy-Initiatives) page.

The resources, metric alerts and their settings provide you with a starting point to help you address the following monitoring questions:
"What should we monitor in Azure?" and "What alert settings should we use?"  While they are opinionated settings and they are meant to cover the most common Azure Landing Zone components, we encourage you to adjust these settings to suit your monitoring needs based on how you're using Azure.

If you have suggestions for other resources that should be included please open an Issue on this page providing the Azure resource provider and settings you'd like implemented, we can't promise to implement them all but we will look into it. Or if you'd like to contribute directly, follow the steps on how to contribute [here](../../../contributing/).

## Azure Landing Zone Metric Alerts Settings

The values shown for Aggregation, Operator, Threshold, WindowSize, Frequency and Severity have been derived from field experience and what customers have implemented themselves; Alerts are based on Microsoft public guidance where available (indicated by a 'Yes' in the Verified column), and on practical application experience where public guidance is not available (indicated by a 'No' in the Verified column). Links to Product Group guidance can be found in the References column and when no guidance is provided we've provided a link to the description of the Metric on learn.microsoft.com.

The Scope column details where we scoped the alerts as described in [Introduction to deploying the ALZ Pattern](../deploy/Introduction-to-deploying-the-ALZ-Pattern).

Only a small number of the resources support metric alert rules scoped at the subscription level and the metric alerts would only apply to resources deployed within the same region. The Support for Multiple Resources column to show which resources support metric alerts being scoped at the subscription level. For a complete list of which resources support metrics alert rules scoped at the subscription level click [here](https://learn.microsoft.com/en-us/azure/azure-monitor/alerts/alerts-types#monitor-multiple-resources).

{{< hint type=note >}}
We have tried to make it so that the table doesn't require a lot of side to side scrolling, but it is still a lot of information, we recommended that you click on the specifc alert name which will take you directly to the JSON definition of the alert you're interested in.
{{< /hint >}}

{{< alzMetricAlerts >}}

<sup>1</sup> See "Why are the availability alert thresholds lower than 100% in this solution when the product group documention recommends 100%?" in the [FAQ](../FAQ) for more details.

## Azure Landing Zone Activity Log Alerts

### Azure Landing Zone Activity Log Resource Health

Use the following two sections to quickly know when there's a Service Health issue with an Azure resource, saving you the effort of further troubleshooting and allow you to focus on communicating to your user base and/or use these alerts as part of your business continuity actions (remediations).

{{< alzActivityLogResourceHealthAlerts >}}

### Azure Landing Zone Service Health Alerts

{{< alzActivityLogServiceHealthAlerts >}}

### Azure Landing Zone Activity Log Administrative

The following table lists a number of operational Activity Log alerts to alert your team when certain resources have been deleted.

There isn't any per resource type guidance so what's been provided is some general guidance on alerting on the deletion of specific resources, the list may grow in the future and of course you can create your own following the pattern used for these Activity Log alerts.

{{< alzActivityLogAdministrativeAlerts >}}

## VM Insights Log Alerts

Once VM Insights has been enabled in your environment, the following alert rules can be configured for use via the Baseline Alerts framework.

N/A: Not applicable, not used in the query or used as a parameter.

{{< alzVMInsightsLogAlerts >}}

## Recovery Vault Alerts

The following policy disables the classic alerts that are available in Azure Backup and enables the Azure Monitor alerts.

Security Alerts and Job Failure alerts are summarized in the "[Using Backup Center](https://learn.microsoft.com/en-us/azure/backup/backup-azure-monitoring-built-in-monitor?tabs=recovery-services-vaults#azure-monitor-alerts-for-azure-backup)" documentation.

| PolicyName                                                                                                                                                                                    | Component                         | Category                                                                                              | Scope    | Support for Multiple Resources | Verified | References                                                                                                                                                                                                                                                                                                            |
|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|-----------------------------------|-------------------------------------------------------------------------------------------------------|----------|--------------------------------|----------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| [Deploy RV Backup Health Monitoring Alerts](../../../services/RecoveryServices/vaults/Modify-RSV-BackupHealth-Alert.json) | Microsoft.RecoveryServices/Vaults | Microsoft.RecoveryServices/vaults/monitoringSettings.classicAlertSettings.alertsForCriticalOperations | Resource | No                             | Y        | [Azure Monitor Alerts for Azure Backup](https://learn.microsoft.com/en-us/azure/backup/backup-azure-monitoring-built-in-monitor?tabs=recovery-services-vaults#azure-monitor-alerts-for-azure-backup) <br> [Move to Azure Monitor Alerts](https://learn.microsoft.com/en-us/azure/backup/move-to-azure-monitor-alerts) |
