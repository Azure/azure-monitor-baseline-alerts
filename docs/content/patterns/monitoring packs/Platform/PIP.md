---
title: PIP Monitoring Pack
geekdocCollapseSection: true
weight: 50
---
[Alerts](#alerts)

## Alerts

|DisplayName|Type|Description|
|---|---|---|
|[Bytes In DDoS - Microsoft.Network/publicIPAddresses](#bytes-in-ddos---microsoftnetworkpublicipaddresses)|Microsoft.Insights/metricAlerts|Bytes In DDoS - publicIPAddresses|
|[If Under DDoS Attack - Microsoft.Network/publicIPAddresses](#if-under-ddos-attack---microsoftnetworkpublicipaddresses)|Microsoft.Insights/metricAlerts|If Under DDoS Attack - publicIPAddresses|
|[Packets In DDoS - Microsoft.Network/publicIPAddresses](#packets-in-ddos---microsoftnetworkpublicipaddresses)|Microsoft.Insights/metricAlerts|Packets In DDoS - publicIPAddresses|
|[VIP Availability - Microsoft.Network/publicIPAddresses](#vip-availability---microsoftnetworkpublicipaddresses)|Microsoft.Insights/metricAlerts|VIP Availability - publicIPAddresses|

### Bytes In DDoS - Microsoft.Network/publicIPAddresses

|Property | Value |
|---|---|
|Alert Type                    | Microsoft.Insights/metricAlerts |
|Alert Name                    |Bytes In DDoS - publicIPAddresses|
|Alert DisplayName             |Bytes In DDoS - Microsoft.Network/publicIPAddresses|
|Alert Description             |Metric Alert for Public IP Address Bytes IN DDOS|
|Metric Namespace             |Microsoft.Network/publicIPAddresses|
|Severity                    |4|
|Metric Name                  |bytesinddos|
|Operator                     |GreaterThan|
|Evaluation Frequency       |PT5M|
|Windows Size                |PT5M|
|Threshold                 |8000000|
|Auto Mitigate              |false|
|Initiative Member             |True|
|Pack Type                     |Platform|
|Time Aggregation              |Maximum|

### If Under DDoS Attack - Microsoft.Network/publicIPAddresses

|Property | Value |
|---|---|
|Alert Type                    | Microsoft.Insights/metricAlerts |
|Alert Name                    |If Under DDoS Attack - publicIPAddresses|
|Alert DisplayName             |If Under DDoS Attack - Microsoft.Network/publicIPAddresses|
|Alert Description             |Metric Alert for Public IP Address Under Attack|
|Metric Namespace             |Microsoft.Network/publicIPAddresses|
|Severity                    |1|
|Metric Name                  |ifunderddosattack|
|Operator                     |GreaterThan|
|Evaluation Frequency       |PT5M|
|Windows Size                |PT5M|
|Threshold                 |0|
|Auto Mitigate              |false|
|Initiative Member             |True|
|Pack Type                     |Platform|
|Time Aggregation              |Maximum|

### Packets In DDoS - Microsoft.Network/publicIPAddresses

|Property | Value |
|---|---|
|Alert Type                    | Microsoft.Insights/metricAlerts |
|Alert Name                    |Packets In DDoS - publicIPAddresses|
|Alert DisplayName             |Packets In DDoS - Microsoft.Network/publicIPAddresses|
|Alert Description             |Inbound packets DDoS|
|Metric Namespace             |Microsoft.Network/publicIPAddresses|
|Severity                    |4|
|Metric Name                  |PacketsInDDoS|
|Operator                     |GreaterThanOrEqual|
|Evaluation Frequency       |PT5M|
|Windows Size                |PT5M|
|Threshold                 |40000|
|Auto Mitigate              |false|
|Initiative Member             |True|
|Pack Type                     |Platform|
|Time Aggregation              |Total|

### VIP Availability - Microsoft.Network/publicIPAddresses

|Property | Value |
|---|---|
|Alert Type                    | Microsoft.Insights/metricAlerts |
|Alert Name                    |VIP Availability - publicIPAddresses|
|Alert DisplayName             |VIP Availability - Microsoft.Network/publicIPAddresses|
|Alert Description             |Average IP Address availability per time duration|
|Metric Namespace             |Microsoft.Network/publicIPAddresses|
|Severity                    |1|
|Metric Name                  |VipAvailability|
|Operator                     |LessThan|
|Evaluation Frequency       |PT1M|
|Windows Size                |PT5M|
|Threshold                 |90|
|Auto Mitigate              |false|
|Initiative Member             |True|
|Pack Type                     |Platform|
|Time Aggregation              |Average|
