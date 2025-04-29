---
title: Metrics alerts table
geekdocHidden: true
---

| Alert Policy Name | Alert Name | Target Resource Type | Alert Scope | Operator | Threshold | Severity | Enabled |
| ----------------- | ---------- | -------------------- | ----------- | -------- | --------- | -------- | ------- |
| Deploy Azure Monitor Baseline Alerts (AMBA-ALZ) - Azure VM Data Disk Read Latency Alert | subscription-VMHighDataDiskReadLatencyAlert | Microsoft.Compute/virtualMachines | subscription | GreaterThan | 30 | Warning | true |
| Deploy Azure Monitor Baseline Alerts (AMBA-ALZ) - Azure VM Data Disk Space Alert | subscription-VMLowDataDiskSpaceAlert | Microsoft.Compute/virtualMachines | subscription | GreaterThan | 10 | Warning | true |
| Deploy Azure Monitor Baseline Alerts (AMBA-ALZ) - Azure VM Data Disk Write Latency Alert | subscription-VMHighDataDiskWriteLatencyAlert | Microsoft.Compute/virtualMachines | subscription | GreaterThan | 30 | Warning | true |
| Deploy Azure Monitor Baseline Alerts (AMBA-ALZ) - Azure VM HeartBeat Alert | subscription-VMHeartBeatAlert | Microsoft.Compute/virtualMachines | subscription | GreaterThan | 10 | Error | true |
| Deploy Azure Monitor Baseline Alerts (AMBA-ALZ) - Azure VM Network Read Alert | subscription-VMHighNetworkInAlert | Microsoft.Compute/virtualMachines | subscription | GreaterThan | 10000000 | Warning | true |
| Deploy Azure Monitor Baseline Alerts (AMBA-ALZ) - Azure VM Network Write Alert | subscription-VMHighNetworkOutAlert | Microsoft.Compute/virtualMachines | subscription | GreaterThan | 10000000 | Warning | true |
| Deploy Azure Monitor Baseline Alerts (AMBA-ALZ) - Azure VM OS Disk Read Latency Alert | subscription-VMHighOSDiskReadLatencyAlert | Microsoft.Compute/virtualMachines | subscription | GreaterThan | 30 | Warning | true |
| Deploy Azure Monitor Baseline Alerts (AMBA-ALZ) - Azure VM OS Disk Space Alert | subscription-VMLowOSDiskSpaceAlert | Microsoft.Compute/virtualMachines | subscription | GreaterThan | 10 | Warning | true |
| Deploy Azure Monitor Baseline Alerts (AMBA-ALZ) - Azure VM OS Disk Write Latency Alert | subscription-VMHighOSDiskWriteLatencyAlert | Microsoft.Compute/virtualMachines | subscription | GreaterThan | 30 | Warning | true |
| Deploy Azure Monitor Baseline Alerts (AMBA-ALZ) - Azure VM CPU Alert | subscription-VMHighCPUAlert | Microsoft.Compute/virtualMachines | subscription | GreaterThan | 85 | Warning | true |
| Deploy Azure Monitor Baseline Alerts (AMBA-ALZ) - Azure VM Memory Alert | subscription-VMLowMemoryAlert | Microsoft.Compute/virtualMachines | subscription | GreaterThan | 10 | Warning | true |
| Deploy Azure Monitor Baseline Alerts (AMBA-ALZ) - Hybrid VM Data Disk Read Latency Alert | subscription-HybridVMHighDataDiskReadLatencyAlert | Microsoft.HybridCompute/machines | subscription | GreaterThan | 30 | Warning | true |
| Deploy Azure Monitor Baseline Alerts (AMBA-ALZ) - Hybrid VM Data Disk Space Alert | subscription-HybridVMLowDataDiskSpaceAlert | Microsoft.HybridCompute/machines | subscription | GreaterThan | 10 | Warning | true |
| Deploy Azure Monitor Baseline Alerts (AMBA-ALZ) - Hybrid VM Data Disk Write Latency Alert | subscription-HybridVMHighDataDiskWriteLatencyAlert | Microsoft.HybridCompute/machines | subscription | GreaterThan | 30 | Warning | true |
| Deploy Azure Monitor Baseline Alerts (AMBA-ALZ) - Hybrid VM Disconnected Alert | subscription-HybridVMDisconnectedAlert | Microsoft.HybridCompute/machines | subscription | GreaterThan | 10m | Error | true |
| Deploy Azure Monitor Baseline Alerts (AMBA-ALZ) - Hybrid VM HeartBeat Alert | subscription-HybridVMHeartBeatAlert | Microsoft.HybridCompute/machines | subscription | GreaterThan | 10 | Error | true |
| Deploy Azure Monitor Baseline Alerts (AMBA-ALZ) - Hybrid VM Network Read Alert | subscription-HybridVMHighNetworkInAlert | Microsoft.HybridCompute/machines | subscription | GreaterThan | 10000000 | Warning | true |
| Deploy Azure Monitor Baseline Alerts (AMBA-ALZ) - Hybrid VM Network Write Alert | subscription-HybridVMHighNetworkOutAlert | Microsoft.HybridCompute/machines | subscription | GreaterThan | 10000000 | Warning | true |
| Deploy Azure Monitor Baseline Alerts (AMBA-ALZ) - Hybrid VM OS Disk Read Latency Alert | subscription-HybridVMHighOSDiskReadLatencyAlert | Microsoft.HybridCompute/machines | subscription | GreaterThan | 30 | Warning | true |
| Deploy Azure Monitor Baseline Alerts (AMBA-ALZ) - Hybrid VM OS Disk Space Alert | subscription-HybridVMLowOSDiskSpaceAlert | Microsoft.HybridCompute/machines | subscription | GreaterThan | 10 | Warning | true |
| Deploy Azure Monitor Baseline Alerts (AMBA-ALZ) - Hybrid VM OS Disk Write Latency Alert | subscription-HybridVMHighOSDiskWriteLatencyAlert | Microsoft.HybridCompute/machines | subscription | GreaterThan | 30 | Warning | true |
| Deploy Azure Monitor Baseline Alerts (AMBA-ALZ) - Hybrid VM CPU Alert | subscription-HybridVMHighCPUAlert | Microsoft.HybridCompute/machines | subscription | GreaterThan | 85 | Warning | true |
| Deploy Azure Monitor Baseline Alerts (AMBA-ALZ) - Hybrid VM Memory Alert | subscription-HybridVMLowMemoryAlert | Microsoft.HybridCompute/machines | subscription | GreaterThan | 10 | Warning | true |
| Deploy Azure Monitor Baseline Alerts (AMBA-ALZ) - Application Insights Throttling Limit Reached Alert | resourceName-ApplicationInsightsThrottlingLimitReachedAlert | Microsoft.Insights/components | reference | GreaterThan | 32000 | Warning | true |
| Deploy Azure Monitor Baseline Alerts (AMBA-ALZ) - LA Workspace Daily Cap Limit Reached Alert | resourceName-DailyCapLimitReachedAlert | Microsoft.OperationalInsights/workspaces | parameters | GreaterThan | 0 | Warning | true |
