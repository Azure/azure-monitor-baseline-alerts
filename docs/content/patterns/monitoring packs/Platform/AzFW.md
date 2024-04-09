---
title: AzFW Monitoring Pack
geekdocCollapseSection: true
weight: 50
---
[Alerts](#alerts)

## Alerts

|DisplayName|Type|Description|
|---|---|---|
|[Firewall Health - Microsoft.Network/azureFirewalls](#firewall-health---microsoftnetworkazurefirewalls)|Microsoft.Insights/metricAlerts|Firewall Health - azureFirewalls|
|[SNAT Port Utilization - Microsoft.Network/azureFirewalls](#snat-port-utilization---microsoftnetworkazurefirewalls)|Microsoft.Insights/metricAlerts|SNAT Port Utilization - azureFirewalls|

### Firewall Health - Microsoft.Network/azureFirewalls

|Property | Value |
|---|---|
|Alert Type                    | Microsoft.Insights/metricAlerts |
|Alert Name                    |Firewall Health - azureFirewalls|
|Alert DisplayName             |Firewall Health - Microsoft.Network/azureFirewalls|
|Alert Description             |Indicates the overall health of this firewall|
|Metric Namespace             |Microsoft.Network/azureFirewalls|
|Severity                    |0|
|Metric Name                  |FirewallHealth|
|Operator                     |LessThan|
|Evaluation Frequency       |PT1M|
|Windows Size                |PT5M|
|Threshold                 |90|
|Auto Mitigate              |false|
|Initiative Member             |True|
|Pack Type                     |Platform|
|Time Aggregation              |Average|

### SNAT Port Utilization - Microsoft.Network/azureFirewalls

|Property | Value |
|---|---|
|Alert Type                    | Microsoft.Insights/metricAlerts |
|Alert Name                    |SNAT Port Utilization - azureFirewalls|
|Alert DisplayName             |SNAT Port Utilization - Microsoft.Network/azureFirewalls|
|Alert Description             |Percentage of outbound SNAT ports currently in use|
|Metric Namespace             |Microsoft.Network/azureFirewalls|
|Severity                    |1|
|Metric Name                  |SNATPortUtilization|
|Operator                     |LessThan|
|Evaluation Frequency       |PT1M|
|Windows Size                |PT5M|
|Threshold                 |80|
|Auto Mitigate              |false|
|Initiative Member             |True|
|Pack Type                     |Platform|
|Time Aggregation              |Average|
