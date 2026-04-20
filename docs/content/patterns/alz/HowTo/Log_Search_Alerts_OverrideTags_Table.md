---
title: Log-search alerts override tags table
hidden: true
---

| Resource Type | Alert Name | Override Tag name | Tag value type | Operator | Original threshold value | Sample override value |
| ------------- | ---------- | ----------------- | -------------- | -------- | ------------------------ | --------------------- |
| Microsoft.Compute/virtualMachines | subscription().displayName-VMHighDataDiskReadLatencyAlert | ***\_amba-ReadLatencyMs-Data-threshold-Override\_*** | Number | GreaterThan | 30 | 6 |
| Microsoft.Compute/virtualMachines | subscription().displayName-VMLowDataDiskSpaceAlert | ***\_amba-FreeSpacePercentage-Data-threshold-Override\_*** | Number | GreaterThan | 10 | 3 |
| Microsoft.Compute/virtualMachines | subscription().displayName-VMHighDataDiskWriteLatencyAlert | ***\_amba-WriteLatencyMs-Data-threshold-Override\_*** | Number | GreaterThan | 30 | 26 |
| Microsoft.Compute/virtualMachines | subscription().displayName-VMHeartBeatAlert | ***\_amba-Heartbeat-threshold-Override\_*** | Number | GreaterThan | 10 | 8 |
| Microsoft.Compute/virtualMachines | subscription().displayName-VMHighNetworkInAlert | ***\_amba-ReadBytesPerSecond-threshold-Override\_*** | Number | GreaterThan | 10000000 | 2432684 |
| Microsoft.Compute/virtualMachines | subscription().displayName-VMHighNetworkOutAlert | ***\_amba-WriteBytesPerSecond-threshold-Override\_*** | Number | GreaterThan | 10000000 | 5944713 |
| Microsoft.Compute/virtualMachines | subscription().displayName-VMHighOSDiskReadLatencyAlert | ***\_amba-ReadLatencyMs-OS-threshold-Override\_*** | Number | GreaterThan | 30 | 0 |
| Microsoft.Compute/virtualMachines | subscription().displayName-VMLowOSDiskSpaceAlert | ***\_amba-FreeSpacePercentage-OS-threshold-Override\_*** | Number | GreaterThan | 10 | 1 |
| Microsoft.Compute/virtualMachines | subscription().displayName-VMHighOSDiskWriteLatencyAlert | ***\_amba-WriteLatencyMs-OS-threshold-Override\_*** | Number | GreaterThan | 30 | 20 |
| Microsoft.Compute/virtualMachines | subscription().displayName-VMHighCPUAlert | ***\_amba-UtilizationPercentage-threshold-Override\_*** | Number | GreaterThan | 85 | 10 |
| Microsoft.Compute/virtualMachines | subscription().displayName-VMLowMemoryAlert | ***\_amba-AvailableMemoryPercentage-threshold-Override\_*** | Number | GreaterThan | 10 | 4 |
| Microsoft.Compute/virtualMachineScaleSets | subscription().displayName-VMSSHighDataDiskReadLatencyAlert | ***\_amba-ReadLatencyMs-Data-threshold-Override\_*** | Number | GreaterThan | 30 | 5 |
| Microsoft.Compute/virtualMachineScaleSets | subscription().displayName-VMSSLowDataDiskSpaceAlert | ***\_amba-FreeSpacePercentage-Data-threshold-Override\_*** | Number | GreaterThan | 10 | 5 |
| Microsoft.Compute/virtualMachineScaleSets | subscription().displayName-VMSSHighDataDiskWriteLatencyAlert | ***\_amba-WriteLatencyMs-Data-threshold-Override\_*** | Number | GreaterThan | 30 | 19 |
| Microsoft.Compute/virtualMachineScaleSets | subscription().displayName-VMSSHeartBeatAlert | ***\_amba-Heartbeat-threshold-Override\_*** | Number | GreaterThan | 10 | 8 |
| Microsoft.Compute/virtualMachineScaleSets | subscription().displayName-VMSSHighNetworkInAlert | ***\_amba-ReadBytesPerSecond-threshold-Override\_*** | Number | GreaterThan | 10000000 | 7841772 |
| Microsoft.Compute/virtualMachineScaleSets | subscription().displayName-VMSSHighNetworkOutAlert | ***\_amba-WriteBytesPerSecond-threshold-Override\_*** | Number | GreaterThan | 10000000 | 5123324 |
| Microsoft.Compute/virtualMachineScaleSets | subscription().displayName-VMSSHighOSDiskReadLatencyAlert | ***\_amba-ReadLatencyMs-OS-threshold-Override\_*** | Number | GreaterThan | 30 | 10 |
| Microsoft.Compute/virtualMachineScaleSets | subscription().displayName-VMSSLowOSDiskSpaceAlert | ***\_amba-FreeSpacePercentage-OS-threshold-Override\_*** | Number | GreaterThan | 10 | 1 |
| Microsoft.Compute/virtualMachineScaleSets | subscription().displayName-VMSSHighOSDiskWriteLatencyAlert | ***\_amba-WriteLatencyMs-OS-threshold-Override\_*** | Number | GreaterThan | 30 | 15 |
| Microsoft.Compute/virtualMachineScaleSets | subscription().displayName-VMSSHighCPUAlert | ***\_amba-UtilizationPercentage-threshold-Override\_*** | Number | GreaterThan | 85 | 59 |
| Microsoft.Compute/virtualMachineScaleSets | subscription().displayName-VMSSLowMemoryAlert | ***\_amba-AvailableMemoryPercentage-threshold-Override\_*** | Number | GreaterThan | 10 | 3 |
| Microsoft.HybridCompute/machines | subscription().displayName-HybridVMHighDataDiskReadLatencyAlert | ***\_amba-ReadLatencyMs-Data-threshold-Override\_*** | Number | GreaterThan | 30 | 10 |
| Microsoft.HybridCompute/machines | subscription().displayName-HybridVMLowDataDiskSpaceAlert | ***\_amba-FreeSpacePercentage-Data-threshold-Override\_*** | Number | GreaterThan | 10 | 0 |
| Microsoft.HybridCompute/machines | subscription().displayName-HybridVMHighDataDiskWriteLatencyAlert | ***\_amba-WriteLatencyMs-Data-threshold-Override\_*** | Number | GreaterThan | 30 | 20 |
| Microsoft.HybridCompute/machines | subscription().displayName-HybridVMDisconnectedAlert |  <span style="color:DarkOrange">***Not applicable***</span>  | Timespan (string) | GreaterThan | 10m |  <span style="color:DarkOrange">***N/A***</span>  |
| Microsoft.HybridCompute/machines | subscription().displayName-HybridVMHeartBeatAlert | ***\_amba-Heartbeat-threshold-Override\_*** | Number | GreaterThan | 10 | 6 |
| Microsoft.HybridCompute/machines | subscription().displayName-HybridVMHighNetworkInAlert | ***\_amba-ReadBytesPerSecond-threshold-Override\_*** | Number | GreaterThan | 10000000 | 9106740 |
| Microsoft.HybridCompute/machines | subscription().displayName-HybridVMHighNetworkOutAlert | ***\_amba-WriteBytesPerSecond-threshold-Override\_*** | Number | GreaterThan | 10000000 | 1680988 |
| Microsoft.HybridCompute/machines | subscription().displayName-HybridVMHighOSDiskReadLatencyAlert | ***\_amba-ReadLatencyMs-OS-threshold-Override\_*** | Number | GreaterThan | 30 | 13 |
| Microsoft.HybridCompute/machines | subscription().displayName-HybridVMLowOSDiskSpaceAlert | ***\_amba-FreeSpacePercentage-OS-threshold-Override\_*** | Number | GreaterThan | 10 | 9 |
| Microsoft.HybridCompute/machines | subscription().displayName-HybridVMHighOSDiskWriteLatencyAlert | ***\_amba-WriteLatencyMs-OS-threshold-Override\_*** | Number | GreaterThan | 30 | 17 |
| Microsoft.HybridCompute/machines | subscription().displayName-HybridVMHighCPUAlert | ***\_amba-UtilizationPercentage-threshold-Override\_*** | Number | GreaterThan | 85 | 84 |
| Microsoft.HybridCompute/machines | subscription().displayName-HybridVMLowMemoryAlert | ***\_amba-AvailableMemoryPercentage-threshold-Override\_*** | Number | GreaterThan | 10 | 7 |
| Microsoft.Insights/components | resourceName-ApplicationInsightsThrottlingLimitReachedAlert | ***\_amba-Throttling-threshold-override\_*** | Number | GreaterThan | 32000 | 20850 |
| Microsoft.OperationalInsights/workspaces | resourceName-DailyCapLimitReachedAlert |  <span style="color:DarkOrange">***Not applicable***</span>  | Number | GreaterThan | 0 |  <span style="color:DarkOrange">***N/A***</span>  |
