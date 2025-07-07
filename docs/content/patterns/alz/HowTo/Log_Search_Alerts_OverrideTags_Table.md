---
title: Log-search alerts override tags table
geekdocHidden: true
---

| Resource Type | Alert Name | Override Tag name | Tag value type | Operator | Original threshold value | Sample override value |
| ------------- | ---------- | ----------------- | -------------- | -------- | ------------------------ | --------------------- |
| Microsoft.Compute/virtualMachines | subscription().displayName-VMHighDataDiskReadLatencyAlert | ***\_amba-ReadLatencyMs-Data-threshold-Override\_*** | Number | GreaterThan | 30 | 29 |
| Microsoft.Compute/virtualMachines | subscription().displayName-VMLowDataDiskSpaceAlert | ***\_amba-FreeSpacePercentage-Data-threshold-Override\_*** | Number | GreaterThan | 10 | 7 |
| Microsoft.Compute/virtualMachines | subscription().displayName-VMHighDataDiskWriteLatencyAlert | ***\_amba-WriteLatencyMs-Data-threshold-Override\_*** | Number | GreaterThan | 30 | 18 |
| Microsoft.Compute/virtualMachines | subscription().displayName-VMHeartBeatAlert | ***\_amba-Heartbeat-threshold-Override\_*** | Number | GreaterThan | 10 | 9 |
| Microsoft.Compute/virtualMachines | subscription().displayName-VMHighNetworkInAlert | ***\_amba-ReadBytesPerSecond-threshold-Override\_*** | Number | GreaterThan | 10000000 | 2997772 |
| Microsoft.Compute/virtualMachines | subscription().displayName-VMHighNetworkOutAlert | ***\_amba-WriteBytesPerSecond-threshold-Override\_*** | Number | GreaterThan | 10000000 | 5982954 |
| Microsoft.Compute/virtualMachines | subscription().displayName-VMHighOSDiskReadLatencyAlert | ***\_amba-ReadLatencyMs-OS-threshold-Override\_*** | Number | GreaterThan | 30 | 4 |
| Microsoft.Compute/virtualMachines | subscription().displayName-VMLowOSDiskSpaceAlert | ***\_amba-FreeSpacePercentage-OS-threshold-Override\_*** | Number | GreaterThan | 10 | 8 |
| Microsoft.Compute/virtualMachines | subscription().displayName-VMHighOSDiskWriteLatencyAlert | ***\_amba-WriteLatencyMs-OS-threshold-Override\_*** | Number | GreaterThan | 30 | 1 |
| Microsoft.Compute/virtualMachines | subscription().displayName-VMHighCPUAlert | ***\_amba-UtilizationPercentage-threshold-Override\_*** | Number | GreaterThan | 85 | 50 |
| Microsoft.Compute/virtualMachines | subscription().displayName-VMLowMemoryAlert | ***\_amba-AvailableMemoryPercentage-threshold-Override\_*** | Number | GreaterThan | 10 | 3 |
| Microsoft.HybridCompute/machines | subscription().displayName-HybridVMHighDataDiskReadLatencyAlert | ***\_amba-ReadLatencyMs-Data-threshold-Override\_*** | Number | GreaterThan | 30 | 12 |
| Microsoft.HybridCompute/machines | subscription().displayName-HybridVMLowDataDiskSpaceAlert | ***\_amba-FreeSpacePercentage-Data-threshold-Override\_*** | Number | GreaterThan | 10 | 5 |
| Microsoft.HybridCompute/machines | subscription().displayName-HybridVMHighDataDiskWriteLatencyAlert | ***\_amba-WriteLatencyMs-Data-threshold-Override\_*** | Number | GreaterThan | 30 | 16 |
| Microsoft.HybridCompute/machines | subscription().displayName-HybridVMDisconnectedAlert |  <span style="color:DarkOrange">***Not applicable***</span>  | Timespan (string) | GreaterThan | 10m |  <span style="color:DarkOrange">***N/A***</span>  |
| Microsoft.HybridCompute/machines | subscription().displayName-HybridVMHeartBeatAlert | ***\_amba-Heartbeat-threshold-Override\_*** | Number | GreaterThan | 10 | 8 |
| Microsoft.HybridCompute/machines | subscription().displayName-HybridVMHighNetworkInAlert | ***\_amba-ReadBytesPerSecond-threshold-Override\_*** | Number | GreaterThan | 10000000 | 3274414 |
| Microsoft.HybridCompute/machines | subscription().displayName-HybridVMHighNetworkOutAlert | ***\_amba-WriteBytesPerSecond-threshold-Override\_*** | Number | GreaterThan | 10000000 | 9023282 |
| Microsoft.HybridCompute/machines | subscription().displayName-HybridVMHighOSDiskReadLatencyAlert | ***\_amba-ReadLatencyMs-OS-threshold-Override\_*** | Number | GreaterThan | 30 | 13 |
| Microsoft.HybridCompute/machines | subscription().displayName-HybridVMLowOSDiskSpaceAlert | ***\_amba-FreeSpacePercentage-OS-threshold-Override\_*** | Number | GreaterThan | 10 | 0 |
| Microsoft.HybridCompute/machines | subscription().displayName-HybridVMHighOSDiskWriteLatencyAlert | ***\_amba-WriteLatencyMs-OS-threshold-Override\_*** | Number | GreaterThan | 30 | 28 |
| Microsoft.HybridCompute/machines | subscription().displayName-HybridVMHighCPUAlert | ***\_amba-UtilizationPercentage-threshold-Override\_*** | Number | GreaterThan | 85 | 79 |
| Microsoft.HybridCompute/machines | subscription().displayName-HybridVMLowMemoryAlert | ***\_amba-AvailableMemoryPercentage-threshold-Override\_*** | Number | GreaterThan | 10 | 7 |
| Microsoft.Insights/components | resourceName-ApplicationInsightsThrottlingLimitReachedAlert | ***\_amba-Throttling-threshold-override\_*** | Number | GreaterThan | 32000 | 30215 |
| Microsoft.OperationalInsights/workspaces | resourceName-DailyCapLimitReachedAlert |  <span style="color:DarkOrange">***Not applicable***</span>  | Number | GreaterThan | 0 |  <span style="color:DarkOrange">***N/A***</span>  |
