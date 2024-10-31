---
title: Metrics alert table
geekdocHidden: true
---

| Resource Type | Alert Name | Alert Type | Override Tag name |
| ------------- | ---------- | ---------- | ----------------- |
| Virtual machine | *```resourceName```*-AvailableMemoryAlert | Metrics | ***\_amba-AvailableMemoryBytes-threshold-Override\_*** |
| Automation Account | *```resourceName```*-TotalJob | Metrics | ***\_amba-TotalJob-threshold-Override\_*** |
| Front Door and CDN profile | *```resourceName```*-OriginHealthPercentage | Metrics | ***\_amba-OriginHealthPercentage-threshold-Override\_*** |
| Front Door and CDN profile | *```resourceName```*-OriginLatencyAlert | Metrics | <span style="color:DarkOrange">***Not available since it uses dynamic thresholds***</span> |
| Front Door and CDN profile | *```resourceName```*-Percentage4XXAlert | Metrics | <span style="color:DarkOrange">***Not available since it uses dynamic thresholds***</span> |
| Front Door and CDN profile | *```resourceName```*-Percentage5XXAlert | Metrics | <span style="color:DarkOrange">***Not available since it uses dynamic thresholds***</span> |
| Key vault | ActivityKeyVaultDelete | Activity Log | <span style="color:DarkOrange">***Not available since Activity Log based alerts do not have thresholds***</span> |
| Key vault | *```resourceName```*-Availability | Metrics | ***\_amba-Availability-threshold-Override\_*** |
| Key vault | *```resourceName```*-CapacityAlert | Metrics | ***\_amba-SaturationShoebox-threshold-Override\_*** |
| Key vault | *```resourceName```*-LatencyAlert | Metrics | ***\_amba-ServiceApiLatency-threshold-Override\_*** |
| Key vault | *```resourceName```*-RequestsAlert | Metrics | <span style="color:DarkOrange">***Not available since it uses dynamic thresholds***</span> |
| Azure Key Vault Managed HSM | ActivityManagedHSMDelete | Activity Log | <span style="color:DarkOrange">***Not available since Activity Log based alerts do not have thresholds***</span> |
| Azure Key Vault Managed HSM | *```resourceName```*-Availability | Metrics | ***\_amba-Availability-threshold-Override\_*** |
| Azure Key Vault Managed HSM | *```resourceName```*-LatencyAlert | Metrics | ***\_amba-ServiceApiLatency-threshold-Override\_*** |
| Application gateway | *```resourceName```*-agApplicationGatewayTotalTime | Metrics | <span style="color:DarkOrange">***Not available since it uses dynamic thresholds***</span> |
| Application gateway | *```resourceName```*-agBackendLastByteResponseTime | Metrics | <span style="color:DarkOrange">***Not available since it uses dynamic thresholds***</span> |
| Application gateway | *```resourceName```*-agCapacityUnits | Metrics | ***\_amba-CapacityUnits-threshold-Override\_*** |
| Application gateway | *```resourceName```*-agComputeUnits | Metrics | ***\_amba-ComputeUnits-threshold-Override\_*** |
| Application gateway | *```resourceName```*-agCpuUtilization | Metrics | ***\_amba-CpuUtilization-threshold-Override\_*** |
| Application gateway | *```resourceName```*-agFailedRequests | Metrics | <span style="color:DarkOrange">***Not available since it uses dynamic thresholds***</span> |
| Application gateway | *```resourceName```*-agResponseStatus | Metrics | <span style="color:DarkOrange">***Not available since it uses dynamic thresholds***</span> |
| Application gateway | *```resourceName```*-agUnhealthyHostCount | Metrics | ***\_amba-UnhealthyHostCount-threshold-Override\_*** |
| Firewall | ActivityAzureFirewallDelete | Activity Log | <span style="color:DarkOrange">***Not available since Activity Log based alerts do not have thresholds***</span> |
| Firewall | *```resourceName```*-FirewallHealth | Metrics | ***\_amba-FirewallHealth-threshold-Override\_*** |
| Firewall | *```resourceName```*-SNATPortUtilization | Metrics | ***\_amba-SNATPortUtilization-threshold-Override\_*** |
| ExpressRoute circuit | *```resourceName```*-ArpAvailability | Metrics | ***\_amba-ArpAvailability-threshold-Override\_*** |
| ExpressRoute circuit | *```resourceName```*-BgpAvailability | Metrics | ***\_amba-BgpAvailability-threshold-Override\_*** |
| ExpressRoute circuit | *```resourceName```*-QosDropBitsInPerSecond | Metrics | <span style="color:DarkOrange">***Not available since it uses dynamic thresholds***</span> |
| ExpressRoute circuit | *```resourceName```*-QosDropBitsOutPerSecond | Metrics | <span style="color:DarkOrange">***Not available since it uses dynamic thresholds***</span> |
| ExpressRoute gateway | *```resourceName```*-GatewayERBitsInAlert | Metrics | ***\_amba-ERGatewayConnectionBitsInPerSecond-threshold-Override\_*** |
| ExpressRoute gateway | *```resourceName```*-GatewayERBitsOutAlert | Metrics | ***\_amba-ERGatewayConnectionBitsOutPerSecond-threshold-Override\_*** |
| ExpressRoute gateway | *```resourceName```*-GatewayERCPUAlert | Metrics | ***\_amba-ExpressRouteGatewayCpuUtilization-threshold-Override\_*** |
| ExpressRoute port | *```resourceName```*-DirectERBitsInAlert | Metrics | ***\_amba-PortBitsInPerSecond-threshold-Override\_*** |
| ExpressRoute port | *```resourceName```*-DirectERBitsOutAlert | Metrics | ***\_amba-PortBitsOutPerSecond-threshold-Override\_*** |
| ExpressRoute port | *```resourceName```*-DirectERLineProtocolAlert | Metrics | ***\_amba-LineProtocol-threshold-Override\_*** |
| ExpressRoute port | *```resourceName```*-DirectERRxLightLevelHighAlert | Metrics | ***\_amba-RxLightLevel-High-threshold-Override\_*** |
| ExpressRoute port | *```resourceName```*-DirectERRxLightLevelLowAlert | Metrics | ***\_amba-RxLightLevel-Low-threshold-Override\_*** |
| ExpressRoute port | *```resourceName```*-DirectERTxLightLevelHighAlert | Metrics | ***\_amba-TxLightLevel-High-threshold-Override\_*** |
| ExpressRoute port | *```resourceName```*-DirectERTxLightLevelLowAlert | Metrics | ***\_amba-TxLightLevel-Low-threshold-Override\_*** |
| Front Door | *```resourceName```*-BackendHealthPercentage | Metrics | ***\_amba-BackendHealthPercentage-threshold-Override\_*** |
| Front Door | *```resourceName```*-BackendRequestLatencyAlert | Metrics | <span style="color:DarkOrange">***Not available since it uses dynamic thresholds***</span> |
| Load balancer | *```resourceName```*-ALBDataPathAvailability | Metrics | ***\_amba-VipAvailability-threshold-Override\_*** |
| Load balancer | *```resourceName```*-ALBGlobalBackendAvailability | Metrics | ***\_amba-GlobalBackendAvailability-threshold-Override\_*** |
| Load balancer | *```resourceName```*-ALBHealthProbeStatus | Metrics | ***\_amba-DipAvailability-threshold-Override\_*** |
| Load balancer | *```resourceName```*-ALBUsedSNATPorts | Metrics | ***\_amba-UsedSNATPorts-threshold-Override\_*** |
| Network security group | ActivityNSGDelete | Activity Log | <span style="color:DarkOrange">***Not available since Activity Log based alerts do not have thresholds***</span> |
| Private DNS zone | *```resourceName```*-CapacityUtilizationAlert | Metrics | ***\_amba-VirtualNetworkLinkCapacityUtilization-threshold-Override\_*** |
| Private DNS zone | *```resourceName```*-QueryVolumeAlert | Metrics | ***\_amba-QueryVolume-threshold-Override\_*** |
| Private DNS zone | *```resourceName```*-RecordSet_Capacity_Utilization | Metrics | ***\_amba-RecordSetCapacityUtilization-threshold-Override\_*** |
| Private DNS zone | *```resourceName```*-RequestsAlert | Metrics | ***\_amba-VirtualNetworkWithRegistrationCapacityUtilization-threshold-Override\_*** |
| Public IP address | *```resourceName```*-BytesInDDOSAlert | Metrics | ***\_amba-bytesinddos-threshold-Override\_*** |
| Public IP address | *```resourceName```*-DDOS_Attack | Metrics | ***\_amba-ifunderddosattack-threshold-Override\_*** |
| Public IP address | *```resourceName```*-PacketsInDDosAlert | Metrics | ***\_amba-PacketsInDDoS-threshold-Override\_*** |
| Public IP address | *```resourceName```*-VIPAvailabityAlert | Metrics | ***\_amba-VipAvailability-threshold-Override\_*** |
| Route table | ActivityUDRUpdate | Activity Log | <span style="color:DarkOrange">***Not available since Activity Log based alerts do not have thresholds***</span> |
| Traffic Manager profile | *```resourceName```*-EndpointHealthAlert | Metrics | ***\_amba-EndpointHealth-threshold-Override\_*** |
| Virtual network gateway | *```resourceName```*-TunnelBandwidthAlert | Metrics | ***\_amba-TunnelAverageBandwidth-threshold-Override\_*** |
| Virtual network gateway | *```resourceName```*-TunnelEgressAlert | Metrics | ***\_amba-TunnelEgressBytes-threshold-Override\_*** |
| Virtual network gateway | *```resourceName```*-TunnelEgressPacketDropCountAlert | Metrics | <span style="color:DarkOrange">***Not available since it uses dynamic thresholds***</span> |
| Virtual network gateway | *```resourceName```*-TunnelEgressPacketDropTSMismatchAlert | Metrics | <span style="color:DarkOrange">***Not available since it uses dynamic thresholds***</span> |
| Virtual network gateway | *```resourceName```*-GatewayERBitsAlert | Metrics | ***\_amba-ExpressRouteGatewayBitsPerSecond-threshold-Override\_*** |
| Virtual network gateway | *```resourceName```*-GatewayERCPUAlert | Metrics | ***\_amba-ExpressRouteGatewayCpuUtilization-threshold-Override\_*** |
| Virtual network gateway | *```resourceName```*-TunnelIngressAlert | Metrics | ***\_amba-TunnelIngressBytes-threshold-Override\_*** |
| Virtual network gateway | *```resourceName```*-TunnelIngressPacketDropCountAlert | Metrics | <span style="color:DarkOrange">***Not available since it uses dynamic thresholds***</span> |
| Virtual network gateway | *```resourceName```*-TunnelIngressPacketDropTSMismatchAlert | Metrics | <span style="color:DarkOrange">***Not available since it uses dynamic thresholds***</span> |
| Virtual network | *```resourceName```*-DDOSAttackAlert | Metrics | ***\_amba-ifunderddosattack-threshold-Override\_*** |
| VPN Gateway | ActivityVPNGatewayDelete | Activity Log | <span style="color:DarkOrange">***Not available since Activity Log based alerts do not have thresholds***</span> |
| VPN Gateway | *```resourceName```*-GatewayBandwidthAlert | Metrics | ***\_amba-tunnelaveragebandwidth-threshold-Override\_*** |
| VPN Gateway | *```resourceName```*-BGPPeerStatusAlert | Metrics | ***\_amba-bgppeerstatus-threshold-Override\_*** |
| VPN Gateway | *```resourceName```*-TunnelEgressAlert | Metrics | ***\_amba-tunnelegressbytes-threshold-Override\_*** |
| VPN Gateway | *```resourceName```*-TunnelEgressPacketDropCountAlert | Metrics | <span style="color:DarkOrange">***Not available since it uses dynamic thresholds***</span> |
| VPN Gateway | *```resourceName```*-TunnelEgressPacketDropTSMismatchAlert | Metrics | <span style="color:DarkOrange">***Not available since it uses dynamic thresholds***</span> |
| VPN Gateway | *```resourceName```*-TunnelIngressAlert | Metrics | ***\_amba-tunnelingressbytes-threshold-Override\_*** |
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
| Storage account | *```resourceName```*-AvailabilityAlert | Metrics | ***\_amba-Availability-threshold-Override\_*** |
| App Service plan | *```resourceName```*-CpuPercentage | Metrics | ***\_amba-CpuPercentage-threshold-Override\_*** |
| App Service plan | *```resourceName```*-DiskQueueLengthAlert | Metrics | <span style="color:DarkOrange">***Not available since it uses dynamic thresholds***</span> |
| App Service plan | *```resourceName```*-HttpQueueLengthAlert | Metrics | <span style="color:DarkOrange">***Not available since it uses dynamic thresholds***</span> |
| App Service plan | *```resourceName```*-MemoryPercentage | Metrics | ***\_amba-MemoryPercentage-threshold-Override\_*** |
