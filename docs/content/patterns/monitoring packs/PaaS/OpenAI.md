---
title: OpenAI Monitoring Pack
geekdocCollapseSection: true
weight: 50
---
[Alerts](#alerts)

## Alerts
|DisplayName|Type|Description|
|---|---|---|
|[Alert on Client Errors over threshold](#alert-on-client-errors-over-threshold)|Microsoft.Insights/metricAlerts|Alert on Client Errors over threshold|
### Alert on Client Errors over threshold

|Property | Value |
|---|---|
|Alert Type                    | Microsoft.Insights/metricAlerts |
|Alert Name                    |Alert on Client Errors over threshold|
|Alert DisplayName             |Alert on Client Errors over threshold| |
|Alert Description             |Policy to deploy Alert on Client Errors over threshold| |
|Metric Namespace             |Microsoft.CognitiveServices/accounts| |
|Severity                    |3| |
|Metric Name                  |ClientErrors| |
|Operator                     |GreaterThan| |
|Evaluation Frequency       |PT15M| |
|Windows Size                |PT15M| |
|Threshold                 |20| |
|Auto Mitigate              |false| |
|Initiative Member             |False| |
|Pack Type                     |PaaS| |
|Time Aggregation              |Total| |
