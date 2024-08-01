---
title: Metrics alert table
geekdocHidden: true
---

| Resource Type | Alert Name | Alert Type | Override Tag name |
| ------------- | ---------- | ---------- | ----------------- |
| Virtual machine | *```resourceName```*-AvailableMemoryAlert | Metrics | ***\_amba-AvailableMemoryBytes-threshold-override\_*** |
| Automation Account | *```resourceName```*-TotalJob | Metrics | ***\_amba-TotalJob-threshold-override\_*** |
| Front Door and CDN profile | *```resourceName```*-OriginHealthPercentage | Metrics | ***\_amba-OriginHealthPercentage-threshold-override\_*** |
| Front Door and CDN profile | *```resourceName```*-OriginLatencyAlert | Metrics | <span style="color:DarkOrange">***Not available since it uses dynamic thresholds***</span> |
| Front Door and CDN profile | *```resourceName```*-Percentage4XXAlert | Metrics | <span style="color:DarkOrange">***Not available since it uses dynamic thresholds***</span> |
| Front Door and CDN profile | *```resourceName```*-Percentage5XXAlert | Metrics | <span style="color:DarkOrange">***Not available since it uses dynamic thresholds***</span> |
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
| Firewall | ActivityAzureFirewallDelete | Activity Log | <span style="color:DarkOrange">***Not available since Activity Log based alerts do not have thresholds***</span> |
| Firewall | *```resourceName```*-FirewallHealth | Metrics | ***\_amba-FirewallHealth-threshold-override\_*** |
| Firewall | *```resourceName```*-SNATPortUtilization | Metrics | ***\_amba-SNATPortUtilization-threshold-override\_*** |
| ExpressRoute circuit | *```resourceName```*-ArpAvailability | Metrics | ***\_amba-ArpAvailability-threshold-override\_*** |
| ExpressRoute circuit | *```resourceName```*-BgpAvailability | Metrics | ***\_amba-BgpAvailability-threshold-override\_*** |
| ExpressRoute circuit | *```resourceName```*-QosDropBitsInPerSecond | Metrics | <span style="color:DarkOrange">***Not available since it uses dynamic thresholds***</span> |
| ExpressRoute circuit | *```resourceName```*-QosDropBitsOutPerSecond | Metrics | <span style="color:DarkOrange">***Not available since it uses dynamic thresholds***</span> |
| ExpressRoute gateway | *```resourceName```*-GatewayERBitsInAlert | Metrics | ***\_amba-ERGatewayConnectionBitsInPerSecond-threshold-override\_*** |
| ExpressRoute gateway | *```resourceName```*-GatewayERBitsOutAlert | Metrics | ***\_amba-ERGatewayConnectionBitsOutPerSecond-threshold-override\_*** |
| ExpressRoute gateway | *```resourceName```*-GatewayERCPUAlert | Metrics | ***\_amba-ExpressRouteGatewayCpuUtilization-threshold-override\_*** |
| ExpressRoute port | *```resourceName```*-DirectERBitsInAlert | Metrics | ***\_amba-PortBitsInPerSecond-threshold-override\_*** |
| ExpressRoute port | *```resourceName```*-DirectERBitsOutAlert | Metrics | ***\_amba-PortBitsOutPerSecond-threshold-override\_*** |
| ExpressRoute port | *```resourceName```*-DirectERLineProtocolAlert | Metrics | ***\_amba-LineProtocol-threshold-override\_*** |
| ExpressRoute port | *```resourceName```*-DirectERRxLightLevelHighAlert | Metrics | ***\_amba-RxLightLevel-High-threshold-override\_*** |
| ExpressRoute port | *```resourceName```*-DirectERRxLightLevelLowAlert | Metrics | ***\_amba-RxLightLevel-Low-threshold-override\_*** |
| ExpressRoute port | *```resourceName```*-DirectERTxLightLevelHighAlert | Metrics | ***\_amba-TxLightLevel-High-threshold-override\_*** |
| ExpressRoute port | *```resourceName```*-DirectERTxLightLevelLowAlert | Metrics | ***\_amba-TxLightLevel-Low-threshold-override\_*** |
| Front Door | *```resourceName```*-BackendHealthPercentage | Metrics | ***\_amba-BackendHealthPercentage-threshold-override\_*** |
| Front Door | *```resourceName```*-BackendRequestLatencyAlert | Metrics | <span style="color:DarkOrange">***Not available since it uses dynamic thresholds***</span> |
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
| Traffic Manager profile | *```resourceName```*-EndpointHealthAlert | Metrics | ***\_amba-EndpointHealth-threshold-override\_*** |
| Virtual network gateway | *```resourceName```*-TunnelBandwidthAlert | Metrics | ***\_amba-TunnelAverageBandwidth-threshold-override\_*** |
| Virtual network gateway | *```resourceName```*-TunnelEgressAlert | Metrics | ***\_amba-TunnelEgressBytes-threshold-override\_*** |
| Virtual network gateway | *```resourceName```*-TunnelEgressPacketDropCountAlert | Metrics | <span style="color:DarkOrange">***Not available since it uses dynamic thresholds***</span> |
| Virtual network gateway | *```resourceName```*-TunnelEgressPacketDropTSMismatchAlert | Metrics | <span style="color:DarkOrange">***Not available since it uses dynamic thresholds***</span> |
| Virtual network gateway | *```resourceName```*-GatewayERBitsAlert | Metrics | ***\_amba-ExpressRouteGatewayBitsPerSecond-threshold-override\_*** |
| Virtual network gateway | *```resourceName```*-GatewayERCPUAlert | Metrics | ***\_amba-ExpressRouteGatewayCpuUtilization-threshold-override\_*** |
| Virtual network gateway | *```resourceName```*-TunnelIngressAlert | Metrics | ***\_amba-TunnelIngressBytes-threshold-override\_*** |
| Virtual network gateway | *```resourceName```*-TunnelIngressPacketDropCountAlert | Metrics | <span style="color:DarkOrange">***Not available since it uses dynamic thresholds***</span> |
| Virtual network gateway | *```resourceName```*-TunnelIngressPacketDropTSMismatchAlert | Metrics | <span style="color:DarkOrange">***Not available since it uses dynamic thresholds***</span> |
| Virtual network | *```resourceName```*-DDOSAttackAlert | Metrics | ***\_amba-ifunderddosattack-threshold-override\_*** |
| VPN Gateway | ActivityVPNGatewayDelete | Activity Log | <span style="color:DarkOrange">***Not available since Activity Log based alerts do not have thresholds***</span> |
| VPN Gateway | *```resourceName```*-GatewayBandwidthAlert | Metrics | ***\_amba-tunnelaveragebandwidth-threshold-override\_*** |
| VPN Gateway | *```resourceName```*-BGPPeerStatusAlert | Metrics | ***\_amba-bgppeerstatus-threshold-override\_*** |
| VPN Gateway | *```resourceName```*-TunnelEgressAlert | Metrics | ***\_amba-tunnelegressbytes-threshold-override\_*** |
| VPN Gateway | *```resourceName```*-TunnelEgressPacketDropCountAlert | Metrics | <span style="color:DarkOrange">***Not available since it uses dynamic thresholds***</span> |
| VPN Gateway | *```resourceName```*-TunnelEgressPacketDropTSMismatchAlert | Metrics | <span style="color:DarkOrange">***Not available since it uses dynamic thresholds***</span> |
| VPN Gateway | *```resourceName```*-TunnelIngressAlert | Metrics | ***\_amba-tunnelingressbytes-threshold-override\_*** |
| VPN Gateway | *```resourceName```*-TunnelIngressPacketDropCount | Metrics | <span style="color:DarkOrange">***Not available since it uses dynamic thresholds***</span> |
| VPN Gateway | *```resourceName```*-TunnelIngressPacketDropTSMismatchAlert | Metrics | <span style="color:DarkOrange">***Not available since it uses dynamic thresholds***</span> |
| Log Analytics workspace | ActivityLAWorkspaceDelete | Activity Log | <span style="color:DarkOrange">***Not available since Activity Log based alerts do not have thresholds***</span> |
| Log Analytics workspace | ActivityLAWorkspaceRegenKey | Activity Log | <span style="color:DarkOrange">***Not available since Activity Log based alerts do not have thresholds***</span> |
| Subscription | ResourceHealthUnhealthyAlert | Resource health | <span style="color:DarkOrange">***Not available since Activity Log based alerts do not have thresholds***</span> |
| Subscription | ServiceHealthHealth | Service health | <span style="color:DarkOrange">***Not available since Activity Log based alerts do not have thresholds***</span> |
| Subscription | ServiceHealthIncident | Service health | <span style="color:DarkOrange">***Not available since Activity Log based alerts do not have thresholds***</span> |
| Subscription | ServiceHealthMaintenance | Service health | <span style="color:DarkOrange">***Not available since Activity Log based alerts do not have thresholds***</span> |
| Subscription | ServiceSecurityIncident | Service health | <span style="color:DarkOrange">***Not available since Activity Log based alerts do not have thresholds***</span> |
| Storage account | ActivitySADelete | Activity Log | <span style="color:DarkOrange">***Not available since Activity Log based alerts do not have thresholds***</span> |
| Storage account | *```resourceName```*-AvailabilityAlert | Metrics | ***\_amba-Availability-threshold-override\_*** |
| App Service plan | *```resourceName```*-CpuPercentage | Metrics | ***\_amba-CpuPercentage-threshold-override\_*** |
| App Service plan | *```resourceName```*-DiskQueueLengthAlert | Metrics | <span style="color:DarkOrange">***Not available since it uses dynamic thresholds***</span> |
| App Service plan | *```resourceName```*-HttpQueueLengthAlert | Metrics | <span style="color:DarkOrange">***Not available since it uses dynamic thresholds***</span> |
| App Service plan | *```resourceName```*-MemoryPercentage | Metrics | ***\_amba-MemoryPercentage-threshold-override\_*** |
