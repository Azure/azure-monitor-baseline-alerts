---
title: Metrics alerts table
geekdocHidden: true
---

| Alert Policy Name | Alert Name | Alert Scope | Target Resource Type | Evaluation Period | Evaluation Frequency | Operator | Threshold | Severity | Enabled |
| ----------------- | ---------- | ----------- | -------------------- | ----------------- | -------------------- |--------- | --------- | -------- | ------- |
| Deploy Azure Monitor Baseline Alerts (AMBA-ALZ) - Azure VM Data Disk Read Latency Alert | subscription-VMHighDataDiskReadLatencyAlert | subscription | Microsoft.Compute/virtualMachines | PT15M | PT5M | GreaterThan | 30 | Warning | true |
| Deploy Azure Monitor Baseline Alerts (AMBA-ALZ) - Azure VM Data Disk Space Alert | subscription-VMLowDataDiskSpaceAlert | subscription | Microsoft.Compute/virtualMachines | PT15M | PT5M | GreaterThan | 10 | Warning | true |
| Deploy Azure Monitor Baseline Alerts (AMBA-ALZ) - Azure VM Data Disk Write Latency Alert | subscription-VMHighDataDiskWriteLatencyAlert | subscription | Microsoft.Compute/virtualMachines | PT15M | PT5M | GreaterThan | 30 | Warning | true |
| Deploy Azure Monitor Baseline Alerts (AMBA-ALZ) - Azure VM HeartBeat Alert | subscription-VMHeartBeatAlert | subscription | Microsoft.Compute/virtualMachines | PT6H | PT5M | GreaterThan | 10 | Error | true |
| Deploy Azure Monitor Baseline Alerts (AMBA-ALZ) - Azure VM Network Read Alert | subscription-VMHighNetworkInAlert | subscription | Microsoft.Compute/virtualMachines | PT15M | PT5M | GreaterThan | 10000000 | Warning | true |
| Deploy Azure Monitor Baseline Alerts (AMBA-ALZ) - Azure VM Network Write Alert | subscription-VMHighNetworkOutAlert | subscription | Microsoft.Compute/virtualMachines | PT15M | PT5M | GreaterThan | 10000000 | Warning | true |
| Deploy Azure Monitor Baseline Alerts (AMBA-ALZ) - Azure VM OS Disk Read Latency Alert | subscription-VMHighOSDiskReadLatencyAlert | subscription | Microsoft.Compute/virtualMachines | PT15M | PT5M | GreaterThan | 30 | Warning | true |
| Deploy Azure Monitor Baseline Alerts (AMBA-ALZ) - Azure VM OS Disk Space Alert | subscription-VMLowOSDiskSpaceAlert | subscription | Microsoft.Compute/virtualMachines | PT15M | PT5M | GreaterThan | 10 | Warning | true |
| Deploy Azure Monitor Baseline Alerts (AMBA-ALZ) - Azure VM OS Disk Write Latency Alert | subscription-VMHighOSDiskWriteLatencyAlert | subscription | Microsoft.Compute/virtualMachines | PT15M | PT5M | GreaterThan | 30 | Warning | true |
| Deploy Azure Monitor Baseline Alerts (AMBA-ALZ) - Azure VM CPU Alert | subscription-VMHighCPUAlert | subscription | Microsoft.Compute/virtualMachines | PT15M | PT5M | GreaterThan | 85 | Warning | true |
| Deploy Azure Monitor Baseline Alerts (AMBA-ALZ) - Azure VM Memory Alert | subscription-VMLowMemoryAlert | subscription | Microsoft.Compute/virtualMachines | PT15M | PT5M | GreaterThan | 10 | Warning | true |
| Deploy Azure Monitor Baseline Alerts (AMBA-ALZ) - Hybrid VM Data Disk Read Latency Alert | subscription-HybridVMHighDataDiskReadLatencyAlert | subscription | Microsoft.HybridCompute/machines | PT15M | PT5M | GreaterThan | 30 | Warning | true |
| Deploy Azure Monitor Baseline Alerts (AMBA-ALZ) - Hybrid VM Data Disk Space Alert | subscription-HybridVMLowDataDiskSpaceAlert | subscription | Microsoft.HybridCompute/machines | PT15M | PT5M | GreaterThan | 10 | Warning | true |
| Deploy Azure Monitor Baseline Alerts (AMBA-ALZ) - Hybrid VM Data Disk Write Latency Alert | subscription-HybridVMHighDataDiskWriteLatencyAlert | subscription | Microsoft.HybridCompute/machines | PT15M | PT5M | GreaterThan | 30 | Warning | true |
| Deploy Azure Monitor Baseline Alerts (AMBA-ALZ) - Hybrid VM Disconnected Alert | subscription-HybridVMDisconnectedAlert | subscription | Microsoft.HybridCompute/machines | P1D | PT10M | GreaterThan | 10m | Error | true |
| Deploy Azure Monitor Baseline Alerts (AMBA-ALZ) - Hybrid VM HeartBeat Alert | subscription-HybridVMHeartBeatAlert | subscription | Microsoft.HybridCompute/machines | PT6H | PT5M | GreaterThan | 10 | Error | true |
| Deploy Azure Monitor Baseline Alerts (AMBA-ALZ) - Hybrid VM Network Read Alert | subscription-HybridVMHighNetworkInAlert | subscription | Microsoft.HybridCompute/machines | PT15M | PT5M | GreaterThan | 10000000 | Warning | true |
| Deploy Azure Monitor Baseline Alerts (AMBA-ALZ) - Hybrid VM Network Write Alert | subscription-HybridVMHighNetworkOutAlert | subscription | Microsoft.HybridCompute/machines | PT15M | PT5M | GreaterThan | 10000000 | Warning | true |
| Deploy Azure Monitor Baseline Alerts (AMBA-ALZ) - Hybrid VM OS Disk Read Latency Alert | subscription-HybridVMHighOSDiskReadLatencyAlert | subscription | Microsoft.HybridCompute/machines | PT15M | PT5M | GreaterThan | 30 | Warning | true |
| Deploy Azure Monitor Baseline Alerts (AMBA-ALZ) - Hybrid VM OS Disk Space Alert | subscription-HybridVMLowOSDiskSpaceAlert | subscription | Microsoft.HybridCompute/machines | PT15M | PT5M | GreaterThan | 10 | Warning | true |
| Deploy Azure Monitor Baseline Alerts (AMBA-ALZ) - Hybrid VM OS Disk Write Latency Alert | subscription-HybridVMHighOSDiskWriteLatencyAlert | subscription | Microsoft.HybridCompute/machines | PT15M | PT5M | GreaterThan | 30 | Warning | true |
| Deploy Azure Monitor Baseline Alerts (AMBA-ALZ) - Hybrid VM CPU Alert | subscription-HybridVMHighCPUAlert | subscription | Microsoft.HybridCompute/machines | PT15M | PT5M | GreaterThan | 85 | Warning | true |
| Deploy Azure Monitor Baseline Alerts (AMBA-ALZ) - Hybrid VM Memory Alert | subscription-HybridVMLowMemoryAlert | subscription | Microsoft.HybridCompute/machines | PT15M | PT5M | GreaterThan | 10 | Warning | true |
| Deploy Azure Monitor Baseline Alerts (AMBA-ALZ) - Application Insights Throttling Limit Reached Alert | resourceName-ApplicationInsightsThrottlingLimitReachedAlert | resourceId-WorkspaceResourceId | Microsoft.Insights/components | P1D | PT1H | GreaterThan | 32000 | Warning | true |
| Deploy Azure Monitor Baseline Alerts (AMBA-ALZ) - LA Workspace Daily Cap Limit Reached Alert | resourceName-DailyCapLimitReachedAlert | resourceId | Microsoft.OperationalInsights/workspaces | P1D | PT1H | GreaterThan | 0 | Warning | true |
