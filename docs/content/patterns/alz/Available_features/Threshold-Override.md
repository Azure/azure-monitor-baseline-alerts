---
title: Alert Threshold Override
geekdocCollapseSection: true
weight: 85
---

# Overview

The ***Alert Threshold Override*** feature, available with release [2024-09-05](../../Whats-New#2024-09-05), allows both Greenfield and Brownfield customers to override alert threshold for specific resources during or after the deployment of AMBA-ALZ. Thanks to this new feature, it's now possible to use a tag with specific name and value, to override the default alert threshold for specific resources. The new value will be used, only for the tagged resources, in place of the global one coming from the parameter file.

# How this feature works

This feature is only available for metrics and log-search alerts, since Activity Log based alerts do not use threshold and, as such, cannot benefits from this new enhancement. Using the feature is easy: customers need to create a resource tag with a specific name and assign a value of their choice. Once this release is deployed, tags can be created either before or after the execution of remediation task. However, the feature behavior differs between Metric and Log-search alerts.

## Metrics alerts

For metric alerts, if tags are configured before the remediation tasks execution, corresponding alerts (which are resource-specific) will be created using different thresholds for the same resource type:

![Metric Alerts - Override threshold at work](../../media/MetricAlerts-OverrideThresholdAtWork.png)

If the tags are configured after the remediation task have completed, given the tag being part of the compliance criteria, the resource will be marked as not compliant, as such customers will just need to remediate the corresponding policy initiative(s) as documented at [Remediate Policies](../../deploy/Remediate-Policies) to reconfigure exiting alerts with the new threshold.

## Log-search alerts
Considering the different nature of log-search alerts where resource information is retrieved at query runtime, it does not make any difference if the tags are configured before or after the remediation task execution. The log-search alert query is created with a placeholder containing the threshold passed by the parameter file and with a logic to look at the resource-specific override tag, thanks to the ability to [Correlate data in Azure Data Explorer and Azure Resource Graph with data in a Log Analytics workspace](https://learn.microsoft.com/en-us/azure/azure-monitor/logs/azure-monitor-data-explorer-proxy). If the specific override tag name is present, the query will use the tag value as new threshold, otherwise it will use the default one passed through the parameter file:

![Log-search Alerts - Override threshold at work](../../media/LogsearchAlerts-OverrideThresholdAtWork.png)

## Which tag does customers need to create

To work correctly, this feature needs to look at specific tag names. Unfortunately it is not possible to allow for flexible tag names in this case. Tag names have been defined according to the following naming convention:

```***_amba-<metricName/counterName>-threshold-override_***```

There might be cases where for the same resource, the same metric is used more than one. In this scenario, we implemented a differentiator value inserted right after the metric name, making the naming convention resampling the following format:

```***_amba-<metricName/counterName>-<differentiator>-threshold-override_***```

The following table contains the mapping between the alert name and the corresponding tag value to be created:

</br>

### Log-search alerts table

| Alert Name | Override Tag name | Alert Type |
|------------|-------------------|------------|
| *```subscription().displayName```*-HybridVMHighDataDiskReadLatencyAlert | _Log search_ | ***\_amba-ReadLatencyMs-Data-threshold-override\_*** |
| *```subscription().displayName```*-HybridVMLowDataDiskSpaceAlert | _Log search_ | ***\_amba-FreeSpacePercentage-Data-threshold-override\_*** |
| *```subscription().displayName```*-HybridVMHighDataDiskWriteLatencyAlert | _Log search_ | ***\_amba-WriteLatencyMs-Data-threshold-override\_*** |
| *```subscription().displayName```*-HybridVMDisconnectedAlert | _Log search_ | ***\_amba-Disconnected-threshold-override\_*** |
| *```subscription().displayName```*-HybridVMHeartBeatAlert | _Log search_ | ***\_amba-Heartbeat-threshold-override\_*** |
| *```subscription().displayName```*-HybridVMHighNetworkInAlert | _Log search_ | ***\_amba-ReadBytesPerSecond-threshold-override\_*** |
| *```subscription().displayName```*-HybridVMHighNetworkOutAlert | _Log search_ | ***\_amba-WriteBytesPerSecond-threshold-override\_*** |
| *```subscription().displayName```*-HybridVMHighOSDiskReadLatencyAlert | _Log search_ | ***\_amba-ReadLatencyMs-OS-threshold-override\_*** |
| *```subscription().displayName```*-HybridVMLowOSDiskSpaceAlert | _Log search_ | ***\_amba-FreeSpacePercentage-OS-threshold-override\_*** |
| *```subscription().displayName```*-HybridVMHighOSDiskWriteLatencyAlert | _Log search_ | ***\_amba-WriteLatencyMs-OS-threshold-override\_*** |
| *```subscription().displayName```*-HybridVMHighCPUAlert | _Log search_ | ***\_amba-UtilizationPercentage-threshold-override\_*** |
| *```subscription().displayName```*-HybridVMLowMemoryAlert | _Log search_ | ***\_amba-AvailableMemoryPercentage-threshold-override\_*** |
| *```subscription().displayName```*-VMHighDataDiskReadLatencyAlert | _Log search_ | ***\_amba-ReadLatencyMs-Data-threshold-override\_*** |
| *```subscription().displayName```*-VMLowDataDiskSpaceAlert | _Log search_ | ***\_amba-FreeSpacePercentage-Data-threshold-override\_*** |
| *```subscription().displayName```*-VMHighDataDiskWriteLatencyAlert | _Log search_ | ***\_amba-WriteLatencyMs-Data-threshold-override\_*** |
| *```subscription().displayName```*-VMHeartBeatAlert | _Log search_ | ***\_amba-Heartbeat-threshold-override\_*** |
| *```subscription().displayName```*-VMHighNetworkInAlert | _Log search_ | ***\_amba-ReadBytesPerSecond-threshold-override\_*** |
| *```subscription().displayName```*-VMHighNetworkOutAlert | _Log search_ | ***\_amba-WriteBytesPerSecond-threshold-override\_*** |
| *```subscription().displayName```*-VMHighOSDiskReadLatencyAlert | _Log search_ | ***\_amba-ReadLatencyMs-OS-threshold-override\_*** |
| *```subscription().displayName```*-VMLowOSDiskSpaceAlert | _Log search_ | ***\_amba-FreeSpacePercentage-OS-threshold-override\_*** |
| *```subscription().displayName```*-VMHighOSDiskWriteLatencyAlert | _Log search_ | ***\_amba-WriteLatencyMs-OS-threshold-override\_*** |
| *```subscription().displayName```*-VMHighCPUAlert | _Log search_ | ***\_amba-UtilizationPercentage-threshold-override\_*** |
| *```subscription().displayName```*-VMLowMemoryAlert | _Log search_ | ***\_amba-AvailableMemoryPercentage-threshold-override\_*** |
| *```resourceName```*-DailyCapLimitReachedAlert | _Log search_ |	***Not available since threshold will always be ```0```*** |

</br>

### Metric alerts table

| Alert Name | Override Tag name | Alert Type |
|------------|-------------------|------------|
| *```resourceName```*-AvailableMemoryAlert | Metric | ***\_amba-AvailableMemoryBytes-threshold-override\_*** |
| *```resourceName```*-TotalJob | Metric | ***\_amba-TotalJob-threshold-override\_*** |
| ActivityKeyVaultDelete | Activity Log | <span style="color:DarkOrange">***Not available since Activity Log based alerts do not have thresholds***</span> |
| *```resourceName```*-Availability | Metric | ***\_amba-Availability-threshold-override\_*** |
| *```resourceName```*-CapacityAlert | Metric | ***\_amba-SaturationShoebox-threshold-override\_*** |
| *```resourceName```*-LatencyAlert | Metric | ***\_amba-ServiceApiLatency-threshold-override\_*** |
| *```resourceName```*-RequestsAlert | Metric | <span style="color:DarkOrange">***Not available since it uses dynamic thresholds***</span> |
| ActivityManagedHSMDelete | Activity Log | <span style="color:DarkOrange">***Not available since Activity Log based alerts do not have thresholds***</span> |
| *```resourceName```*-Availability | Metric | ***\_amba-Availability-threshold-override\_*** |
| *```resourceName```*-LatencyAlert | Metric | ***\_amba-ServiceApiLatency-threshold-override\_*** |
| *```resourceName```*-agApplicationGatewayTotalTime | Metric | <span style="color:DarkOrange">***Not available since it uses dynamic thresholds***</span> |
| *```resourceName```*-agBackendLastByteResponseTime | Metric | <span style="color:DarkOrange">***Not available since it uses dynamic thresholds***</span> |
| *```resourceName```*-agCapacityUnits | Metric | ***\_amba-CapacityUnits-threshold-override\_*** |
| *```resourceName```*-agComputeUnits | Metric | ***\_amba-ComputeUnits-threshold-override\_*** |
| *```resourceName```*-agCpuUtilization | Metric | ***\_amba-CpuUtilization-threshold-override\_*** |
| *```resourceName```*-agFailedRequests | Metric | <span style="color:DarkOrange">***Not available since it uses dynamic thresholds***</span> |
| *```resourceName```*-agResponseStatus | Metric | <span style="color:DarkOrange">***Not available since it uses dynamic thresholds***</span> |
| *```resourceName```*-agUnhealthyHostCount | Metric | ***\_amba-UnhealthyHostCount-threshold-override\_*** |
| ActivityAzureFirewallDelete | Activity Log | <span style="color:DarkOrange">***Not available since Activity Log based alerts do not have thresholds***</span> |
| *```resourceName```*-FirewallHealth | Metric | ***\_amba-FirewallHealth-threshold-override\_*** |
| *```resourceName```*-SNATPortUtilization | Metric | ***\_amba-SNATPortUtilization-threshold-override\_*** |
| *```resourceName```*-ArpAvailability | Metric | ***\_amba-ArpAvailability-threshold-override\_*** |
| *```resourceName```*-BgpAvailability | Metric | ***\_amba-BgpAvailability-threshold-override\_*** |
| *```resourceName```*-QosDropBitsInPerSecond | Metric | <span style="color:DarkOrange">***Not available since it uses dynamic thresholds***</span> |
| *```resourceName```*-QosDropBitsOutPerSecond | Metric | <span style="color:DarkOrange">***Not available since it uses dynamic thresholds***</span> |
| *```resourceName```*-GatewayERBitsInAlert | Metric | ***\_amba-ERGatewayConnectionBitsInPerSecond-threshold-override\_*** |
| *```resourceName```*-GatewayERBitsOutAlert | Metric | ***\_amba-ERGatewayConnectionBitsOutPerSecond-threshold-override\_*** |
| *```resourceName```*-GatewayERCPUAlert | Metric | ***\_amba-ExpressRouteGatewayCpuUtilization-threshold-override\_*** |
| *```resourceName```*-DirectERBitsInAlert | Metric | ***\_amba-PortBitsInPerSecond-threshold-override\_*** |
| *```resourceName```*-DirectERBitsOutAlert | Metric | ***\_amba-PortBitsOutPerSecond-threshold-override\_*** |
| *```resourceName```*-DirectERLineProtocolAlert | Metric | ***\_amba-LineProtocol-threshold-override\_*** |
| *```resourceName```*-DirectERRxLightLevelHighAlert | Metric | ***\_amba-RxLightLevel-High-threshold-override\_*** |
| *```resourceName```*-DirectERRxLightLevelLowAlert | Metric | ***\_amba-RxLightLevel-Low-threshold-override\_*** |
| *```resourceName```*-DirectERTxLightLevelHighAlert | Metric | ***\_amba-TxLightLevel-High-threshold-override\_*** |
| *```resourceName```*-DirectERTxLightLevelLowAlert | Metric | ***\_amba-TxLightLevel-Low-threshold-override\_*** |
| *```resourceName```*-BackendHealthPercentage | Metric | ***\_amba-BackendHealthPercentage-threshold-override\_*** |
| *```resourceName```*-BackendRequestLatencyAlert | Metric | <span style="color:DarkOrange">***Not available since it uses dynamic thresholds***</span> |
| *```resourceName```*-ALBDataPathAvailability | Metric | ***\_amba-VipAvailability-threshold-override\_*** |
| *```resourceName```*-ALBGlobalBackendAvailability | Metric | ***\_amba-GlobalBackendAvailability-threshold-override\_*** |
| *```resourceName```*-ALBHealthProbeStatus | Metric | ***\_amba-DipAvailability-threshold-override\_*** |
| *```resourceName```*-ALBUsedSNATPorts | Metric | ***\_amba-UsedSNATPorts-threshold-override\_*** |
| ActivityNSGDelete | Activity Log | <span style="color:DarkOrange">***Not available since Activity Log based alerts do not have thresholds***</span> |
| *```resourceName```*-CapacityUtilizationAlert | Metric | ***\_amba-VirtualNetworkLinkCapacityUtilization-threshold-override\_*** |
| *```resourceName```*-QueryVolumeAlert | Metric | ***\_amba-QueryVolume-threshold-override\_*** |
| *```resourceName```*-RecordSet_Capacity_Utilization | Metric | ***\_amba-RecordSetCapacityUtilization-threshold-override\_*** |
| *```resourceName```*-RequestsAlert | Metric | ***\_amba-VirtualNetworkWithRegistrationCapacityUtilization-threshold-override\_*** |
| *```resourceName```*-BytesInDDOSAlert | Metric | ***\_amba-bytesinddos-threshold-override\_*** |
| *```resourceName```*-DDOS_Attack | Metric | ***\_amba-ifunderddosattack-threshold-override\_*** |
| *```resourceName```*-PacketsInDDosAlert | Metric | ***\_amba-PacketsInDDoS-threshold-override\_*** |
| *```resourceName```*-VIPAvailabityAlert | Metric | ***\_amba-VipAvailability-threshold-override\_*** |
| ActivityUDRUpdate | Activity Log | <span style="color:DarkOrange">***Not available since Activity Log based alerts do not have thresholds***</span> |
| *```resourceName```*-EndpointHealthAlert | Metric | ***\_amba-EndpointHealth-threshold-override\_*** |
| *```resourceName```*-TunnelBandwidthAlert | Metric | ***\_amba-TunnelAverageBandwidth-threshold-override\_*** |
| *```resourceName```*-TunnelEgressAlert | Metric | ***\_amba-TunnelEgressBytes-threshold-override\_*** |
| *```resourceName```*-TunnelEgressPacketDropCountAlert | Metric | <span style="color:DarkOrange">***Not available since it uses dynamic thresholds***</span> |
| *```resourceName```*-TunnelEgressPacketDropTSMismatchAlert | Metric | <span style="color:DarkOrange">***Not available since it uses dynamic thresholds***</span> |
| *```resourceName```*-GatewayERBitsAlert | Metric | ***\_amba-ExpressRouteGatewayBitsPerSecond-threshold-override\_*** |
| *```resourceName```*-GatewayERCPUAlert | Metric | ***\_amba-ExpressRouteGatewayCpuUtilization-threshold-override\_*** |
| *```resourceName```*-TunnelIngressAlert | Metric | ***\_amba-TunnelIngressBytes-threshold-override\_*** |
| *```resourceName```*-TunnelIngressPacketDropCountAlert | Metric | <span style="color:DarkOrange">***Not available since it uses dynamic thresholds***</span> |
| *```resourceName```*-TunnelIngressPacketDropTSMismatchAlert | Metric | <span style="color:DarkOrange">***Not available since it uses dynamic thresholds***</span> |
| *```resourceName```*-DDOSAttackAlert | Metric | ***\_amba-ifunderddosattack-threshold-override\_*** |
| ActivityVPNGatewayDelete | Activity Log | <span style="color:DarkOrange">***Not available since Activity Log based alerts do not have thresholds***</span> |
| *```resourceName```*-GatewayBandwidthAlert | Metric | ***\_amba-tunnelaveragebandwidth-threshold-override\_*** |
| *```resourceName```*-BGPPeerStatusAlert | Metric | ***\_amba-bgppeerstatus-threshold-override\_*** |
| *```resourceName```*-TunnelEgressAlert | Metric | ***\_amba-tunnelegressbytes-threshold-override\_*** |
| *```resourceName```*-TunnelEgressPacketDropCountAlert | Metric | <span style="color:DarkOrange">***Not available since it uses dynamic thresholds***</span> |
| *```resourceName```*-TunnelEgressPacketDropTSMismatchAlert | Metric | <span style="color:DarkOrange">***Not available since it uses dynamic thresholds***</span> |
| *```resourceName```*-TunnelIngressAlert | Metric | ***\_amba-tunnelingressbytes-threshold-override\_*** |
| *```resourceName```*-TunnelIngressPacketDropCount | Metric | <span style="color:DarkOrange">***Not available since it uses dynamic thresholds***</span> |
| *```resourceName```*-TunnelIngressPacketDropTSMismatchAlert | Metric | <span style="color:DarkOrange">***Not available since it uses dynamic thresholds***</span> |
| ActivityLAWorkspaceDelete | Activity Log | <span style="color:DarkOrange">***Not available since Activity Log based alerts do not have thresholds***</span> |
| ActivityLAWorkspaceRegenKey | Activity Log | <span style="color:DarkOrange">***Not available since Activity Log based alerts do not have thresholds***</span> |
| RSV BackupHealth | ??? | Not available
| *```subscription().displayName```*-ResourceHealthUnhealthyAlert | Activity Log | <span style="color:DarkOrange">***Not available since Activity Log based alerts do not have thresholds***</span> |
| *```subscription().displayName```*-ServiceHealthHealth | Activity Log | <span style="color:DarkOrange">***Not available since Activity Log based alerts do not have thresholds***</span> |
| *```subscription().displayName```*-ServiceHealthIncident | Activity Log | <span style="color:DarkOrange">***Not available since Activity Log based alerts do not have thresholds***</span> |
| *```subscription().displayName```*-ServiceHealthMaintenance | Activity Log | <span style="color:DarkOrange">***Not available since Activity Log based alerts do not have thresholds***</span> |
| *```subscription().displayName```*-ServiceSecurityIncident | Activity Log | <span style="color:DarkOrange">***Not available since Activity Log based alerts do not have thresholds***</span> |
| ActivitySADelete | Activity Log | <span style="color:DarkOrange">***Not available since Activity Log based alerts do not have thresholds***</span> |
| *```resourceName```*-AvailabilityAlert | Metric | ***\_amba-Availability-threshold-override\_*** |
| *```resourceName```*-CpuPercentage | Metric | ***\_amba-CpuPercentage-threshold-override\_*** |
| *```resourceName```*-DiskQueueLengthAlert | Metric | <span style="color:DarkOrange">***Not available since it uses dynamic thresholds***</span> |
| *```resourceName```*-HttpQueueLengthAlert | Metric | <span style="color:DarkOrange">***Not available since it uses dynamic thresholds***</span> |
| *```resourceName```*-MemoryPercentage | Metric | ***\_amba-MemoryPercentage-threshold-override\_*** |
