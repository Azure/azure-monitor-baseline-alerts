---
title: LogicApps Monitoring Pack
geekdocCollapseSection: true
weight: 50
---
[Alerts](#alerts)

## Alerts

|DisplayName|Type|Description|
|---|---|---|
|[RunsFailed - Microsoft.Logic/workflows](#runsfailed---microsoftlogicworkflows)|Microsoft.Insights/metricAlerts|RunsFailed - workflows|
|[ActionsFailed - Microsoft.Logic/workflows](#actionsfailed---microsoftlogicworkflows)|Microsoft.Insights/metricAlerts|ActionsFailed - workflows|
|[TriggersFailed - Microsoft.Logic/workflows](#triggersfailed---microsoftlogicworkflows)|Microsoft.Insights/metricAlerts|TriggersFailed - workflows|
|[RunLatency - Microsoft.Logic/workflows](#runlatency---microsoftlogicworkflows)|Microsoft.Insights/metricAlerts|RunLatency - workflows|
|[RunFailurePercentage - Microsoft.Logic/workflows](#runfailurepercentage---microsoftlogicworkflows)|Microsoft.Insights/metricAlerts|RunFailurePercentage - workflows|
|[ActionLatency - Microsoft.Logic/workflows](#actionlatency---microsoftlogicworkflows)|Microsoft.Insights/metricAlerts|ActionLatency - workflows|
|[TriggerLatency - Microsoft.Logic/workflows](#triggerlatency---microsoftlogicworkflows)|Microsoft.Insights/metricAlerts|TriggerLatency - workflows|
|[TriggerThrottledEvents - Microsoft.Logic/workflows](#triggerthrottledevents---microsoftlogicworkflows)|Microsoft.Insights/metricAlerts|TriggerThrottledEvents - workflows|
|[ActionThrottledEvents - Microsoft.Logic/workflows](#actionthrottledevents---microsoftlogicworkflows)|Microsoft.Insights/metricAlerts|ActionThrottledEvents - workflows|
|[TriggersSkipped - Microsoft.Logic/workflows](#triggersskipped---microsoftlogicworkflows)|Microsoft.Insights/metricAlerts|TriggersSkipped - workflows|
|[RunStartThrottledEvents - Microsoft.Logic/workflows](#runstartthrottledevents---microsoftlogicworkflows)|Microsoft.Insights/metricAlerts|RunStartThrottledEvents - workflows|
|[RunThrottledEvents - Microsoft.Logic/workflows](#runthrottledevents---microsoftlogicworkflows)|Microsoft.Insights/metricAlerts|RunThrottledEvents - workflows|

### RunsFailed - Microsoft.Logic/workflows

|Property | Value |
|---|---|
|Alert Type                    | Microsoft.Insights/metricAlerts |
|Alert Name                    |RunsFailed - workflows|
|Alert DisplayName             |RunsFailed - Microsoft.Logic/workflows|
|Alert Description             |Number of workflow runs failed.|
|Metric Namespace             |Microsoft.Logic/workflows|
|Severity                    |3|
|Metric Name                  |RunsFailed|
|Operator                     |GreaterThan|
|Evaluation Frequency       |PT1M|
|Windows Size                |PT1M|
|Threshold                 |0|
|Auto Mitigate              |false|
|Initiative Member             |True|
|Pack Type                     |PaaS|
|Time Aggregation              |Total|

### ActionsFailed - Microsoft.Logic/workflows

|Property | Value |
|---|---|
|Alert Type                    | Microsoft.Insights/metricAlerts |
|Alert Name                    |ActionsFailed - workflows|
|Alert DisplayName             |ActionsFailed - Microsoft.Logic/workflows|
|Alert Description             |Number of workflow actions failed.|
|Metric Namespace             |Microsoft.Logic/workflows|
|Severity                    |3|
|Metric Name                  |ActionsFailed|
|Operator                     |GreaterThan|
|Evaluation Frequency       |PT1M|
|Windows Size                |PT5M|
|Threshold                 |0|
|Auto Mitigate              |false|
|Initiative Member             |True|
|Pack Type                     |PaaS|
|Time Aggregation              |Total|

### TriggersFailed - Microsoft.Logic/workflows

|Property | Value |
|---|---|
|Alert Type                    | Microsoft.Insights/metricAlerts |
|Alert Name                    |TriggersFailed - workflows|
|Alert DisplayName             |TriggersFailed - Microsoft.Logic/workflows|
|Alert Description             |Number of workflow triggers failed.|
|Metric Namespace             |Microsoft.Logic/workflows|
|Severity                    |3|
|Metric Name                  |TriggersFailed|
|Operator                     |GreaterThan|
|Evaluation Frequency       |PT1M|
|Windows Size                |PT5M|
|Threshold                 |0|
|Auto Mitigate              |false|
|Initiative Member             |True|
|Pack Type                     |PaaS|
|Time Aggregation              |Total|

### RunLatency - Microsoft.Logic/workflows

|Property | Value |
|---|---|
|Alert Type                    | Microsoft.Insights/metricAlerts |
|Alert Name                    |RunLatency - workflows|
|Alert DisplayName             |RunLatency - Microsoft.Logic/workflows|
|Alert Description             |Latency of completed workflow runs.|
|Metric Namespace             |Microsoft.Logic/workflows|
|Severity                    |3|
|Metric Name                  |RunLatency|
|Operator                     |GreaterThan|
|Evaluation Frequency       |PT1M|
|Windows Size                |PT5M|
|Threshold                 |99999|
|Auto Mitigate              |false|
|Initiative Member             |True|
|Pack Type                     |PaaS|
|Time Aggregation              |Average|

### RunFailurePercentage - Microsoft.Logic/workflows

|Property | Value |
|---|---|
|Alert Type                    | Microsoft.Insights/metricAlerts |
|Alert Name                    |RunFailurePercentage - workflows|
|Alert DisplayName             |RunFailurePercentage - Microsoft.Logic/workflows|
|Alert Description             |Percentage of workflow runs failed.|
|Metric Namespace             |Microsoft.Logic/workflows|
|Severity                    |2|
|Metric Name                  |RunFailurePercentage|
|Operator                     |GreaterThan|
|Evaluation Frequency       |PT15M|
|Windows Size                |PT1H|
|Threshold                 |50|
|Auto Mitigate              |false|
|Initiative Member             |True|
|Pack Type                     |PaaS|
|Time Aggregation              |Total|

### ActionLatency - Microsoft.Logic/workflows

|Property | Value |
|---|---|
|Alert Type                    | Microsoft.Insights/metricAlerts |
|Alert Name                    |ActionLatency - workflows|
|Alert DisplayName             |ActionLatency - Microsoft.Logic/workflows|
|Alert Description             |Latency of completed workflow actions.|
|Metric Namespace             |Microsoft.Logic/workflows|
|Severity                    |3|
|Metric Name                  |ActionLatency|
|Operator                     |GreaterThan|
|Evaluation Frequency       |PT1M|
|Windows Size                |PT1M|
|Threshold                 |15|
|Auto Mitigate              |false|
|Initiative Member             |True|
|Pack Type                     |PaaS|
|Time Aggregation              |Average|

### TriggerLatency - Microsoft.Logic/workflows

|Property | Value |
|---|---|
|Alert Type                    | Microsoft.Insights/metricAlerts |
|Alert Name                    |TriggerLatency - workflows|
|Alert DisplayName             |TriggerLatency - Microsoft.Logic/workflows|
|Alert Description             |Latency of completed workflow triggers.|
|Metric Namespace             |Microsoft.Logic/workflows|
|Severity                    |3|
|Metric Name                  |TriggerLatency|
|Operator                     |GreaterThan|
|Evaluation Frequency       |PT1M|
|Windows Size                |PT1M|
|Threshold                 |15|
|Auto Mitigate              |false|
|Initiative Member             |True|
|Pack Type                     |PaaS|
|Time Aggregation              |Average|

### TriggerThrottledEvents - Microsoft.Logic/workflows

|Property | Value |
|---|---|
|Alert Type                    | Microsoft.Insights/metricAlerts |
|Alert Name                    |TriggerThrottledEvents - workflows|
|Alert DisplayName             |TriggerThrottledEvents - Microsoft.Logic/workflows|
|Alert Description             |Number of workflow trigger throttled events.|
|Metric Namespace             |Microsoft.Logic/workflows|
|Severity                    |3|
|Metric Name                  |TriggerThrottledEvents|
|Operator                     |GreaterThan|
|Evaluation Frequency       |PT1M|
|Windows Size                |PT1M|
|Threshold                 |0|
|Auto Mitigate              |false|
|Initiative Member             |True|
|Pack Type                     |PaaS|
|Time Aggregation              |Total|

### ActionThrottledEvents - Microsoft.Logic/workflows

|Property | Value |
|---|---|
|Alert Type                    | Microsoft.Insights/metricAlerts |
|Alert Name                    |ActionThrottledEvents - workflows|
|Alert DisplayName             |ActionThrottledEvents - Microsoft.Logic/workflows|
|Alert Description             |Number of workflow action throttled events..|
|Metric Namespace             |Microsoft.Logic/workflows|
|Severity                    |3|
|Metric Name                  |ActionThrottledEvents|
|Operator                     |GreaterThan|
|Evaluation Frequency       |PT1M|
|Windows Size                |PT1M|
|Threshold                 |0|
|Auto Mitigate              |false|
|Initiative Member             |True|
|Pack Type                     |PaaS|
|Time Aggregation              |Total|

### TriggersSkipped - Microsoft.Logic/workflows

|Property | Value |
|---|---|
|Alert Type                    | Microsoft.Insights/metricAlerts |
|Alert Name                    |TriggersSkipped - workflows|
|Alert DisplayName             |TriggersSkipped - Microsoft.Logic/workflows|
|Alert Description             |Number of workflow triggers skipped.|
|Metric Namespace             |Microsoft.Logic/workflows|
|Severity                    |2|
|Metric Name                  |TriggersSkipped|
|Operator                     |GreaterThanOrEqual|
|Evaluation Frequency       |PT1H|
|Windows Size                |PT1H|
|Threshold                 |5|
|Auto Mitigate              |false|
|Initiative Member             |True|
|Pack Type                     |PaaS|
|Time Aggregation              |Count|

### RunStartThrottledEvents - Microsoft.Logic/workflows

|Property | Value |
|---|---|
|Alert Type                    | Microsoft.Insights/metricAlerts |
|Alert Name                    |RunStartThrottledEvents - workflows|
|Alert DisplayName             |RunStartThrottledEvents - Microsoft.Logic/workflows|
|Alert Description             |Number of workflow run start throttled events.|
|Metric Namespace             |Microsoft.Logic/workflows|
|Severity                    |3|
|Metric Name                  |RunStartThrottledEvents|
|Operator                     |GreaterThan|
|Evaluation Frequency       |PT1M|
|Windows Size                |PT1M|
|Threshold                 |0|
|Auto Mitigate              |false|
|Initiative Member             |True|
|Pack Type                     |PaaS|
|Time Aggregation              |Total|

### RunThrottledEvents - Microsoft.Logic/workflows

|Property | Value |
|---|---|
|Alert Type                    | Microsoft.Insights/metricAlerts |
|Alert Name                    |RunThrottledEvents - workflows|
|Alert DisplayName             |RunThrottledEvents - Microsoft.Logic/workflows|
|Alert Description             |Number of workflow action or trigger throttled events.|
|Metric Namespace             |Microsoft.Logic/workflows|
|Severity                    |3|
|Metric Name                  |RunThrottledEvents|
|Operator                     |GreaterThan|
|Evaluation Frequency       |PT5M|
|Windows Size                |PT5M|
|Threshold                 |1|
|Auto Mitigate              |false|
|Initiative Member             |True|
|Pack Type                     |PaaS|
|Time Aggregation              |Total|
