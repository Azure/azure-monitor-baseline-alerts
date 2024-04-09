---
title: KeyVault Monitoring Pack
geekdocCollapseSection: true
weight: 50
---
[Alerts](#alerts)

## Alerts

|DisplayName|Type|Description|
|---|---|---|
|[Activity Log Key Vault Delete Alert](#activity-log-key-vault-delete-alert)|Microsoft.Insights/activityLogAlerts|Activitylog_KeyVault_Delete|
|[Deploy KeyVault Latency Alert](#deploy-keyvault-latency-alert)|Microsoft.Insights/metricAlerts|Deploy_KeyVault_Latency_Alert|

### Activity Log Key Vault Delete Alert

|Property | Value |
|---|---|
|Alert Type                    | Microsoft.Insights/activityLogAlerts |
|Alert Name                    |Activitylog_KeyVault_Delete|
|Alert DisplayName             |Activity Log Key Vault Delete Alert|
|Alert Description             |Activity Log Key Vault Delete Alert|
|Metric Namespace             ||
|Severity                    ||
|Metric Name                  ||
|Operator                     ||
|Evaluation Frequency       ||
|Windows Size                ||
|Threshold                 ||
|Auto Mitigate              ||
|Initiative Member             |True|
|Pack Type                     |Platform|
|Time Aggregation              ||

### Deploy KeyVault Latency Alert

|Property | Value |
|---|---|
|Alert Type                    | Microsoft.Insights/metricAlerts |
|Alert Name                    |Deploy_KeyVault_Latency_Alert|
|Alert DisplayName             |Deploy KeyVault Latency Alert|
|Alert Description             |Policy to audit/deploy KeyVault Latency Alert|
|Metric Namespace             |Microsoft.KeyVault/vaults|
|Severity                    |3|
|Metric Name                  |ServiceApiLatency|
|Operator                     |GreaterThan|
|Evaluation Frequency       |PT15M|
|Windows Size                |PT15M|
|Threshold                 |1000|
|Auto Mitigate              |true|
|Initiative Member             |True|
|Pack Type                     |Platform|
|Time Aggregation              ||
