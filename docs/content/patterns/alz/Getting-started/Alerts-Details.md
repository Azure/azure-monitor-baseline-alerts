---
title: Alerts Details
geekdocCollapseSection: true
weight: 30
---

### In this page

> [AMBA-ALZ Pattern Activity Log Alerts](../Alerts-Details#amba-alz-pattern-activity-log-alerts) </br>
> [AMBA-ALZ Pattern Log-Search Alerts](../Alerts-Details#amba-alz-pattern-log-search-alerts) </br>
> [AMBA-ALZ Pattern Metric Alerts Settings](../Alerts-Details#amba-alz-pattern-metric-alerts-settings) </br>

To download specific alerts for the AMBA-ALZ pattern, click the Download icon (highlighted in red below) in the top right corner of the page.

  ![Alert-Details Download icon](../../media/AlertDetailsDownloadReference.png)

For details on which policy alert rules are included in the AMBA-ALZ pattern, visit the [Policy-Initiatives](../Policy-Initiatives) page.

The provided resources, metric alerts, and configurations are intended as a starting point to address key monitoring questions such as "What should we monitor in Azure?" and "What alert settings should we use?". These settings cover the most common components of an Azure Landing Zone. However, we recommend customizing these settings to better suit your specific monitoring needs and Azure usage.

If you have suggestions for additional resources to include, open an Issue on this page with the Azure resource provider and settings you would like to see implemented. While we cannot guarantee implementation, we will carefully consider all suggestions. Alternatively, if you wish to contribute directly, follow the steps in the [Contributor Guide](../../../../contributing).

## AMBA-ALZ Pattern Activity Log Alerts

Refer to the following sections to quickly identify any Service Health issues with an Azure resource. This will save you time troubleshooting and allow you to focus on communicating with your user base or incorporating these alerts into your business continuity actions (remediations).

{{% include "Activity-Log-Alerts-Table.md" %}}

## AMBA-ALZ Pattern Log-Search Alerts

{{% include "Log-Search-Alerts-Table.md" %}}

## AMBA-ALZ Pattern Metric Alerts Settings

The values for Aggregation, Operator, Threshold, WindowSize, Frequency, and Severity are based on field experience and customer implementations. Alerts are derived from Microsoft public guidance where available (indicated by 'Yes' in the Verified column) and practical application experience where public guidance is not available (indicated by 'No' in the Verified column). Links to Product Group guidance are provided in the References column. Where no guidance is available, a link to the metric description on learn.microsoft.com is included.

The Scope column indicates where alerts are scoped as described in [Introduction to deploying the AMBA-ALZ Pattern](../../HowTo/deploy/Introduction-to-deploying-the-ALZ-Pattern).

Only a limited number of resources support metric alert rules scoped at the subscription level, and these metric alerts apply only to resources deployed within the same region. The Support for Multiple Resources column indicates which resources support metric alerts at the subscription level. For a comprehensive list of resources that support metric alert rules at the subscription level, click [here](https://learn.microsoft.com/en-us/azure/azure-monitor/alerts/alerts-types#monitor-multiple-resources).

{{< hint type=note >}}
The table is designed to minimize horizontal scrolling, but it contains substantial information. We recommend clicking on the specific alert name to directly access the JSON definition of the alert.
{{< /hint >}}

{{% include "Metric-Alerts-Table.md" %}}

<sup>1</sup> For more details on why the availability alert thresholds are lower than 100% in this solution when the product group documentation recommends 100%, see the [FAQ](../../Resources/FAQ).
