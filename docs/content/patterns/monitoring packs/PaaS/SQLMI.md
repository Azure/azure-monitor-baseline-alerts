---
title: SQLMI Monitoring Pack
geekdocCollapseSection: true
weight: 50
---
[Alerts](#alerts)

## Alerts

|DisplayName|Type|Description|
|---|---|---|
|[avg_cpu_percent - Microsoft.Sql/managedInstances](#avg_cpu_percent---microsoftsqlmanagedinstances)|Microsoft.Insights/metricAlerts|avg_cpu_percent - managedInstances|
|[storage_space_used_mb - Microsoft.Sql/managedInstances](#storage_space_used_mb---microsoftsqlmanagedinstances)|Microsoft.Insights/metricAlerts|storage_space_used_mb - managedInstances|

### avg_cpu_percent - Microsoft.Sql/managedInstances

|Property | Value |
|---|---|
|Alert Type                    | Microsoft.Insights/metricAlerts |
|Alert Name                    |avg_cpu_percent - managedInstances|
|Alert DisplayName             |avg_cpu_percent - Microsoft.Sql/managedInstances|
|Alert Description             |Average CPU percentage|
|Metric Namespace             |Microsoft.Sql/managedInstances|
|Severity                    |2|
|Metric Name                  |avg_cpu_percent|
|Operator                     |GreaterThan|
|Evaluation Frequency       |PT1M|
|Windows Size                |PT5M|
|Threshold                 |80|
|Auto Mitigate              |false|
|Initiative Member             |True|
|Pack Type                     |PaaS|
|Time Aggregation              |Average|

### storage_space_used_mb - Microsoft.Sql/managedInstances

|Property | Value |
|---|---|
|Alert Type                    | Microsoft.Insights/metricAlerts |
|Alert Name                    |storage_space_used_mb - managedInstances|
|Alert DisplayName             |storage_space_used_mb - Microsoft.Sql/managedInstances|
|Alert Description             |Storage space used|
|Metric Namespace             |Microsoft.Sql/managedInstances|
|Severity                    |3|
|Metric Name                  |storage_space_used_mb|
|Operator                     |GreaterThan|
|Evaluation Frequency       |PT1M|
|Windows Size                |PT5M|
|Threshold                 |80|
|Auto Mitigate              |false|
|Initiative Member             |True|
|Pack Type                     |PaaS|
|Time Aggregation              |Average|
