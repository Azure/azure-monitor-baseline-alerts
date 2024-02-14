---
title: VMInsights
geekdocCollapseSection: true
weight: 50
---
[Alerts](#alerts)

## Alerts
|DisplayName||Type|Description|
|---|---|---|---|
|[MemoveryOverPercentWarning](#memory-over-90%)|Log| Alert for Memory over 90%|
|[DiskSpaceUnderPercentWarning](#disk-space-under-10%)|Log| Alert for disk space under 10%|
|[DiskSpaceUnderPercentCritical](#disk-space-under-5%)|Log| Alert for disk space under 5%|
|[HeartbeatAlert](#heartbeat-alert-for-vms)|Log| Heartbeat alert for VMs - 5 minutes|
|[CPUUsageOverPercentWarning](#cpu-usage-over-90%)|Log| Alert for CPU usage over 90%|
|[CPUUsageOverPercentcritical](#cpu-usage-over-95%)|Log| Alert for CPU usage over 95%|
### Memory over 90%

|Property | Value |
|---|---|
|Severity|2|
|Enabled|True|
|AutoMitigate|True|
|EvaluationFrequency|PT15M|
|WindowSize|PT15M|
|Type|Aggregated|
|Query|InsightsMetrics \| where Namespace == "Memory" and Name == "AvailableMB" \| extend memorySizeMB = todouble(parse_json(Tags).["vm.azm.ms/memorySizeMB"]) \| extend PercentageBytesinUse = Val/memorySizeMB*100    \| summarize AvgMemUse = avg(PercentageBytesinUse) by bin(TimeGenerated, 15m), _ResourceId,Computer|
|Threshold|90|
### Disk space under 10%

|Property | Value |
|---|---|
|Severity|2|
|Enabled|True|
|AutoMitigate|True|
|EvaluationFrequency|PT15M|
|WindowSize|PT15M|
|Type|rows|
|Query|InsightsMetrics
\| where Namespace == 'LogicalDisk'
    and Name == 'FreeSpacePercentage'
    and Origin == "vm.azm.ms"
\| extend Disk=tostring(todynamic(Tags)["vm.azm.ms/mountId"])
\| where Val < 10 //would use a low value...
\| summarize by _ResourceId,Computer, Disk, Val
\| where Disk notcontains "snap"

|
|Threshold|N/A|
### Disk space under 5%

|Property | Value |
|---|---|
|Severity|1|
|Enabled|True|
|AutoMitigate|True|
|EvaluationFrequency|PT15M|
|WindowSize|PT15M|
|Type|rows|
|Query|InsightsMetrics
\| where Namespace == 'LogicalDisk'
    and Name == 'FreeSpacePercentage'
    and Origin == "vm.azm.ms"
\| extend Disk=tostring(todynamic(Tags)["vm.azm.ms/mountId"])
\| where Val < 5 //would use a low value...
\| summarize by _ResourceId,Computer, Disk, Val
\| where Disk notcontains "snap"

|
|Threshold|N/A|
### Heartbeat alert for VMs

|Property | Value |
|---|---|
|Severity|2|
|Enabled|True|
|AutoMitigate|True|
|EvaluationFrequency|PT5M|
|WindowSize|PT5M|
|Type|rows|
|Query|InsightsMetrics\| where Namespace == 'Computer' and Name == 'Heartbeat'\| summarize arg_max(TimeGenerated, *) by _ResourceId, Computer\| where TimeGenerated < ago(5m)|
|Threshold|N/A|
### CPU usage over 90%

|Property | Value |
|---|---|
|Severity|2|
|Enabled|True|
|AutoMitigate|True|
|EvaluationFrequency|PT15M|
|WindowSize|PT15M|
|Type|rows|
|Query|InsightsMetrics
\| where Namespace == 'Processor'
    and Name == 'UtilizationPercentage'
    and Origin == "vm.azm.ms"
\| extend Computer=tostring(todynamic(Tags)["vm.azm.ms/computer"])
\| where Val > 90 //would use a low value...
\| summarize by _ResourceId,Computer, Val

|
|Threshold|N/A|
### CPU usage over 95%

|Property | Value |
|---|---|
|Severity|1|
|Enabled|True|
|AutoMitigate|True|
|EvaluationFrequency|PT15M|
|WindowSize|PT15M|
|Type|rows|
|Query|InsightsMetrics
\| where Namespace == 'Processor'
    and Name == 'UtilizationPercentage'
    and Origin == "vm.azm.ms"
\| extend Computer=tostring(todynamic(Tags)["vm.azm.ms/computer"])
\| where Val > 95 //would use a low value...
\| summarize by _ResourceId,Computer, Val

|
|Threshold|N/A|
