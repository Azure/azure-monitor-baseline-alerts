---
title: LoadBalancers Monitoring Pack
geekdocCollapseSection: true
weight: 50
---
[Alerts](#alerts)

## Alerts

|DisplayName|Type|Description|
|---|---|---|
|[Load Balancer Dip Availability](#load-balancer-dip-availability)|Microsoft.Insights/metricAlerts|Load Balancer Dip Availability|
|[Metric Alert for ALB Used SNAT Ports](#metric-alert-for-alb-used-snat-ports)|Microsoft.Insights/metricAlerts|Load Balancer Metric Alert for ALB Used SNAT Ports|
|[Deploy ALB VIP Availability Alert](#deploy-alb-vip-availability-alert)|Microsoft.Insights/metricAlerts|Load Balancer VIP Availability Alert|

### Load Balancer Dip Availability

|Property | Value |
|---|---|
|Alert Type                    | Microsoft.Insights/metricAlerts |
|Alert Name                    |Load Balancer Dip Availability|
|Alert DisplayName             |Load Balancer Dip Availability|
|Alert Description             |policy to deploy Load Balancer Dip Availability|
|Metric Namespace             |Microsoft.Network/loadBalancers|
|Severity                    |0|
|Metric Name                  |DipAvailability|
|Operator                     |LessThan|
|Evaluation Frequency       |PT1M|
|Windows Size                |PT1M|
|Threshold                 |90|
|Auto Mitigate              |false|
|Initiative Member             |True|
|Pack Type                     |Platform|
|Time Aggregation              ||

### Metric Alert for ALB Used SNAT Ports

|Property | Value |
|---|---|
|Alert Type                    | Microsoft.Insights/metricAlerts |
|Alert Name                    |Load Balancer Metric Alert for ALB Used SNAT Ports|
|Alert DisplayName             |Metric Alert for ALB Used SNAT Ports|
|Alert Description             |Policy to deploy Metric Alert for ALB Used SNAT Ports|
|Metric Namespace             |Microsoft.Network/loadBalancers|
|Severity                    |1|
|Metric Name                  |UsedSNATPorts|
|Operator                     |GreaterThan|
|Evaluation Frequency       |PT1M|
|Windows Size                |PT1M|
|Threshold                 |900|
|Auto Mitigate              |false|
|Initiative Member             |True|
|Pack Type                     |Platform|
|Time Aggregation              ||

### Deploy ALB VIP Availability Alert

|Property | Value |
|---|---|
|Alert Type                    | Microsoft.Insights/metricAlerts |
|Alert Name                    |Load Balancer VIP Availability Alert|
|Alert DisplayName             |Deploy ALB VIP Availability Alert|
|Alert Description             |Policy to deploy ALB VIP Availability Alert|
|Metric Namespace             |Microsoft.Network/loadBalancers|
|Severity                    |0|
|Metric Name                  |VipAvailability|
|Operator                     |LessThan|
|Evaluation Frequency       |PT1M|
|Windows Size                |PT5M|
|Threshold                 |90|
|Auto Mitigate              |false|
|Initiative Member             |True|
|Pack Type                     |Platform|
|Time Aggregation              ||
