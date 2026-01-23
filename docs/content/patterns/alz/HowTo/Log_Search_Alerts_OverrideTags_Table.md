---
title: Log-search alerts override tags table
geekdocHidden: true
---

| Resource Type | Alert Name | Override Tag name | Tag value type | Operator | Original threshold value | Sample override value |
| ------------- | ---------- | ----------------- | -------------- | -------- | ------------------------ | --------------------- |
| Microsoft.Compute/virtualMachines | subscription().displayName-VMHighDataDiskReadLatencyAlert | ***\_amba-ReadLatencyMs-Data-threshold-Override\_*** | Number | GreaterThan | 30 | 25 |
| Microsoft.Compute/virtualMachines | subscription().displayName-VMLowDataDiskSpaceAlert | ***\_amba-FreeSpacePercentage-Data-threshold-Override\_*** | Number | GreaterThan | 10 | 6 |
| Microsoft.Compute/virtualMachines | subscription().displayName-VMHighDataDiskWriteLatencyAlert | ***\_amba-WriteLatencyMs-Data-threshold-Override\_*** | Number | GreaterThan | 30 | 5 |
| Microsoft.Compute/virtualMachines | subscription().displayName-VMHeartBeatAlert | ***\_amba-Heartbeat-threshold-Override\_*** | Number | GreaterThan | 10 | 2 |
| Microsoft.Compute/virtualMachines | subscription().displayName-VMHighNetworkInAlert | ***\_amba-ReadBytesPerSecond-threshold-Override\_*** | Number | GreaterThan | 10000000 | 5991488 |
| Microsoft.Compute/virtualMachines | subscription().displayName-VMHighNetworkOutAlert | ***\_amba-WriteBytesPerSecond-threshold-Override\_*** | Number | GreaterThan | 10000000 | 3802712 |
| Microsoft.Compute/virtualMachines | subscription().displayName-VMHighOSDiskReadLatencyAlert | ***\_amba-ReadLatencyMs-OS-threshold-Override\_*** | Number | GreaterThan | 30 | 23 |
| Microsoft.Compute/virtualMachines | subscription().displayName-VMLowOSDiskSpaceAlert | ***\_amba-FreeSpacePercentage-OS-threshold-Override\_*** | Number | GreaterThan | 10 | 4 |
| Microsoft.Compute/virtualMachines | subscription().displayName-VMHighOSDiskWriteLatencyAlert | ***\_amba-WriteLatencyMs-OS-threshold-Override\_*** | Number | GreaterThan | 30 | 18 |
| Microsoft.Compute/virtualMachines | subscription().displayName-VMHighCPUAlert | ***\_amba-UtilizationPercentage-threshold-Override\_*** | Number | GreaterThan | 85 | 34 |
| Microsoft.Compute/virtualMachines | subscription().displayName-VMLowMemoryAlert | ***\_amba-AvailableMemoryPercentage-threshold-Override\_*** | Number | GreaterThan | 10 | 8 |
| Microsoft.HybridCompute/machines | subscription().displayName-HybridVMHighDataDiskReadLatencyAlert | ***\_amba-ReadLatencyMs-Data-threshold-Override\_*** | Number | GreaterThan | 30 | 3 |
| Microsoft.HybridCompute/machines | subscription().displayName-HybridVMLowDataDiskSpaceAlert | ***\_amba-FreeSpacePercentage-Data-threshold-Override\_*** | Number | GreaterThan | 10 | 9 |
| Microsoft.HybridCompute/machines | subscription().displayName-HybridVMHighDataDiskWriteLatencyAlert | ***\_amba-WriteLatencyMs-Data-threshold-Override\_*** | Number | GreaterThan | 30 | 11 |
| Microsoft.HybridCompute/machines | subscription().displayName-HybridVMDisconnectedAlert |  <span style="color:DarkOrange">***Not applicable***</span>  | Timespan (string) | GreaterThan | 10m |  <span style="color:DarkOrange">***N/A***</span>  |
| Microsoft.HybridCompute/machines | subscription().displayName-HybridVMHeartBeatAlert | ***\_amba-Heartbeat-threshold-Override\_*** | Number | GreaterThan | 10 | 0 |
| Microsoft.HybridCompute/machines | subscription().displayName-HybridVMHighNetworkInAlert | ***\_amba-ReadBytesPerSecond-threshold-Override\_*** | Number | GreaterThan | 10000000 | 7903771 |
| Microsoft.HybridCompute/machines | subscription().displayName-HybridVMHighNetworkOutAlert | ***\_amba-WriteBytesPerSecond-threshold-Override\_*** | Number | GreaterThan | 10000000 | 1783401 |
| Microsoft.HybridCompute/machines | subscription().displayName-HybridVMHighOSDiskReadLatencyAlert | ***\_amba-ReadLatencyMs-OS-threshold-Override\_*** | Number | GreaterThan | 30 | 16 |
| Microsoft.HybridCompute/machines | subscription().displayName-HybridVMLowOSDiskSpaceAlert | ***\_amba-FreeSpacePercentage-OS-threshold-Override\_*** | Number | GreaterThan | 10 | 0 |
| Microsoft.HybridCompute/machines | subscription().displayName-HybridVMHighOSDiskWriteLatencyAlert | ***\_amba-WriteLatencyMs-OS-threshold-Override\_*** | Number | GreaterThan | 30 | 9 |
| Microsoft.HybridCompute/machines | subscription().displayName-HybridVMHighCPUAlert | ***\_amba-UtilizationPercentage-threshold-Override\_*** | Number | GreaterThan | 85 | 11 |
| Microsoft.HybridCompute/machines | subscription().displayName-HybridVMLowMemoryAlert | ***\_amba-AvailableMemoryPercentage-threshold-Override\_*** | Number | GreaterThan | 10 | 0 |
| Microsoft.Insights/components | resourceName-ApplicationInsightsThrottlingLimitReachedAlert | ***\_amba-Throttling-threshold-override\_*** | Number | GreaterThan | 32000 | 14825 |
| Microsoft.OperationalInsights/workspaces | resourceName-DailyCapLimitReachedAlert |  <span style="color:DarkOrange">***Not applicable***</span>  | Number | GreaterThan | 0 |  <span style="color:DarkOrange">***N/A***</span>  |
