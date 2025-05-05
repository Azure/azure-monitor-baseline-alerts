---
title: Log-search alerts override tags table
geekdocHidden: true
---

| Resource Type | Alert Name | Alert Type | Override Tag name | Tag value type | Example |
| ------------- | ---------- | ---------- | ----------------- | -------------- | ------- |
| Machine - Azure Arc | *```subscription().displayName```*-HybridVMHighDataDiskReadLatencyAlert | Log search | ***\_amba-ReadLatencyMs-Data-threshold-Override\_*** | Number | 35 |
| Machine - Azure Arc | *```subscription().displayName```*-HybridVMLowDataDiskSpaceAlert | Log search | ***\_amba-FreeSpacePercentage-Data-threshold-Override\_*** | Number | 8 |
| Machine - Azure Arc | *```subscription().displayName```*-HybridVMHighDataDiskWriteLatencyAlert | Log search | ***\_amba-WriteLatencyMs-Data-threshold-Override\_*** | Number | 35 |
| Machine - Azure Arc | *```subscription().displayName```*-HybridVMDisconnectedAlert | Log search | ***\_amba-Disconnected-threshold-Override\_*** | [Timespan](https://learn.microsoft.com/en-us/kusto/query/scalar-data-types/timespan?view=microsoft-fabric) | 5m, 10d, 2h |
| Machine - Azure Arc | *```subscription().displayName```*-HybridVMHeartBeatAlert | Log search | ***\_amba-Heartbeat-threshold-Override\_*** | Number | 5 |
| Machine - Azure Arc | *```subscription().displayName```*-HybridVMHighNetworkInAlert | Log search | ***\_amba-ReadBytesPerSecond-threshold-Override\_*** | Number | 20000000 |
| Machine - Azure Arc | *```subscription().displayName```*-HybridVMHighNetworkOutAlert | Log search | ***\_amba-WriteBytesPerSecond-threshold-Override\_*** | Number | 20000000 |
| Machine - Azure Arc | *```subscription().displayName```*-HybridVMHighOSDiskReadLatencyAlert | Log search | ***\_amba-ReadLatencyMs-OS-threshold-Override\_*** | Number | 35 |
| Machine - Azure Arc | *```subscription().displayName```*-HybridVMLowOSDiskSpaceAlert | Log search | ***\_amba-FreeSpacePercentage-OS-threshold-Override\_*** | Number | 8 |
| Machine - Azure Arc | *```subscription().displayName```*-HybridVMHighOSDiskWriteLatencyAlert | Log search | ***\_amba-WriteLatencyMs-OS-threshold-Override\_*** | Number | 35 |
| Machine - Azure Arc | *```subscription().displayName```*-HybridVMHighCPUAlert | Log search | ***\_amba-UtilizationPercentage-threshold-Override\_*** | Number | 90 |
| Machine - Azure Arc | *```subscription().displayName```*-HybridVMLowMemoryAlert | Log search | ***\_amba-AvailableMemoryPercentage-threshold-Override\_*** | Number | 8 |
| Virtual machine | *```subscription().displayName```*-VMHighDataDiskReadLatencyAlert | Log search | ***\_amba-ReadLatencyMs-Data-threshold-Override\_*** | Number | 35 |
| Virtual machine | *```subscription().displayName```*-VMLowDataDiskSpaceAlert | Log search | ***\_amba-FreeSpacePercentage-Data-threshold-Override\_*** | Number | 8 |
| Virtual machine | *```subscription().displayName```*-VMHighDataDiskWriteLatencyAlert | Log search | ***\_amba-WriteLatencyMs-Data-threshold-Override\_*** | Number | 35 |
| Virtual machine | *```subscription().displayName```*-VMHeartBeatAlert | Log search | ***\_amba-Heartbeat-threshold-Override\_*** | Number | 5 |
| Virtual machine | *```subscription().displayName```*-VMHighNetworkInAlert | Log search | ***\_amba-ReadBytesPerSecond-threshold-Override\_*** | Number | 20000000 |
| Virtual machine | *```subscription().displayName```*-VMHighNetworkOutAlert | Log search | ***\_amba-WriteBytesPerSecond-threshold-Override\_*** | Number | 20000000 |
| Virtual machine | *```subscription().displayName```*-VMHighOSDiskReadLatencyAlert | Log search | ***\_amba-ReadLatencyMs-OS-threshold-Override\_*** | Number | 35 |
| Virtual machine | *```subscription().displayName```*-VMLowOSDiskSpaceAlert | Log search | ***\_amba-FreeSpacePercentage-OS-threshold-Override\_*** | Number | 8 |
| Virtual machine | *```subscription().displayName```*-VMHighOSDiskWriteLatencyAlert | Log search | ***\_amba-WriteLatencyMs-OS-threshold-Override\_*** | Number | 35 |
| Virtual machine | *```subscription().displayName```*-VMHighCPUAlert | Log search | ***\_amba-UtilizationPercentage-threshold-Override\_*** | Number | 90 |
| Virtual machine | *```subscription().displayName```*-VMLowMemoryAlert | Log search | ***\_amba-AvailableMemoryPercentage-threshold-Override\_*** | Number | 8 |
| Log Analytics workspace | *```resourceName```*-DailyCapLimitReachedAlert | Log search | <span style="color:DarkOrange">***Not available as threshold will always be 0***</span> | <span style="color:DarkOrange">***Not applicable***</span>| <span style="color:DarkOrange">***N/A***</span> |
| Application Insights | *```resourceName```*-ApplicationInsightsThrottlingLimitReachedAlert | Log search | ***\_amba-Throttling-threshold-override\_*** | Number | 64000 |
