---
title: VMInsights
geekdocCollapseSection: true
weight: 50
---
[Alerts](#alerts)

## Alerts

|DisplayName|Type|Description|
|---|---|---|
|[DataDiskReadLatency(ms)](#data-disk-read-latency)|Log| Log Alert for Virtual Machine Data Disk Read Latency (ms)|
|[DataDiskFreeSpacePercentage](#data-disk-free-space-percentage)|Log| Log Alert for Virtual Machine Data Disk Free Space Percentage|
|[DataDiskWriteLatency(ms)](#data-disk-write-latency)|Log| Log Alert for Virtual Machine Data Disk Write Latency (ms)|
|[NetworkRead(bytes-sec)](#network-read-bytes-sec)|Log| Log Alert for Virtual Machine Network Read (bytes-sec)|
|[NetworkWrite(bytes-sec)](#network-write-bytes-sec)|Log| Log Alert for Virtual Machine Network Write (bytes-sec)|
|[OSDiskReadLatency(ms)](#os-disk-read-latency)|Log| Log Alert for Virtual Machine Data OS Read Latency (ms)|
|[OSDiskFreeSpacePercentage](#os-disk-free-space-percentage)|Log| Log Alert for Virtual Machine OS Disk Free Space Percentage|
|[OSDiskWriteLatency(ms)](#os-disk-write-latency)|Log| Log Alert for Virtual Machine OS Disk Write Latency (ms)|
|[ProcessorUtilizationPercentage](#processor-utilization-percentage)|Log| Log Alert for Virtual Machine Processor Utilization Percentage|
|[AvailableMemoryPercentage](#available-memory-percentage)|Log| Log Alert for Virtual Machine Available Memory Percentage|

### Data Disk Read Latency

|Property | Value |
|---|---|
|Severity|2|
|Enabled|True|
|AutoMitigate|True|
|EvaluationFrequency|PT5M|
|WindowSize|PT15M|
|Type|Aggregated|
|Query|    InsightsMetrics\| where Origin == "vm.azm.ms"\| where Namespace == "LogicalDisk" and Name == "ReadLatencyMs"\| extend Disk=tostring(todynamic(Tags)\\["vm.azm.ms/mountId"])\| where Disk !in ('C:','/')\| summarize AggregatedValue = avg(Val) by bin(TimeGenerated,15m), Computer, _ResourceId, Disk |
|Threshold|30|

### Data Disk Free Space Percentage

|Property | Value |
|---|---|
|Severity|2|
|Enabled|True|
|AutoMitigate|True|
|EvaluationFrequency|PT5M|
|WindowSize|PT15M|
|Type|Aggregated|
|Query|    InsightsMetrics\| where Origin == "vm.azm.ms"\| where Namespace == "LogicalDisk"and Name == "FreeSpacePercentage"\| extend Disk=tostring(todynamic(Tags)\["vm.azm.ms/mountId"])\| where Disk !in ('C:','/')\| summarize AggregatedValue = avg(Val) by bin(TimeGenerated,15m), Computer, _ResourceId, Disk|
|Threshold|10|

### Data Disk Write Latency

|Property | Value |
|---|---|
|Severity|2|
|Enabled|True|
|AutoMitigate|True|
|EvaluationFrequency|PT5M|
|WindowSize|PT15M|
|Type|Aggregated|
|Query|    InsightsMetrics\| where Origin == "vm.azm.ms"\| where Namespace == "LogicalDisk" and Name == "WriteLatencyMs"\| extend Disk=tostring(todynamic(Tags)\["vm.azm.ms/mountId"])\| where Disk !in ('C:','/')\| summarize AggregatedValue = avg(Val) by bin(TimeGenerated,15m), Computer, _ResourceId, Disk|
|Threshold|30|

### Network Read bytes-sec

|Property | Value |
|---|---|
|Severity|2|
|Enabled|True|
|AutoMitigate|True|
|EvaluationFrequency|PT5M|
|WindowSize|PT15M|
|Type|Aggregated|
|Query|    InsightsMetrics\| where Origin == "vm.azm.ms"\| where Namespace == "Network" and Name == "ReadBytesPerSecond"\| extend NetworkInterface=tostring(todynamic(Tags)\["vm.azm.ms/networkDeviceId"])\| summarize AggregatedValue = avg(Val) by bin(TimeGenerated, 15m), Computer, _ResourceId, NetworkInterface|
|Threshold|10000000|

### Network Write bytes-sec

|Property | Value |
|---|---|
|Severity|2|
|Enabled|True|
|AutoMitigate|True|
|EvaluationFrequency|PT5M|
|WindowSize|PT15M|
|Type|Aggregated|
|Query|    InsightsMetrics\| where Origin == "vm.azm.ms"\| where Namespace == "Network" and Name == "WriteBytesPerSecond"\| extend NetworkInterface=tostring(todynamic(Tags)\["vm.azm.ms/networkDeviceId"])\| summarize AggregatedValue = avg(Val) by bin(TimeGenerated, 15m), Computer, _ResourceId, NetworkInterface|
|Threshold|10000000|

### OS Disk Read Latency

|Property | Value |
|---|---|
|Severity|2|
|Enabled|True|
|AutoMitigate|True|
|EvaluationFrequency|PT5M|
|WindowSize|PT15M|
|Type|Aggregated|
|Query|    InsightsMetrics\| where Origin == "vm.azm.ms"\| where Namespace == "LogicalDisk" and Name == "ReadLatencyMs"\| extend Disk=tostring(todynamic(Tags)\["vm.azm.ms/mountId"])\| summarize AggregatedValue = avg(Val) by bin(TimeGenerated, 15m), Computer, _ResourceId, Disk|
|Threshold|30|

### OS Disk Free Space Percentage

|Property | Value |
|---|---|
|Severity|2|
|Enabled|True|
|AutoMitigate|True|
|EvaluationFrequency|PT5M|
|WindowSize|PT15M|
|Type|Aggregated|
|Query|    InsightsMetrics\| where Origin == "vm.azm.ms"\| where Namespace == "LogicalDisk" and Name == "FreeSpacePercentage"\| extend Disk=tostring(todynamic(Tags)\["vm.azm.ms/mountId"])\| summarize AggregatedValue = avg(Val) by bin(TimeGenerated, 15m), Computer, _ResourceId, Disk|
|Threshold|10|

### OS Disk Write Latency

|Property | Value |
|---|---|
|Severity|2|
|Enabled|True|
|AutoMitigate|True|
|EvaluationFrequency|PT5M|
|WindowSize|PT15M|
|Type|Aggregated|
|Query|    InsightsMetrics\| where Origin == "vm.azm.ms"\| where Namespace == "LogicalDisk" and Name == "WriteLatencyMs"\| extend Disk=tostring(todynamic(Tags)\["vm.azm.ms/mountId"])\| summarize AggregatedValue = avg(Val) by bin(TimeGenerated, 15m), Computer, _ResourceId, Disk|
|Threshold|50|

### Processor Utilization Percentage

|Property | Value |
|---|---|
|Severity|2|
|Enabled|True|
|AutoMitigate|True|
|EvaluationFrequency|PT5M|
|WindowSize|PT15M|
|Type|Aggregated|
|Query|    InsightsMetrics\| where Origin == "vm.azm.ms"\| where Namespace == "Processor" and Name == "UtilizationPercentage"\| summarize AggregatedValue = avg(Val) by bin(TimeGenerated, 15m), Computer, _ResourceId|
|Threshold|85|

### Available Memory Percentage

|Property | Value |
|---|---|
|Severity|2|
|Enabled|True|
|AutoMitigate|True|
|EvaluationFrequency|PT5M|
|WindowSize|PT15M|
|Type|Aggregated|
|Query|    InsightsMetrics\| where Origin == "vm.azm.ms"\| where Namespace == "Memory" and Name == "AvailableMB"\| extend TotalMemory = toreal(todynamic(Tags)\["vm.azm.ms/memorySizeMB"])\| extend AvailableMemoryPercentage = (toreal(Val) / TotalMemory) * 100.0\| summarize AggregatedValue = avg(AvailableMemoryPercentage) by bin(TimeGenerated, 15m), Computer, _ResourceId|
|Threshold|10|
