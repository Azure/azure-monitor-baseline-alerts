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

| Resource Type | Alert Name | Alert Type | Override Tag name |
| ------------- | ---------- | ---------- | ----------------- |
| Hybrid Machine | *```subscription().displayName```*-HybridVMHighDataDiskReadLatencyAlert | _Log search_ | ***\_amba-ReadLatencyMs-Data-threshold-override\_*** |
| Hybrid Machine | *```subscription().displayName```*-HybridVMLowDataDiskSpaceAlert | _Log search_ | ***\_amba-FreeSpacePercentage-Data-threshold-override\_*** |
| Hybrid Machine | *```subscription().displayName```*-HybridVMHighDataDiskWriteLatencyAlert | _Log search_ | ***\_amba-WriteLatencyMs-Data-threshold-override\_*** |
| Hybrid Machine | *```subscription().displayName```*-HybridVMDisconnectedAlert | _Log search_ | ***\_amba-Disconnected-threshold-override\_*** |
| Hybrid Machine | *```subscription().displayName```*-HybridVMHeartBeatAlert | _Log search_ | ***\_amba-Heartbeat-threshold-override\_*** |
| Hybrid Machine | *```subscription().displayName```*-HybridVMHighNetworkInAlert | _Log search_ | ***\_amba-ReadBytesPerSecond-threshold-override\_*** |
| Hybrid Machine | *```subscription().displayName```*-HybridVMHighNetworkOutAlert | _Log search_ | ***\_amba-WriteBytesPerSecond-threshold-override\_*** |
| Hybrid Machine | *```subscription().displayName```*-HybridVMHighOSDiskReadLatencyAlert | _Log search_ | ***\_amba-ReadLatencyMs-OS-threshold-override\_*** |
| Hybrid Machine | *```subscription().displayName```*-HybridVMLowOSDiskSpaceAlert | _Log search_ | ***\_amba-FreeSpacePercentage-OS-threshold-override\_*** |
| Hybrid Machine | *```subscription().displayName```*-HybridVMHighOSDiskWriteLatencyAlert | _Log search_ | ***\_amba-WriteLatencyMs-OS-threshold-override\_*** |
| Hybrid Machine | *```subscription().displayName```*-HybridVMHighCPUAlert | _Log search_ | ***\_amba-UtilizationPercentage-threshold-override\_*** |
| Hybrid Machine | *```subscription().displayName```*-HybridVMLowMemoryAlert | _Log search_ | ***\_amba-AvailableMemoryPercentage-threshold-override\_*** |
| Virtual Machine | *```subscription().displayName```*-VMHighDataDiskReadLatencyAlert | _Log search_ | ***\_amba-ReadLatencyMs-Data-threshold-override\_*** |
| Virtual Machine | *```subscription().displayName```*-VMLowDataDiskSpaceAlert | _Log search_ | ***\_amba-FreeSpacePercentage-Data-threshold-override\_*** |
| Virtual Machine | *```subscription().displayName```*-VMHighDataDiskWriteLatencyAlert | _Log search_ | ***\_amba-WriteLatencyMs-Data-threshold-override\_*** |
| Virtual Machine | *```subscription().displayName```*-VMHeartBeatAlert | _Log search_ | ***\_amba-Heartbeat-threshold-override\_*** |
| Virtual Machine | *```subscription().displayName```*-VMHighNetworkInAlert | _Log search_ | ***\_amba-ReadBytesPerSecond-threshold-override\_*** |
| Virtual Machine | *```subscription().displayName```*-VMHighNetworkOutAlert | _Log search_ | ***\_amba-WriteBytesPerSecond-threshold-override\_*** |
| Virtual Machine | *```subscription().displayName```*-VMHighOSDiskReadLatencyAlert | _Log search_ | ***\_amba-ReadLatencyMs-OS-threshold-override\_*** |
| Virtual Machine | *```subscription().displayName```*-VMLowOSDiskSpaceAlert | _Log search_ | ***\_amba-FreeSpacePercentage-OS-threshold-override\_*** |
| Virtual Machine | *```subscription().displayName```*-VMHighOSDiskWriteLatencyAlert | _Log search_ | ***\_amba-WriteLatencyMs-OS-threshold-override\_*** |
| Virtual Machine | *```subscription().displayName```*-VMHighCPUAlert | _Log search_ | ***\_amba-UtilizationPercentage-threshold-override\_*** |
| Virtual Machine | *```subscription().displayName```*-VMLowMemoryAlert | _Log search_ | ***\_amba-AvailableMemoryPercentage-threshold-override\_*** |
| Virtual Machine | *```resourceName```*-DailyCapLimitReachedAlert | _Log search_ |	***Not available since threshold will always be ```0```*** |

</br>

### Metric alerts table

| Resource Type | Alert Name | Alert Type | Override Tag name |
|--------------|------------|------------|-------------------|
| Virtual machine | *```resourceName```*-AvailableMemoryAlert | Metrics | ***\_amba-AvailableMemoryBytes-threshold-override\_*** |
| Automation Account | *```resourceName```*-TotalJob | Metrics | ***\_amba-TotalJob-threshold-override\_*** |
| Front Door and CDN profile | *```resourceName```*-OriginHealthPercentage | Metrics | ***\_amba-OriginHealthPercentage-threshold-override\_*** |
| Front Door and CDN profile | *```resourceName```*-OriginLatencyAlert | Metrics | ***\_amba-OriginLatency-threshold-override\_*** |
| Front Door and CDN profile | *```resourceName```*-Percentage4XXAlert | Metrics | ***\_amba-Percentage4XX-threshold-override\_*** |
| Front Door and CDN profile | *```resourceName```*-Percentage5XXAlert | Metrics | ***\_amba-Percentage5XX-threshold-override\_*** |
| Key vault | ActivityKeyVaultDelete | Activity Log | <span style="color:DarkOrange">***Not available since Activity Log based alerts do not have thresholds***</span> |
| Key vault | *```resourceName```*-Availability | Metrics | ***\_amba-Availability-threshold-override\_*** |
| Key vault | *```resourceName```*-CapacityAlert | Metrics | ***\_amba-SaturationShoebox-threshold-override\_*** |
| Key vault | *```resourceName```*-LatencyAlert | Metrics | ***\_amba-ServiceApiLatency-threshold-override\_*** |
| Key vault | *```resourceName```*-RequestsAlert | Metrics | <span style="color:DarkOrange">***Not available since it uses dynamic thresholds***</span> |
| Azure Key Vault Managed HSM | ActivityManagedHSMDelete | Activity Log | <span style="color:DarkOrange">***Not available since Activity Log based alerts do not have thresholds***</span> |
| Azure Key Vault Managed HSM | *```resourceName```*-Availability | Metrics | ***\_amba-Availability-threshold-override\_*** |
| Azure Key Vault Managed HSM | *```resourceName```*-LatencyAlert | Metrics | ***\_amba-ServiceApiLatency-threshold-override\_*** |
| Application gateway | *```resourceName```*-agApplicationGatewayTotalTime | Metrics | <span style="color:DarkOrange">***Not available since it uses dynamic thresholds***</span> |
| Application gateway | *```resourceName```*-agBackendLastByteResponseTime | Metrics | <span style="color:DarkOrange">***Not available since it uses dynamic thresholds***</span> |
| Application gateway | *```resourceName```*-agCapacityUnits | Metrics | ***\_amba-CapacityUnits-threshold-override\_*** |
| Application gateway | *```resourceName```*-agComputeUnits | Metrics | ***\_amba-ComputeUnits-threshold-override\_*** |
| Application gateway | *```resourceName```*-agCpuUtilization | Metrics | ***\_amba-CpuUtilization-threshold-override\_*** |
| Application gateway | *```resourceName```*-agFailedRequests | Metrics | <span style="color:DarkOrange">***Not available since it uses dynamic thresholds***</span> |
| Application gateway | *```resourceName```*-agResponseStatus | Metrics | <span style="color:DarkOrange">***Not available since it uses dynamic thresholds***</span> |
| Application gateway | *```resourceName```*-agUnhealthyHostCount | Metrics | ***\_amba-UnhealthyHostCount-threshold-override\_*** |
| | ActivityAzureFirewallDelete | Activity Log | <span style="color:DarkOrange">***Not available since Activity Log based alerts do not have thresholds***</span> |
| | *```resourceName```*-FirewallHealth | Metrics | ***\_amba-FirewallHealth-threshold-override\_*** |
| | *```resourceName```*-SNATPortUtilization | Metrics | ***\_amba-SNATPortUtilization-threshold-override\_*** |
| | *```resourceName```*-ArpAvailability | Metrics | ***\_amba-ArpAvailability-threshold-override\_*** |
| | *```resourceName```*-BgpAvailability | Metrics | ***\_amba-BgpAvailability-threshold-override\_*** |
| | *```resourceName```*-QosDropBitsInPerSecond | Metrics | <span style="color:DarkOrange">***Not available since it uses dynamic thresholds***</span> |
| | *```resourceName```*-QosDropBitsOutPerSecond | Metrics | <span style="color:DarkOrange">***Not available since it uses dynamic thresholds***</span> |
| | *```resourceName```*-GatewayERBitsInAlert | Metrics | ***\_amba-ERGatewayConnectionBitsInPerSecond-threshold-override\_*** |
| | *```resourceName```*-GatewayERBitsOutAlert | Metrics | ***\_amba-ERGatewayConnectionBitsOutPerSecond-threshold-override\_*** |
| | *```resourceName```*-GatewayERCPUAlert | Metrics | ***\_amba-ExpressRouteGatewayCpuUtilization-threshold-override\_*** |
| | *```resourceName```*-DirectERBitsInAlert | Metrics | ***\_amba-PortBitsInPerSecond-threshold-override\_*** |
| | *```resourceName```*-DirectERBitsOutAlert | Metrics | ***\_amba-PortBitsOutPerSecond-threshold-override\_*** |
| | *```resourceName```*-DirectERLineProtocolAlert | Metrics | ***\_amba-LineProtocol-threshold-override\_*** |
| | *```resourceName```*-DirectERRxLightLevelHighAlert | Metrics | ***\_amba-RxLightLevel-High-threshold-override\_*** |
| | *```resourceName```*-DirectERRxLightLevelLowAlert | Metrics | ***\_amba-RxLightLevel-Low-threshold-override\_*** |
| | *```resourceName```*-DirectERTxLightLevelHighAlert | Metrics | ***\_amba-TxLightLevel-High-threshold-override\_*** |
| | *```resourceName```*-DirectERTxLightLevelLowAlert | Metrics | ***\_amba-TxLightLevel-Low-threshold-override\_*** |
| | *```resourceName```*-BackendHealthPercentage | Metrics | ***\_amba-BackendHealthPercentage-threshold-override\_*** |
| | *```resourceName```*-BackendRequestLatencyAlert | Metrics | <span style="color:DarkOrange">***Not available since it uses dynamic thresholds***</span> |
| Load balancer | *```resourceName```*-ALBDataPathAvailability | Metrics | ***\_amba-VipAvailability-threshold-override\_*** |
| Load balancer | *```resourceName```*-ALBGlobalBackendAvailability | Metrics | ***\_amba-GlobalBackendAvailability-threshold-override\_*** |
| Load balancer | *```resourceName```*-ALBHealthProbeStatus | Metrics | ***\_amba-DipAvailability-threshold-override\_*** |
| Load balancer | *```resourceName```*-ALBUsedSNATPorts | Metrics | ***\_amba-UsedSNATPorts-threshold-override\_*** |
| Network security group | ActivityNSGDelete | Activity Log | <span style="color:DarkOrange">***Not available since Activity Log based alerts do not have thresholds***</span> |
| Private DNS zone | *```resourceName```*-CapacityUtilizationAlert | Metrics | ***\_amba-VirtualNetworkLinkCapacityUtilization-threshold-override\_*** |
| Private DNS zone | *```resourceName```*-QueryVolumeAlert | Metrics | ***\_amba-QueryVolume-threshold-override\_*** |
| Private DNS zone | *```resourceName```*-RecordSet_Capacity_Utilization | Metrics | ***\_amba-RecordSetCapacityUtilization-threshold-override\_*** |
| Private DNS zone | *```resourceName```*-RequestsAlert | Metrics | ***\_amba-VirtualNetworkWithRegistrationCapacityUtilization-threshold-override\_*** |
| Public IP address | *```resourceName```*-BytesInDDOSAlert | Metrics | ***\_amba-bytesinddos-threshold-override\_*** |
| Public IP address | *```resourceName```*-DDOS_Attack | Metrics | ***\_amba-ifunderddosattack-threshold-override\_*** |
| Public IP address | *```resourceName```*-PacketsInDDosAlert | Metrics | ***\_amba-PacketsInDDoS-threshold-override\_*** |
| Public IP address | *```resourceName```*-VIPAvailabityAlert | Metrics | ***\_amba-VipAvailability-threshold-override\_*** |
| Route table | ActivityUDRUpdate | Activity Log | <span style="color:DarkOrange">***Not available since Activity Log based alerts do not have thresholds***</span> |
| | *```resourceName```*-EndpointHealthAlert | Metrics | ***\_amba-EndpointHealth-threshold-override\_*** |
| | *```resourceName```*-TunnelBandwidthAlert | Metrics | ***\_amba-TunnelAverageBandwidth-threshold-override\_*** |
| | *```resourceName```*-TunnelEgressAlert | Metrics | ***\_amba-TunnelEgressBytes-threshold-override\_*** |
| | *```resourceName```*-TunnelEgressPacketDropCountAlert | Metrics | <span style="color:DarkOrange">***Not available since it uses dynamic thresholds***</span> |
| | *```resourceName```*-TunnelEgressPacketDropTSMismatchAlert | Metrics | <span style="color:DarkOrange">***Not available since it uses dynamic thresholds***</span> |
| | *```resourceName```*-GatewayERBitsAlert | Metrics | ***\_amba-ExpressRouteGatewayBitsPerSecond-threshold-override\_*** |
| | *```resourceName```*-GatewayERCPUAlert | Metrics | ***\_amba-ExpressRouteGatewayCpuUtilization-threshold-override\_*** |
| | *```resourceName```*-TunnelIngressAlert | Metrics | ***\_amba-TunnelIngressBytes-threshold-override\_*** |
| | *```resourceName```*-TunnelIngressPacketDropCountAlert | Metrics | <span style="color:DarkOrange">***Not available since it uses dynamic thresholds***</span> |
| | *```resourceName```*-TunnelIngressPacketDropTSMismatchAlert | Metrics | <span style="color:DarkOrange">***Not available since it uses dynamic thresholds***</span> |
| Virtual network | *```resourceName```*-DDOSAttackAlert | Metrics | ***\_amba-ifunderddosattack-threshold-override\_*** |
| | ActivityVPNGatewayDelete | Activity Log | <span style="color:DarkOrange">***Not available since Activity Log based alerts do not have thresholds***</span> |
| | *```resourceName```*-GatewayBandwidthAlert | Metrics | ***\_amba-tunnelaveragebandwidth-threshold-override\_*** |
| | *```resourceName```*-BGPPeerStatusAlert | Metrics | ***\_amba-bgppeerstatus-threshold-override\_*** |
| | *```resourceName```*-TunnelEgressAlert | Metrics | ***\_amba-tunnelegressbytes-threshold-override\_*** |
| | *```resourceName```*-TunnelEgressPacketDropCountAlert | Metrics | <span style="color:DarkOrange">***Not available since it uses dynamic thresholds***</span> |
| | *```resourceName```*-TunnelEgressPacketDropTSMismatchAlert | Metrics | <span style="color:DarkOrange">***Not available since it uses dynamic thresholds***</span> |
| | *```resourceName```*-TunnelIngressAlert | Metrics | ***\_amba-tunnelingressbytes-threshold-override\_*** |
| | *```resourceName```*-TunnelIngressPacketDropCount | Metrics | <span style="color:DarkOrange">***Not available since it uses dynamic thresholds***</span> |
| | *```resourceName```*-TunnelIngressPacketDropTSMismatchAlert | Metrics | <span style="color:DarkOrange">***Not available since it uses dynamic thresholds***</span> |
| Log Analytics workspace | ActivityLAWorkspaceDelete | Activity Log | <span style="color:DarkOrange">***Not available since Activity Log based alerts do not have thresholds***</span> |
| Log Analytics workspace | ActivityLAWorkspaceRegenKey | Activity Log | <span style="color:DarkOrange">***Not available since Activity Log based alerts do not have thresholds***</span> |
| Recovery Services vault | RSV BackupHealth | ??? | Not available
| Subscription | *```subscription().displayName```*-ResourceHealthUnhealthyAlert | Resource health | <span style="color:DarkOrange">***Not available since Activity Log based alerts do not have thresholds***</span> |
| Subscription | *```subscription().displayName```*-ServiceHealthHealth | Service health | <span style="color:DarkOrange">***Not available since Activity Log based alerts do not have thresholds***</span> |
| Subscription | *```subscription().displayName```*-ServiceHealthIncident | Service health | <span style="color:DarkOrange">***Not available since Activity Log based alerts do not have thresholds***</span> |
| Subscription | *```subscription().displayName```*-ServiceHealthMaintenance | Service health | <span style="color:DarkOrange">***Not available since Activity Log based alerts do not have thresholds***</span> |
| Subscription | *```subscription().displayName```*-ServiceSecurityIncident | Service health | <span style="color:DarkOrange">***Not available since Activity Log based alerts do not have thresholds***</span> |
| Storage account | ActivitySADelete | Activity Log | <span style="color:DarkOrange">***Not available since Activity Log based alerts do not have thresholds***</span> |
| Storage account | *```resourceName```*-AvailabilityAlert | Metrics | ***\_amba-Availability-threshold-override\_*** |
| | *```resourceName```*-CpuPercentage | Metrics | ***\_amba-CpuPercentage-threshold-override\_*** |
| | *```resourceName```*-DiskQueueLengthAlert | Metrics | <span style="color:DarkOrange">***Not available since it uses dynamic thresholds***</span> |
| | *```resourceName```*-HttpQueueLengthAlert | Metrics | <span style="color:DarkOrange">***Not available since it uses dynamic thresholds***</span> |
| | *```resourceName```*-MemoryPercentage | Metrics | ***\_amba-MemoryPercentage-threshold-override\_*** |
