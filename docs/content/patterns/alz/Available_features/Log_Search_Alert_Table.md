---
title: Log-search alert table
geekdocHidden: true
---

| Resource Type | Alert Name | Alert Type | Override Tag name |
| ------------- | ---------- | ---------- | ----------------- |
| Machine - Azure Arc | *```subscription().displayName```*-HybridVMHighDataDiskReadLatencyAlert | _Log search_ | ***\_amba-ReadLatencyMs-Data-threshold-Override\_*** |
| Machine - Azure Arc | *```subscription().displayName```*-HybridVMLowDataDiskSpaceAlert | _Log search_ | ***\_amba-FreeSpacePercentage-Data-threshold-Override\_*** |
| Machine - Azure Arc | *```subscription().displayName```*-HybridVMHighDataDiskWriteLatencyAlert | _Log search_ | ***\_amba-WriteLatencyMs-Data-threshold-Override\_*** |
| Machine - Azure Arc | *```subscription().displayName```*-HybridVMDisconnectedAlert | _Log search_ | ***\_amba-Disconnected-threshold-Override\_*** |
| Machine - Azure Arc | *```subscription().displayName```*-HybridVMHeartBeatAlert | _Log search_ | ***\_amba-Heartbeat-threshold-Override\_*** |
| Machine - Azure Arc | *```subscription().displayName```*-HybridVMHighNetworkInAlert | _Log search_ | ***\_amba-ReadBytesPerSecond-threshold-Override\_*** |
| Machine - Azure Arc | *```subscription().displayName```*-HybridVMHighNetworkOutAlert | _Log search_ | ***\_amba-WriteBytesPerSecond-threshold-Override\_*** |
| Machine - Azure Arc | *```subscription().displayName```*-HybridVMHighOSDiskReadLatencyAlert | _Log search_ | ***\_amba-ReadLatencyMs-OS-threshold-Override\_*** |
| Machine - Azure Arc | *```subscription().displayName```*-HybridVMLowOSDiskSpaceAlert | _Log search_ | ***\_amba-FreeSpacePercentage-OS-threshold-Override\_*** |
| Machine - Azure Arc | *```subscription().displayName```*-HybridVMHighOSDiskWriteLatencyAlert | _Log search_ | ***\_amba-WriteLatencyMs-OS-threshold-Override\_*** |
| Machine - Azure Arc | *```subscription().displayName```*-HybridVMHighCPUAlert | _Log search_ | ***\_amba-UtilizationPercentage-threshold-Override\_*** |
| Machine - Azure Arc | *```subscription().displayName```*-HybridVMLowMemoryAlert | _Log search_ | ***\_amba-AvailableMemoryPercentage-threshold-Override\_*** |
| Virtual machine | *```subscription().displayName```*-VMHighDataDiskReadLatencyAlert | _Log search_ | ***\_amba-ReadLatencyMs-Data-threshold-Override\_*** |
| Virtual machine | *```subscription().displayName```*-VMLowDataDiskSpaceAlert | _Log search_ | ***\_amba-FreeSpacePercentage-Data-threshold-Override\_*** |
| Virtual machine | *```subscription().displayName```*-VMHighDataDiskWriteLatencyAlert | _Log search_ | ***\_amba-WriteLatencyMs-Data-threshold-Override\_*** |
| Virtual machine | *```subscription().displayName```*-VMHeartBeatAlert | _Log search_ | ***\_amba-Heartbeat-threshold-Override\_*** |
| Virtual machine | *```subscription().displayName```*-VMHighNetworkInAlert | _Log search_ | ***\_amba-ReadBytesPerSecond-threshold-Override\_*** |
| Virtual machine | *```subscription().displayName```*-VMHighNetworkOutAlert | _Log search_ | ***\_amba-WriteBytesPerSecond-threshold-Override\_*** |
| Virtual machine | *```subscription().displayName```*-VMHighOSDiskReadLatencyAlert | _Log search_ | ***\_amba-ReadLatencyMs-OS-threshold-Override\_*** |
| Virtual machine | *```subscription().displayName```*-VMLowOSDiskSpaceAlert | _Log search_ | ***\_amba-FreeSpacePercentage-OS-threshold-Override\_*** |
| Virtual machine | *```subscription().displayName```*-VMHighOSDiskWriteLatencyAlert | _Log search_ | ***\_amba-WriteLatencyMs-OS-threshold-Override\_*** |
| Virtual machine | *```subscription().displayName```*-VMHighCPUAlert | _Log search_ | ***\_amba-UtilizationPercentage-threshold-Override\_*** |
| Virtual machine | *```subscription().displayName```*-VMLowMemoryAlert | _Log search_ | ***\_amba-AvailableMemoryPercentage-threshold-Override\_*** |
| Log Analytics workspace | *```resourceName```*-DailyCapLimitReachedAlert | _Log search_ |	***Not available since threshold will always be ```0```*** |
