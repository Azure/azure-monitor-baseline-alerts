---
title: PrivZones Monitoring Pack
geekdocCollapseSection: true
weight: 50
---
[Alerts](#alerts)

## Alerts

|DisplayName|Type|Description|
|---|---|---|
|[Virtual Network Link Capacity Utilization - Microsoft.Network/privateDnsZones](#virtual-network-link-capacity-utilization---microsoftnetworkprivatednszones)|Microsoft.Insights/metricAlerts|VNet Link Capacity Utilization - privateDnsZones|
|[Query Volume - Microsoft.Network/privateDnsZones](#query-volume---microsoftnetworkprivatednszones)|Microsoft.Insights/metricAlerts|Query Volume - privateDnsZones|
|[Record Set Capacity Utilization - Microsoft.Network/privateDnsZones](#record-set-capacity-utilization---microsoftnetworkprivatednszones)|Microsoft.Insights/metricAlerts|Record Set Capacity Utilization - privateDnsZones|
|[Virtual Network With Registration Capacity Utilization - Microsoft.Network/privateDnsZones](#virtual-network-with-registration-capacity-utilization---microsoftnetworkprivatednszones)|Microsoft.Insights/metricAlerts|VNet With Registration Capacity Util. - privateDnsZones|

### Virtual Network Link Capacity Utilization - Microsoft.Network/privateDnsZones

|Property | Value |
|---|---|
|Alert Type                    | Microsoft.Insights/metricAlerts |
|Alert Name                    |VNet Link Capacity Utilization - privateDnsZones|
|Alert DisplayName             |Virtual Network Link Capacity Utilization - Microsoft.Network/privateDnsZones|
|Alert Description             |Percent of Virtual Network Link capacity utilized by a Private DNS zone|
|Metric Namespace             |Microsoft.Network/privateDnsZones|
|Severity                    |2|
|Metric Name                  |VirtualNetworkLinkCapacityUtilization|
|Operator                     |GreaterThanOrEqual|
|Evaluation Frequency       |PT1H|
|Windows Size                |PT1H|
|Threshold                 |80|
|Auto Mitigate              |false|
|Initiative Member             |True|
|Pack Type                     |Platform|
|Time Aggregation              |Maximum|

### Query Volume - Microsoft.Network/privateDnsZones

|Property | Value |
|---|---|
|Alert Type                    | Microsoft.Insights/metricAlerts |
|Alert Name                    |Query Volume - privateDnsZones|
|Alert DisplayName             |Query Volume - Microsoft.Network/privateDnsZones|
|Alert Description             |Number of queries served for a Private DNS zone|
|Metric Namespace             |Microsoft.Network/privateDnsZones|
|Severity                    |4|
|Metric Name                  |QueryVolume|
|Operator                     |GreaterThanOrEqual|
|Evaluation Frequency       |PT1H|
|Windows Size                |PT1H|
|Threshold                 |500|
|Auto Mitigate              |false|
|Initiative Member             |True|
|Pack Type                     |Platform|
|Time Aggregation              |Total|

### Record Set Capacity Utilization - Microsoft.Network/privateDnsZones

|Property | Value |
|---|---|
|Alert Type                    | Microsoft.Insights/metricAlerts |
|Alert Name                    |Record Set Capacity Utilization - privateDnsZones|
|Alert DisplayName             |Record Set Capacity Utilization - Microsoft.Network/privateDnsZones|
|Alert Description             |Percent of Record Set capacity utilized by a Private DNS zone|
|Metric Namespace             |Microsoft.Network/privateDnsZones|
|Severity                    |2|
|Metric Name                  |RecordSetCapacityUtilization|
|Operator                     |GreaterThanOrEqual|
|Evaluation Frequency       |PT1H|
|Windows Size                |PT1H|
|Threshold                 |80|
|Auto Mitigate              |false|
|Initiative Member             |True|
|Pack Type                     |Platform|
|Time Aggregation              |Maximum|

### Virtual Network With Registration Capacity Utilization - Microsoft.Network/privateDnsZones

|Property | Value |
|---|---|
|Alert Type                    | Microsoft.Insights/metricAlerts |
|Alert Name                    |VNet With Registration Capacity Util. - privateDnsZones|
|Alert DisplayName             |Virtual Network With Registration Capacity Utilization - Microsoft.Network/privateDnsZones|
|Alert Description             |Percent of Virtual Network Link with auto-registration capacity utilized by a Private DNS zone|
|Metric Namespace             |Microsoft.Network/privateDnsZones|
|Severity                    |2|
|Metric Name                  |VirtualNetworkWithRegistrationCapacityUtilization|
|Operator                     |GreaterThanOrEqual|
|Evaluation Frequency       |PT1H|
|Windows Size                |PT1H|
|Threshold                 |80|
|Auto Mitigate              |false|
|Initiative Member             |True|
|Pack Type                     |Platform|
|Time Aggregation              |Maximum|
