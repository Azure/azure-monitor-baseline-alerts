---
title: WebApp Monitoring Pack
geekdocCollapseSection: true
weight: 50
---
[Alerts](#alerts)

## Alerts

|DisplayName|Type|Description|
|---|---|---|
|[AverageResponseTime - Microsoft.Web-sites](#averageresponsetime---microsoftweb-sites)|Microsoft.Insights/metricAlerts|AverageResponseTime - Microsoft.Web-sites|
|[CpuTime - Microsoft.Web-sites](#cputime---microsoftweb-sites)|Microsoft.Insights/metricAlerts|CpuTime - Microsoft.Web-sites|
|[PrivateBytes - Microsoft.Web-sites](#privatebytes---microsoftweb-sites)|Microsoft.Insights/metricAlerts|PrivateBytes - Microsoft.Web-sites|
|[RequestsInApplicationQueue - Microsoft.Web-sites](#requestsinapplicationqueue---microsoftweb-sites)|Microsoft.Insights/metricAlerts|RequestsInApplicationQueue - Microsoft.Web-sites|
|[Connections - Microsoft.Web-sites](#connections---microsoftweb-sites)|Microsoft.Insights/metricAlerts|Connections - Microsoft.Web-sites|
|[Http401 - Microsoft.Web-sites](#http401---microsoftweb-sites)|Microsoft.Insights/metricAlerts|Http401 - Microsoft.Web-sites|
|[Http404 - Microsoft.Web-sites](#http404---microsoftweb-sites)|Microsoft.Insights/metricAlerts|Http404 - Microsoft.Web-sites|
|[FileSystemUsage - Microsoft.Web-sites](#filesystemusage---microsoftweb-sites)|Microsoft.Insights/metricAlerts|FileSystemUsage - Microsoft.Web-sites|
|[MemoryWorkingSet - Microsoft.Web-sites](#memoryworkingset---microsoftweb-sites)|Microsoft.Insights/metricAlerts|MemoryWorkingSet - Microsoft.Web-sites|
|[FunctionExecutionCount - Microsoft.Web-sites](#functionexecutioncount---microsoftweb-sites)|Microsoft.Insights/metricAlerts|FunctionExecutionCount - Microsoft.Web-sites|
|[Thread Count - Microsoft.Web-sites](#thread-count---microsoftweb-sites)|Microsoft.Insights/metricAlerts|Thread Count - Microsoft.Web-sites|
|[Data Out](#data-out)|Microsoft.Insights/metricAlerts|Data Out|
|[Http406 - Microsoft.Web-sites](#http406---microsoftweb-sites)|Microsoft.Insights/metricAlerts|Http406 - Microsoft.Web-sites|
|[Data In - Microsoft.Web-sites](#data-in---microsoftweb-sites)|Microsoft.Insights/metricAlerts|Data In - Microsoft.Web-sites|
|[Http3xx - Microsoft.Web-sites](#http3xx---microsoftweb-sites)|Microsoft.Insights/metricAlerts|Http3xx - Microsoft.Web-sites|
|[Handle Count](#handle-count)|Microsoft.Insights/metricAlerts|Handle Count|
|[FunctionExecutionUnits - Microsoft.Web-sites](#functionexecutionunits---microsoftweb-sites)|Microsoft.Insights/metricAlerts|FunctionExecutionUnits - Microsoft.Web-sites|
|[Http2xx - Microsoft.Web-sites](#http2xx---microsoftweb-sites)|Microsoft.Insights/metricAlerts|Http2xx - Microsoft.Web-sites|
|[WorkflowRunsFailureRate - Microsoft.Web-sites](#workflowrunsfailurerate---microsoftweb-sites)|Microsoft.Insights/metricAlerts|WorkflowRunsFailureRate - Microsoft.Web-sites|
|[Gen2GarbageCollections](#gen2garbagecollections)|Microsoft.Insights/metricAlerts|Gen2GarbageCollections|
|[Gen0GarbageCollections](#gen0garbagecollections)|Microsoft.Insights/metricAlerts|Gen0GarbageCollections|
|[Gen1GarbageCollections](#gen1garbagecollections)|Microsoft.Insights/metricAlerts|Gen1GarbageCollections|

### AverageResponseTime - Microsoft.Web-sites

|Property | Value |
|---|---|
|Alert Type                    | Microsoft.Insights/metricAlerts |
|Alert Name                    |AverageResponseTime - Microsoft.Web-sites|
|Alert DisplayName             |AverageResponseTime - Microsoft.Web-sites|
|Alert Description             |The average time taken for the app to serve requests, in seconds. For WebApps and FunctionApps.|
|Metric Namespace             |Microsoft.Web/sites|
|Severity                    |2|
|Metric Name                  |AverageResponseTime|
|Operator                     |GreaterThan|
|Evaluation Frequency       |PT15M|
|Windows Size                |PT15M|
|Threshold                 |30|
|Auto Mitigate              |false|
|Initiative Member             |True|
|Pack Type                     |PaaS|
|Time Aggregation              |Average|

### CpuTime - Microsoft.Web-sites

|Property | Value |
|---|---|
|Alert Type                    | Microsoft.Insights/metricAlerts |
|Alert Name                    |CpuTime - Microsoft.Web-sites|
|Alert DisplayName             |CpuTime - Microsoft.Web-sites|
|Alert Description             |The amount of CPU consumed by the app, in seconds. For more information about this metric. Please see 'aka.ms/website-monitor-cpu-time-vs-cpu-percentage' (CPU time vs CPU percentage). For WebApps only.|
|Metric Namespace             |Microsoft.Web/sites|
|Severity                    |3|
|Metric Name                  |CpuTime|
|Operator                     |GreaterThan|
|Evaluation Frequency       |PT1M|
|Windows Size                |PT5M|
|Threshold                 |120|
|Auto Mitigate              |false|
|Initiative Member             |True|
|Pack Type                     |PaaS|
|Time Aggregation              |Total|

### PrivateBytes - Microsoft.Web-sites

|Property | Value |
|---|---|
|Alert Type                    | Microsoft.Insights/metricAlerts |
|Alert Name                    |PrivateBytes - Microsoft.Web-sites|
|Alert DisplayName             |PrivateBytes - Microsoft.Web-sites|
|Alert Description             |Private Bytes is the current size, in bytes, of memory that the app process has allocated that can`t be shared with other processes. For WebApps and FunctionApps.|
|Metric Namespace             |Microsoft.Web/sites|
|Severity                    |3|
|Metric Name                  |PrivateBytes|
|Operator                     |GreaterThan|
|Evaluation Frequency       |PT1M|
|Windows Size                |PT5M|
|Threshold                 |1200000000|
|Auto Mitigate              |false|
|Initiative Member             |True|
|Pack Type                     |PaaS|
|Time Aggregation              |Average|

### RequestsInApplicationQueue - Microsoft.Web-sites

|Property | Value |
|---|---|
|Alert Type                    | Microsoft.Insights/metricAlerts |
|Alert Name                    |RequestsInApplicationQueue - Microsoft.Web-sites|
|Alert DisplayName             |RequestsInApplicationQueue - Microsoft.Web-sites|
|Alert Description             |The number of requests in the application request queue. For WebApps and FunctionApps.|
|Metric Namespace             |Microsoft.Web/sites|
|Severity                    |3|
|Metric Name                  |RequestsInApplicationQueue|
|Operator                     |GreaterThan|
|Evaluation Frequency       |PT5M|
|Windows Size                |PT15M|
|Threshold                 |10|
|Auto Mitigate              |false|
|Initiative Member             |True|
|Pack Type                     |PaaS|
|Time Aggregation              |Maximum|

### Connections - Microsoft.Web-sites

|Property | Value |
|---|---|
|Alert Type                    | Microsoft.Insights/metricAlerts |
|Alert Name                    |Connections - Microsoft.Web-sites|
|Alert DisplayName             |Connections - Microsoft.Web-sites|
|Alert Description             |The number of bound sockets existing in the sandbox (w3wp.exe and its child processes). A bound socket is created by calling bind()/connect() APIs and remains until said socket is closed with CloseHandle()/closesocket(). For WebApps and FunctionApps.|
|Metric Namespace             |Microsoft.Web/sites|
|Severity                    |3|
|Metric Name                  |AppConnections|
|Operator                     |GreaterThan|
|Evaluation Frequency       |PT5M|
|Windows Size                |PT15M|
|Threshold                 |6000|
|Auto Mitigate              |false|
|Initiative Member             |True|
|Pack Type                     |PaaS|
|Time Aggregation              |Maximum|

### Http401 - Microsoft.Web-sites

|Property | Value |
|---|---|
|Alert Type                    | Microsoft.Insights/metricAlerts |
|Alert Name                    |Http401 - Microsoft.Web-sites|
|Alert DisplayName             |Http401 - Microsoft.Web-sites|
|Alert Description             |The count of requests resulting in HTTP 401 status code. For WebApps and FunctionApps.|
|Metric Namespace             |Microsoft.Web/sites|
|Severity                    |2|
|Metric Name                  |Http401|
|Operator                     |GreaterThan|
|Evaluation Frequency       |PT5M|
|Windows Size                |PT5M|
|Threshold                 |20|
|Auto Mitigate              |false|
|Initiative Member             |True|
|Pack Type                     |PaaS|
|Time Aggregation              |Total|

### Http404 - Microsoft.Web-sites

|Property | Value |
|---|---|
|Alert Type                    | Microsoft.Insights/metricAlerts |
|Alert Name                    |Http404 - Microsoft.Web-sites|
|Alert DisplayName             |Http404 - Microsoft.Web-sites|
|Alert Description             |The count of requests resulting in HTTP 404 status code. For WebApps and FunctionApps.|
|Metric Namespace             |Microsoft.Web/sites|
|Severity                    |3|
|Metric Name                  |Http404|
|Operator                     |GreaterThan|
|Evaluation Frequency       |PT5M|
|Windows Size                |PT15M|
|Threshold                 |10|
|Auto Mitigate              |false|
|Initiative Member             |True|
|Pack Type                     |PaaS|
|Time Aggregation              |Total|

### FileSystemUsage - Microsoft.Web-sites

|Property | Value |
|---|---|
|Alert Type                    | Microsoft.Insights/metricAlerts |
|Alert Name                    |FileSystemUsage - Microsoft.Web-sites|
|Alert DisplayName             |FileSystemUsage - Microsoft.Web-sites|
|Alert Description             |Percentage of filesystem quota consumed by the app. For WebApps and FunctionApps.|
|Metric Namespace             |Microsoft.Web/sites|
|Severity                    |2|
|Metric Name                  |FileSystemUsage|
|Operator                     |GreaterThan|
|Evaluation Frequency       |PT1H|
|Windows Size                |PT6H|
|Threshold                 |400000000|
|Auto Mitigate              |false|
|Initiative Member             |True|
|Pack Type                     |PaaS|
|Time Aggregation              |Average|

### MemoryWorkingSet - Microsoft.Web-sites

|Property | Value |
|---|---|
|Alert Type                    | Microsoft.Insights/metricAlerts |
|Alert Name                    |MemoryWorkingSet - Microsoft.Web-sites|
|Alert DisplayName             |MemoryWorkingSet - Microsoft.Web-sites|
|Alert Description             |The current amount of memory used by the app, in MiB. For WebApps and FunctionApps.|
|Metric Namespace             |Microsoft.Web/sites|
|Severity                    |3|
|Metric Name                  |MemoryWorkingSet|
|Operator                     |GreaterThan|
|Evaluation Frequency       |PT1M|
|Windows Size                |PT5M|
|Threshold                 |1500000000|
|Auto Mitigate              |false|
|Initiative Member             |True|
|Pack Type                     |PaaS|
|Time Aggregation              |Average|

### FunctionExecutionCount - Microsoft.Web-sites

|Property | Value |
|---|---|
|Alert Type                    | Microsoft.Insights/metricAlerts |
|Alert Name                    |FunctionExecutionCount - Microsoft.Web-sites|
|Alert DisplayName             |FunctionExecutionCount - Microsoft.Web-sites|
|Alert Description             |Function Execution Count. For FunctionApps only.|
|Metric Namespace             |Microsoft.Web/sites|
|Severity                    |1|
|Metric Name                  |FunctionExecutionCount|
|Operator                     |LessThanOrEqual|
|Evaluation Frequency       |PT5M|
|Windows Size                |PT5M|
|Threshold                 |0|
|Auto Mitigate              |false|
|Initiative Member             |True|
|Pack Type                     |PaaS|
|Time Aggregation              |Total|

### Thread Count - Microsoft.Web-sites

|Property | Value |
|---|---|
|Alert Type                    | Microsoft.Insights/metricAlerts |
|Alert Name                    |Thread Count - Microsoft.Web-sites|
|Alert DisplayName             |Thread Count - Microsoft.Web-sites|
|Alert Description             |The number of threads currently active in the app process. For WebApps and FunctionApps.|
|Metric Namespace             |Microsoft.Web/sites|
|Severity                    |2|
|Metric Name                  |Threads|
|Operator                     |GreaterThan|
|Evaluation Frequency       |PT1M|
|Windows Size                |PT5M|
|Threshold                 |100|
|Auto Mitigate              |false|
|Initiative Member             |True|
|Pack Type                     |PaaS|
|Time Aggregation              |Average|

### Data Out

|Property | Value |
|---|---|
|Alert Type                    | Microsoft.Insights/metricAlerts |
|Alert Name                    |Data Out|
|Alert DisplayName             |Data Out|
|Alert Description             |The amount of outgoing bandwidth consumed by the app, in MiB. For WebApps and FunctionApps.|
|Metric Namespace             |Microsoft.Web/sites|
|Severity                    |3|
|Metric Name                  |BytesSent|
|Operator                     |GreaterOrLessThan|
|Evaluation Frequency       |PT1M|
|Windows Size                |PT5M|
|Threshold                 ||
|Auto Mitigate              |false|
|Initiative Member             |True|
|Pack Type                     |PaaS|
|Time Aggregation              |Average|

### Http406 - Microsoft.Web-sites

|Property | Value |
|---|---|
|Alert Type                    | Microsoft.Insights/metricAlerts |
|Alert Name                    |Http406 - Microsoft.Web-sites|
|Alert DisplayName             |Http406 - Microsoft.Web-sites|
|Alert Description             |The count of requests resulting in HTTP 406 status code. For WebApps and FunctionApps.|
|Metric Namespace             |Microsoft.Web/sites|
|Severity                    |1|
|Metric Name                  |Http406|
|Operator                     |GreaterThan|
|Evaluation Frequency       |PT15M|
|Windows Size                |PT15M|
|Threshold                 |1|
|Auto Mitigate              |false|
|Initiative Member             |True|
|Pack Type                     |PaaS|
|Time Aggregation              |Total|

### Data In - Microsoft.Web-sites

|Property | Value |
|---|---|
|Alert Type                    | Microsoft.Insights/metricAlerts |
|Alert Name                    |Data In - Microsoft.Web-sites|
|Alert DisplayName             |Data In - Microsoft.Web-sites|
|Alert Description             |The amount of incoming bandwidth consumed by the app, in MiB. For WebApps and FunctionApps.|
|Metric Namespace             |Microsoft.Web/sites|
|Severity                    |3|
|Metric Name                  |BytesReceived|
|Operator                     |GreaterThan|
|Evaluation Frequency       |PT5M|
|Windows Size                |PT5M|
|Threshold                 |2048000000|
|Auto Mitigate              |false|
|Initiative Member             |True|
|Pack Type                     |PaaS|
|Time Aggregation              |Total|

### Http3xx - Microsoft.Web-sites

|Property | Value |
|---|---|
|Alert Type                    | Microsoft.Insights/metricAlerts |
|Alert Name                    |Http3xx - Microsoft.Web-sites|
|Alert DisplayName             |Http3xx - Microsoft.Web-sites|
|Alert Description             |The count of requests resulting in an HTTP status code >= 300 but < 400. For WebApps and FunctionApps.|
|Metric Namespace             |Microsoft.Web/sites|
|Severity                    |3|
|Metric Name                  |Http3xx|
|Operator                     |GreaterThan|
|Evaluation Frequency       |PT5M|
|Windows Size                |PT5M|
|Threshold                 |15|
|Auto Mitigate              |false|
|Initiative Member             |True|
|Pack Type                     |PaaS|
|Time Aggregation              |Total|

### Handle Count

|Property | Value |
|---|---|
|Alert Type                    | Microsoft.Insights/metricAlerts |
|Alert Name                    |Handle Count|
|Alert DisplayName             |Handle Count|
|Alert Description             |The total number of handles currently open by the app process. For WebApps and FunctionApps.|
|Metric Namespace             |Microsoft.Web/sites|
|Severity                    |2|
|Metric Name                  |Handles|
|Operator                     |GreaterOrLessThan|
|Evaluation Frequency       |PT1M|
|Windows Size                |PT5M|
|Threshold                 ||
|Auto Mitigate              |false|
|Initiative Member             |True|
|Pack Type                     |PaaS|
|Time Aggregation              |Average|

### FunctionExecutionUnits - Microsoft.Web-sites

|Property | Value |
|---|---|
|Alert Type                    | Microsoft.Insights/metricAlerts |
|Alert Name                    |FunctionExecutionUnits - Microsoft.Web-sites|
|Alert DisplayName             |FunctionExecutionUnits - Microsoft.Web-sites|
|Alert Description             |Function Execution Units. For FunctionApps only.|
|Metric Namespace             |Microsoft.Web/sites|
|Severity                    |3|
|Metric Name                  |FunctionExecutionUnits|
|Operator                     |GreaterThan|
|Evaluation Frequency       |PT1M|
|Windows Size                |PT5M|
|Threshold                 |13000000000|
|Auto Mitigate              |false|
|Initiative Member             |True|
|Pack Type                     |PaaS|
|Time Aggregation              |Total|

### Http2xx - Microsoft.Web-sites

|Property | Value |
|---|---|
|Alert Type                    | Microsoft.Insights/metricAlerts |
|Alert Name                    |Http2xx - Microsoft.Web-sites|
|Alert DisplayName             |Http2xx - Microsoft.Web-sites|
|Alert Description             |The count of requests resulting in an HTTP status code >= 200 but < 300. For WebApps and FunctionApps.|
|Metric Namespace             |Microsoft.Web/sites|
|Severity                    |3|
|Metric Name                  |Http2xx|
|Operator                     |GreaterThan|
|Evaluation Frequency       |PT5M|
|Windows Size                |PT5M|
|Threshold                 |15|
|Auto Mitigate              |false|
|Initiative Member             |True|
|Pack Type                     |PaaS|
|Time Aggregation              |Total|

### WorkflowRunsFailureRate - Microsoft.Web-sites

|Property | Value |
|---|---|
|Alert Type                    | Microsoft.Insights/metricAlerts |
|Alert Name                    |WorkflowRunsFailureRate - Microsoft.Web-sites|
|Alert DisplayName             |WorkflowRunsFailureRate - Microsoft.Web-sites|
|Alert Description             |Workflow Runs Failure Rate. For LogicApps only.|
|Metric Namespace             |Microsoft.Web/sites|
|Severity                    |1|
|Metric Name                  |WorkflowRunsFailureRate|
|Operator                     |GreaterThan|
|Evaluation Frequency       |PT5M|
|Windows Size                |PT5M|
|Threshold                 |0|
|Auto Mitigate              |false|
|Initiative Member             |True|
|Pack Type                     |PaaS|
|Time Aggregation              |Total|

### Gen2GarbageCollections

|Property | Value |
|---|---|
|Alert Type                    | Microsoft.Insights/metricAlerts |
|Alert Name                    |Gen2GarbageCollections|
|Alert DisplayName             |Gen2GarbageCollections|
|Alert Description             |The number of times the generation 2 objects are garbage collected since the start of the app process. For WebApps and FunctionApps.|
|Metric Namespace             |Microsoft.Web/sites|
|Severity                    |2|
|Metric Name                  |Gen2Collections|
|Operator                     |GreaterThan|
|Evaluation Frequency       |PT5M|
|Windows Size                |PT5M|
|Threshold                 ||
|Auto Mitigate              |false|
|Initiative Member             |True|
|Pack Type                     |PaaS|
|Time Aggregation              |Average|

### Gen0GarbageCollections

|Property | Value |
|---|---|
|Alert Type                    | Microsoft.Insights/metricAlerts |
|Alert Name                    |Gen0GarbageCollections|
|Alert DisplayName             |Gen0GarbageCollections|
|Alert Description             |The number of times the generation 0 objects are garbage collected since the start of the app process. Higher generation GCs include all lower generation GCs. For WebApps and FunctionApps.|
|Metric Namespace             |Microsoft.Web/sites|
|Severity                    |2|
|Metric Name                  |Gen0Collections|
|Operator                     |GreaterThan|
|Evaluation Frequency       |PT5M|
|Windows Size                |PT5M|
|Threshold                 ||
|Auto Mitigate              |false|
|Initiative Member             |True|
|Pack Type                     |PaaS|
|Time Aggregation              |Average|

### Gen1GarbageCollections

|Property | Value |
|---|---|
|Alert Type                    | Microsoft.Insights/metricAlerts |
|Alert Name                    |Gen1GarbageCollections|
|Alert DisplayName             |Gen1GarbageCollections|
|Alert Description             |The number of times the generation 1 objects are garbage collected since the start of the app process. Higher generation GCs include all lower generation GCs. For WebApps and FunctionApps.|
|Metric Namespace             |Microsoft.Web/sites|
|Severity                    |2|
|Metric Name                  |Gen1Collections|
|Operator                     |GreaterThan|
|Evaluation Frequency       |PT5M|
|Windows Size                |PT5M|
|Threshold                 ||
|Auto Mitigate              |false|
|Initiative Member             |True|
|Pack Type                     |PaaS|
|Time Aggregation              |Average|
