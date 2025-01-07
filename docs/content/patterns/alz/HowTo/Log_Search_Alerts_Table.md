---
title: Log-search alerts table
geekdocHidden: true
---

| Resource Type | Alert Name | Alert Type | Override Tag name | Tag value type | Example |
| ------------- | ---------- | ---------- | ----------------- | -------------- | ------- |
| Machine - Azure Arc | *```subscription().displayName```*-HybridVMHighDataDiskReadLatencyAlert | _Log search_ | ***\_amba-ReadLatencyMs-Data-threshold-Override\_*** | Number | 35 |
| Machine - Azure Arc | *```subscription().displayName```*-HybridVMLowDataDiskSpaceAlert | _Log search_ | ***\_amba-FreeSpacePercentage-Data-threshold-Override\_*** | Number | 8 |
| Machine - Azure Arc | *```subscription().displayName```*-HybridVMHighDataDiskWriteLatencyAlert | _Log search_ | ***\_amba-WriteLatencyMs-Data-threshold-Override\_*** | Number | 35 |
| Machine - Azure Arc | *```subscription().displayName```*-HybridVMDisconnectedAlert | _Log search_ | ***\_amba-Disconnected-threshold-Override\_*** | [Timespan](https://learn.microsoft.com/en-us/kusto/query/scalar-data-types/timespan?view=microsoft-fabric) | 5m, 10d, 2h |
| Machine - Azure Arc | *```subscription().displayName```*-HybridVMHeartBeatAlert | _Log search_ | ***\_amba-Heartbeat-threshold-Override\_*** | Number | 5 |
| Machine - Azure Arc | *```subscription().displayName```*-HybridVMHighNetworkInAlert | _Log search_ | ***\_amba-ReadBytesPerSecond-threshold-Override\_*** | Number | 20000000 |
| Machine - Azure Arc | *```subscription().displayName```*-HybridVMHighNetworkOutAlert | _Log search_ | ***\_amba-WriteBytesPerSecond-threshold-Override\_*** | Number | 20000000 |
| Machine - Azure Arc | *```subscription().displayName```*-HybridVMHighOSDiskReadLatencyAlert | _Log search_ | ***\_amba-ReadLatencyMs-OS-threshold-Override\_*** | Number | 35 |
| Machine - Azure Arc | *```subscription().displayName```*-HybridVMLowOSDiskSpaceAlert | _Log search_ | ***\_amba-FreeSpacePercentage-OS-threshold-Override\_*** | Number | 8 |
| Machine - Azure Arc | *```subscription().displayName```*-HybridVMHighOSDiskWriteLatencyAlert | _Log search_ | ***\_amba-WriteLatencyMs-OS-threshold-Override\_*** | Number | 35 |
| Machine - Azure Arc | *```subscription().displayName```*-HybridVMHighCPUAlert | _Log search_ | ***\_amba-UtilizationPercentage-threshold-Override\_*** | Number | 90 |
| Machine - Azure Arc | *```subscription().displayName```*-HybridVMLowMemoryAlert | _Log search_ | ***\_amba-AvailableMemoryPercentage-threshold-Override\_*** | Number | 8 |
| Virtual machine | *```subscription().displayName```*-VMHighDataDiskReadLatencyAlert | _Log search_ | ***\_amba-ReadLatencyMs-Data-threshold-Override\_*** | Number | 35 |
| Virtual machine | *```subscription().displayName```*-VMLowDataDiskSpaceAlert | _Log search_ | ***\_amba-FreeSpacePercentage-Data-threshold-Override\_*** | Number | 8 |
| Virtual machine | *```subscription().displayName```*-VMHighDataDiskWriteLatencyAlert | _Log search_ | ***\_amba-WriteLatencyMs-Data-threshold-Override\_*** | Number | 35 |
| Virtual machine | *```subscription().displayName```*-VMHeartBeatAlert | _Log search_ | ***\_amba-Heartbeat-threshold-Override\_*** | Number | 5 |
| Virtual machine | *```subscription().displayName```*-VMHighNetworkInAlert | _Log search_ | ***\_amba-ReadBytesPerSecond-threshold-Override\_*** | Number | 20000000 |
| Virtual machine | *```subscription().displayName```*-VMHighNetworkOutAlert | _Log search_ | ***\_amba-WriteBytesPerSecond-threshold-Override\_*** | Number | 20000000 |
| Virtual machine | *```subscription().displayName```*-VMHighOSDiskReadLatencyAlert | _Log search_ | ***\_amba-ReadLatencyMs-OS-threshold-Override\_*** | Number | 35 |
| Virtual machine | *```subscription().displayName```*-VMLowOSDiskSpaceAlert | _Log search_ | ***\_amba-FreeSpacePercentage-OS-threshold-Override\_*** | Number | 8 |
| Virtual machine | *```subscription().displayName```*-VMHighOSDiskWriteLatencyAlert | _Log search_ | ***\_amba-WriteLatencyMs-OS-threshold-Override\_*** | Number | 35 |
| Virtual machine | *```subscription().displayName```*-VMHighCPUAlert | _Log search_ | ***\_amba-UtilizationPercentage-threshold-Override\_*** | Number | 90 |
| Virtual machine | *```subscription().displayName```*-VMLowMemoryAlert | _Log search_ | ***\_amba-AvailableMemoryPercentage-threshold-Override\_*** | Number | 8 |
| Log Analytics workspace | *```resourceName```*-DailyCapLimitReachedAlert | _Log search_ | <span style="color:DarkOrange">***Not available as threshold will always be 0***</span> | <span style="color:DarkOrange">***Not applicable***</span>| <span style="color:DarkOrange">***N/A***</span> |
| Application Insights | *```resourceName```*-ApplicationInsightsThrottlingLimitReachedAlert | _Log search_ | ***\_amba-Throttling-threshold-override\_*** | Number | 64000 |
