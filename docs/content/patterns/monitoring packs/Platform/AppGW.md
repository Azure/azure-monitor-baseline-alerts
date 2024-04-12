---
title: AppGW Monitoring Pack
geekdocCollapseSection: true
weight: 50
---
[Alerts](#alerts)

## Alerts

|DisplayName|Type|Description|
|---|---|---|
|[Application Gateway Total Time - Microsoft.Network/applicationGateways](#application-gateway-total-time---microsoftnetworkapplicationgateways)|Microsoft.Insights/metricAlerts|Application Gateway Total Time - applicationGateways|
|[Backend Last Byte Response Time - Microsoft.Network/applicationGateways](#backend-last-byte-response-time---microsoftnetworkapplicationgateways)|Microsoft.Insights/metricAlerts|Backend Last Byte Response Time - applicationGateways|
|[Capacity Units - Microsoft.Network/applicationGateways](#capacity-units---microsoftnetworkapplicationgateways)|Microsoft.Insights/metricAlerts|Capacity Units - applicationGateways|
|[Compute Units - Microsoft.Network/applicationGateways](#compute-units---microsoftnetworkapplicationgateways)|Microsoft.Insights/metricAlerts|Compute Units - applicationGateways|
|[Cpu Utilization - Microsoft.Network/applicationGateways](#cpu-utilization---microsoftnetworkapplicationgateways)|Microsoft.Insights/metricAlerts|Cpu Utilization - applicationGateways|
|[Failed Requests - Microsoft.Network/applicationGateways](#failed-requests---microsoftnetworkapplicationgateways)|Microsoft.Insights/metricAlerts|Failed Requests - applicationGateways|
|[Response Status - Microsoft.Network/applicationGateways](#response-status---microsoftnetworkapplicationgateways)|Microsoft.Insights/metricAlerts|Response Status - applicationGateways|
|[Unhealthy Host Count - Microsoft.Network/applicationGateways](#unhealthy-host-count---microsoftnetworkapplicationgateways)|Microsoft.Insights/metricAlerts|Unhealthy Host Count - applicationGateways|

### Application Gateway Total Time - Microsoft.Network/applicationGateways

|Property | Value |
|---|---|
|Alert Type                    | Microsoft.Insights/metricAlerts |
|Alert Name                    |Application Gateway Total Time - applicationGateways|
|Alert DisplayName             |Application Gateway Total Time - Microsoft.Network/applicationGateways|
|Alert Description             |Time that it takes for a request to be processed and its response to be sent. This is the interval from the time when Application Gateway receives the first byte of an HTTP request to the time when the response send operation finishes. It's important to note that this usually includes the Application Gateway processing time, time that the request and response packets are traveling over the network and the time the backend server took to respond.|
|Metric Namespace             |Microsoft.Network/applicationGateways|
|Severity                    |2|
|Metric Name                  |ApplicationGatewayTotalTime|
|Operator                     |GreaterThan|
|Evaluation Frequency       |PT1M|
|Windows Size                |PT5M|
|Threshold                 ||
|Auto Mitigate              |false|
|Initiative Member             |True|
|Pack Type                     |Platform|
|Time Aggregation              |Total|

### Backend Last Byte Response Time - Microsoft.Network/applicationGateways

|Property | Value |
|---|---|
|Alert Type                    | Microsoft.Insights/metricAlerts |
|Alert Name                    |Backend Last Byte Response Time - applicationGateways|
|Alert DisplayName             |Backend Last Byte Response Time - Microsoft.Network/applicationGateways|
|Alert Description             |Time interval between start of establishing a connection to backend server and receiving the last byte of the response body|
|Metric Namespace             |Microsoft.Network/applicationGateways|
|Severity                    |2|
|Metric Name                  |BackendLastByteResponseTime|
|Operator                     |GreaterThan|
|Evaluation Frequency       |PT1M|
|Windows Size                |PT5M|
|Threshold                 ||
|Auto Mitigate              |false|
|Initiative Member             |True|
|Pack Type                     |Platform|
|Time Aggregation              |Total|

### Capacity Units - Microsoft.Network/applicationGateways

|Property | Value |
|---|---|
|Alert Type                    | Microsoft.Insights/metricAlerts |
|Alert Name                    |Capacity Units - applicationGateways|
|Alert DisplayName             |Capacity Units - Microsoft.Network/applicationGateways|
|Alert Description             |Capacity Units consumed|
|Metric Namespace             |Microsoft.Network/applicationGateways|
|Severity                    |2|
|Metric Name                  |CapacityUnits|
|Operator                     |GreaterThan|
|Evaluation Frequency       |PT1M|
|Windows Size                |PT5M|
|Threshold                 |75|
|Auto Mitigate              |false|
|Initiative Member             |True|
|Pack Type                     |Platform|
|Time Aggregation              |Average|

### Compute Units - Microsoft.Network/applicationGateways

|Property | Value |
|---|---|
|Alert Type                    | Microsoft.Insights/metricAlerts |
|Alert Name                    |Compute Units - applicationGateways|
|Alert DisplayName             |Compute Units - Microsoft.Network/applicationGateways|
|Alert Description             |Compute Units consumed|
|Metric Namespace             |Microsoft.Network/applicationGateways|
|Severity                    |2|
|Metric Name                  |ComputeUnits|
|Operator                     |GreaterThan|
|Evaluation Frequency       |PT1M|
|Windows Size                |PT5M|
|Threshold                 |75|
|Auto Mitigate              |false|
|Initiative Member             |True|
|Pack Type                     |Platform|
|Time Aggregation              |Average|

### Cpu Utilization - Microsoft.Network/applicationGateways

|Property | Value |
|---|---|
|Alert Type                    | Microsoft.Insights/metricAlerts |
|Alert Name                    |Cpu Utilization - applicationGateways|
|Alert DisplayName             |Cpu Utilization - Microsoft.Network/applicationGateways|
|Alert Description             |Current CPU utilization of the Application Gateway|
|Metric Namespace             |Microsoft.Network/applicationGateways|
|Severity                    |2|
|Metric Name                  |CpuUtilization|
|Operator                     |GreaterThan|
|Evaluation Frequency       |PT1M|
|Windows Size                |PT5M|
|Threshold                 |80|
|Auto Mitigate              |false|
|Initiative Member             |True|
|Pack Type                     |Platform|
|Time Aggregation              |Average|

### Failed Requests - Microsoft.Network/applicationGateways

|Property | Value |
|---|---|
|Alert Type                    | Microsoft.Insights/metricAlerts |
|Alert Name                    |Failed Requests - applicationGateways|
|Alert DisplayName             |Failed Requests - Microsoft.Network/applicationGateways|
|Alert Description             |Count of failed requests that Application Gateway has served|
|Metric Namespace             |Microsoft.Network/applicationGateways|
|Severity                    |2|
|Metric Name                  |FailedRequests|
|Operator                     |GreaterThan|
|Evaluation Frequency       |PT1M|
|Windows Size                |PT5M|
|Threshold                 ||
|Auto Mitigate              |false|
|Initiative Member             |True|
|Pack Type                     |Platform|
|Time Aggregation              |Total|

### Response Status - Microsoft.Network/applicationGateways

|Property | Value |
|---|---|
|Alert Type                    | Microsoft.Insights/metricAlerts |
|Alert Name                    |Response Status - applicationGateways|
|Alert DisplayName             |Response Status - Microsoft.Network/applicationGateways|
|Alert Description             |Http response status returned by Application Gateway|
|Metric Namespace             |Microsoft.Network/applicationGateways|
|Severity                    |2|
|Metric Name                  |ResponseStatus|
|Operator                     |GreaterThan|
|Evaluation Frequency       |PT1M|
|Windows Size                |PT5M|
|Threshold                 ||
|Auto Mitigate              |false|
|Initiative Member             |True|
|Pack Type                     |Platform|
|Time Aggregation              |Total|

### Unhealthy Host Count - Microsoft.Network/applicationGateways

|Property | Value |
|---|---|
|Alert Type                    | Microsoft.Insights/metricAlerts |
|Alert Name                    |Unhealthy Host Count - applicationGateways|
|Alert DisplayName             |Unhealthy Host Count - Microsoft.Network/applicationGateways|
|Alert Description             |Number of unhealthy backend hosts|
|Metric Namespace             |Microsoft.Network/applicationGateways|
|Severity                    |2|
|Metric Name                  |UnhealthyHostCount|
|Operator                     |GreaterThan|
|Evaluation Frequency       |PT1M|
|Windows Size                |PT5M|
|Threshold                 |20|
|Auto Mitigate              |false|
|Initiative Member             |True|
|Pack Type                     |Platform|
|Time Aggregation              |Average|
