---
title: Override alert thresholds
geekdocCollapseSection: true
weight: 85
---

# Overview

The ***Alert Threshold Override*** feature, introduced in the [2024-09-05 release](../../Whats-New#2024-09-05), enables both Greenfield and Brownfield customers to customize alert thresholds for specific resources during or after the deployment of AMBA-ALZ. This feature allows the use of a tag with a specific name and value to override the default alert threshold for designated resources. The new threshold value will apply exclusively to the tagged resources, replacing the global threshold specified in the parameter file.

# How this feature works

This feature is applicable exclusively to metrics and log-search alerts, as Activity Log-based alerts do not utilize thresholds and therefore cannot benefit from this enhancement. To use this feature, customers must create a resource tag with a specific name and assign it a desired value. After deploying this release, tags can be created either before or after the remediation task execution. However, the feature's behavior varies between Metric and Log-search alerts.

## Metrics alerts

If tags are configured before the remediation tasks execution, metric alerts will be created with the specified thresholds for the tagged resources, ensuring that each resource type has the appropriate alert thresholds applied.

![Metric Alerts - Override threshold at work](../../media/MetricAlerts-OverrideThresholdAtWork.png)

If the tags are configured after the remediation tasks have completed, the resource will be marked as non-compliant due to the tag being part of the compliance criteria. Customers will need to remediate the corresponding policy initiative(s) as documented in [Remediate Policies](../../deploy/Remediate-Policies) to reconfigure existing alerts with the new threshold.

## Log-search alerts

Considering the nature of log-search alerts, where resource information is retrieved at query runtime, it does not matter if the tags are configured before or after the remediation task execution. The log-search alert query is created with a placeholder containing the threshold specified in the parameter file and includes logic to check for the resource-specific override tag. This is made possible by the ability to [correlate data in Azure Data Explorer and Azure Resource Graph with data in a Log Analytics workspace](https://learn.microsoft.com/en-us/azure/azure-monitor/logs/azure-monitor-data-explorer-proxy). If the specific override tag is present, the query will use the tag value as the new threshold; otherwise, it will use the default threshold from the parameter file.

![Log-search Alerts - Override threshold at work](../../media/LogsearchAlerts-OverrideThresholdAtWork.png)

## Which tag does customers need to create

To ensure proper functionality, this feature requires specific tag names. Flexibility in tag naming is not supported in this case. The tag names must adhere to the following naming convention:

{{< hint type=Info >}}
For a comprehensive list of resource type friendly names, resource provider namespaces, and recommended abbreviations, refer to [Abbreviation recommendations for Azure resources](https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/ready/azure-best-practices/resource-abbreviations).
{{< /hint >}}

```***_amba-<metricName/counterName>-threshold-override_***```

In scenarios where the same metric is used multiple times for the same resource, a differentiator value is implemented immediately after the metric name. This ensures the naming convention follows the format:

```***_amba-<metricName/counterName>-<differentiator>-threshold-override_***```

The following table provides a mapping between alert names and the corresponding tag values that need to be created:

</br>

### Log-search alerts table

{{% include "Log_Search_Alert_Table.md" %}}

</br>

### Metric alerts table

{{% include "Metrics_Alert_Table.md" %}}

[Back to top of page](.)
