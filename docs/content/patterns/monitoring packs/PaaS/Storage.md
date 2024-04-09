---
title: Storage Monitoring Pack
geekdocCollapseSection: true
weight: 50
---
[Alerts](#alerts)

## Alerts

|DisplayName|Type|Description|
|---|---|---|
|[Storage Availability Alert](#storage-availability-alert)|Microsoft.Insights/metricAlerts|Storage_Availability_Alert|

### Storage Availability Alert

|Property | Value |
|---|---|
|Alert Type                    | Microsoft.Insights/metricAlerts |
|Alert Name                    |Storage_Availability_Alert|
|Alert DisplayName             |Storage Availability Alert|
|Alert Description             |Storage Availability Alert|
|Metric Namespace             |Microsoft.Storage/storageAccounts|
|Severity                    |1|
|Metric Name                  |Availability|
|Operator                     |LessThan|
|Evaluation Frequency       |PT15M|
|Windows Size                |PT15M|
|Threshold                 |90|
|Auto Mitigate              |true|
|Initiative Member             |False|
|Pack Type                     |PaaS|
|Time Aggregation              ||
