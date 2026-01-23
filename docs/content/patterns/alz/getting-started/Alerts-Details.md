---
title: Alerts Details
geekdocCollapseSection: true
weight: 30
---

### In this page

> [Overview](../Alerts-Details#overview) </br>
> [AMBA-ALZ Pattern: Activity Log Alerts](../Alerts-Details#amba-alz-pattern-activity-log-alerts) </br>
> [AMBA-ALZ Pattern: Log-Search Alerts](../Alerts-Details#amba-alz-pattern-log-search-alerts) </br>
> [AMBA-ALZ Pattern: Metric Alerts](../Alerts-Details#amba-alz-pattern-metric-alerts) </br>

## Overview

The provided resources, metric alerts, and configurations are intended as a starting point to address key monitoring questions such as "What should we monitor in Azure?" and "What alert settings should we use?". These settings cover the most common components of an Azure Landing Zone. However, we recommend customizing these settings to better suit your specific monitoring needs and Azure usage.

If you have suggestions for additional resources to include, open an Issue on this page with the Azure resource provider and settings you would like to see implemented. While we cannot guarantee implementation, we will carefully consider all suggestions. Alternatively, if you wish to contribute directly, follow the steps in the [Contributor Guide](../../../../contributing).

For details on which policy alert rules are included in the policy initiatives that are part of the AMBA-ALZ pattern, visit the [Policy-Initiatives](../Policy-Initiatives) page.

{{< hint type=note >}}
The tables are designed to minimize horizontal scrolling, but they contains substantial information. We recommend clicking on the specific alert name to directly access the JSON definition of the alert.
{{< /hint >}}

</br>

## AMBA-ALZ Pattern: Activity Log Alerts

Refer to the following sections to quickly identify any Activity Log based alert, such as Service Health alerts, with an Azure resource. This will save you time troubleshooting and allow you to focus on communicating with your user base or incorporating these alerts into your business continuity actions (remediations).
The values for Aggregation, Operator, Threshold, WindowSize, Frequency, and Severity are based on field experience and customer implementations.

{{% include "Activity-Log-Alerts-Table.md" %}}

</br>

## AMBA-ALZ Pattern: Log-Search Alerts

Refer to the following sections to quickly identify any Log-Search based alert, such as Azure Virtual Machine or Hybrid Virtual Machine alerts, with an Azure resource. This will save you time troubleshooting and allow you to focus on communicating with your user base or incorporating these alerts into your business continuity actions (remediations).
The values for Aggregation, Operator, Threshold, WindowSize, Frequency, and Severity are based on field experience and customer implementations.

{{% include "Log-Search-Alerts-Table.md" %}}

</br>

## AMBA-ALZ Pattern: Metric Alerts

Refer to the following sections to quickly identify any Metric based alert, such as Azure Firewall, KeyVault, or Network alerts, with an Azure resource. This will save you time troubleshooting and allow you to focus on communicating with your user base or incorporating these alerts into your business continuity actions (remediations).
The values for Aggregation, Operator, Threshold, WindowSize, Frequency, and Severity are based on field experience and customer implementations.

Only a limited number of resources support metric alert rules scoped at the subscription level, and these metric alerts apply only to resources deployed within the same region.

{{% include "Metric-Alerts-Table.md" %}}

<sup>1</sup> For more details on why the availability alert thresholds are lower than 100% in this solution when the product group documentation recommends 100%, see the [FAQ](../../Resources/FAQ).
