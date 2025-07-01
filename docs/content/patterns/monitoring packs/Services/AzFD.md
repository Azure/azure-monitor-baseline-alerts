---
title: AzFD Monitoring Pack
geekdocCollapseSection: true
weight: 50
---
[Alerts](#alerts)

## Alerts

|DisplayName|Type|Description|
|---|---|---|
|[Backend Health Percentage - Microsoft.Network/frontdoors](#backend-health-percentage---microsoftnetworkfrontdoors)|Microsoft.Insights/metricAlerts|Backend Health Percentage - frontdoors|
|[Request Count - Microsoft.Network/frontdoors](#request-count---microsoftnetworkfrontdoors)|Microsoft.Insights/metricAlerts|Request Count - frontdoors|
|[Total Latency - Microsoft.Network/frontdoors](#total-latency---microsoftnetworkfrontdoors)|Microsoft.Insights/metricAlerts|Total Latency - frontdoors|

### Backend Health Percentage - Microsoft.Network/frontdoors

|Property | Value |
|---|---|
|Alert Type                    | Microsoft.Insights/metricAlerts |
|Alert Name                    |Backend Health Percentage - frontdoors|
|Alert DisplayName             |Backend Health Percentage - Microsoft.Network/frontdoors|
|Alert Description             |The percentage of successful health probes from the HTTP/S proxy to backends|
|Metric Namespace             |Microsoft.Network/frontdoors|
|Severity                    |1|
|Metric Name                  |BackendHealthPercentage|
|Operator                     |LessThan|
|Evaluation Frequency       |PT1M|
|Windows Size                |PT5M|
|Threshold                 |80|
|Auto Mitigate              |false|
|Initiative Member             |True|
|Pack Type                     |Platform|
|Time Aggregation              |Average|

### Request Count - Microsoft.Network/frontdoors

|Property | Value |
|---|---|
|Alert Type                    | Microsoft.Insights/metricAlerts |
|Alert Name                    |Request Count - frontdoors|
|Alert DisplayName             |Request Count - Microsoft.Network/frontdoors|
|Alert Description             |The number of client requests served by the HTTP/S proxy|
|Metric Namespace             |Microsoft.Network/frontdoors|
|Severity                    |3|
|Metric Name                  |RequestCount|
|Operator                     |GreaterThan|
|Evaluation Frequency       |PT1M|
|Windows Size                |PT5M|
|Threshold                 |10|
|Auto Mitigate              |false|
|Initiative Member             |True|
|Pack Type                     |Platform|
|Time Aggregation              |Total|

### Total Latency - Microsoft.Network/frontdoors

|Property | Value |
|---|---|
|Alert Type                    | Microsoft.Insights/metricAlerts |
|Alert Name                    |Total Latency - frontdoors|
|Alert DisplayName             |Total Latency - Microsoft.Network/frontdoors|
|Alert Description             |The time calculated from when the client request was received by the HTTP/S proxy until the client acknowledged the last response byte from the HTTP/S proxy|
|Metric Namespace             |Microsoft.Network/frontdoors|
|Severity                    |3|
|Metric Name                  |TotalLatency|
|Operator                     |GreaterThan|
|Evaluation Frequency       |PT1M|
|Windows Size                |PT5M|
|Threshold                 |25000|
|Auto Mitigate              |false|
|Initiative Member             |True|
|Pack Type                     |Platform|
|Time Aggregation              |Average|
