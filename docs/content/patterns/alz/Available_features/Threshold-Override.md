---
title: Alert Threshold Override
geekdocCollapseSection: true
weight: 85
---

# Overview

The ***Alert Threshold Override*** feature, available with release [2024-09-05](../../Whats-New#2024-09-05), allows both Greenfield and Brownfield customers to override alert threshold for specific resources during or after the deployment of AMBA-ALZ. Thanks to this new feature, it's now possible to use a tag with specific name and value, to override the default alert threshold for specific resources. The new value will be used, only for the tagged resources, in place of the global one coming from the parameter file.

# How this feature works

This feature is only available for metrics and log-search alerts, since Activity Log based alerts do not use threshold and, as such, cannot benefits from this new enhancement. Using the feature is easy: customers need to create a resource tag with a specific name and assign a value of their choice. Once this release is deployed, tags can be created either before or after the execution of remediation task. However, the feature behavior differs between Metric and Log-search alerts.

## Metrics alerts

For metric alerts, if tags are configured before the remediation tasks execution, corresponding alerts (which are resource-specific) will be created using different thresholds for the same resource type:

![Metric Alerts - Override threshold at work](../../media/MetricAlerts-OverrideThresholdAtWork.png)

If the tags are configured after the remediation task have completed, given the tag being part of the compliance criteria, the resource will be marked as not compliant, as such customers will just need to remediate the corresponding policy initiative(s) as documented at [Remediate Policies](../../deploy/Remediate-Policies) to reconfigure exiting alerts with the new threshold.

## Log-search alerts
Considering the different nature of log-search alerts where resource information is retrieved at query runtime, it does not make any difference if the tags are configured before or after the remediation task execution. The log-search alert query is created with a placeholder containing the threshold passed by the parameter file and with a logic to look at the resource-specific override tag, thanks to the ability to [Correlate data in Azure Data Explorer and Azure Resource Graph with data in a Log Analytics workspace](https://learn.microsoft.com/en-us/azure/azure-monitor/logs/azure-monitor-data-explorer-proxy). If the specific override tag name is present, the query will use the tag value as new threshold, otherwise it will use the default one passed through the parameter file:

![Log-search Alerts - Override threshold at work](../../media/LogsearchAlerts-OverrideThresholdAtWork.png)

## Which tag does customers need to create

To work correctly, this feature needs to look at specific tag names. Unfortunately it is not possible to allow for more flexibility in tag name in this case. Tag names have been defined, according to the following naming convention:

{{< hint type=Info >}}
Mapping between resource type friendly name and resource provider namespace (together with the recommended abbreviation) can be found at [Abbreviation recommendations for Azure resources](https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/ready/azure-best-practices/resource-abbreviations)
{{< /hint >}}

```***_amba-<metricName/counterName>-threshold-override_***```

There might be cases where for the same resource, the same metric is used more than one. In this scenario, we implemented a differentiator value inserted right after the metric name, making the naming convention resampling the following format:

```***_amba-<metricName/counterName>-<differentiator>-threshold-override_***```

The following table contains the mapping between the alert name and the corresponding tag value to be created:

</br>

### Log-search alerts table

{{% include "Log_Search_Alert_Table.md" %}}

</br>

### Metric alerts table

{{% include "Metrics_Alert_Table.md" %}}
