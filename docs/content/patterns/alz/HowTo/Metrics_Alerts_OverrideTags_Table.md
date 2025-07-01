---
title: Metrics alerts override tags table
geekdocHidden: true
---

| Resource Type | Alert Name | Alert Type | Override Tag name | Tag value type | Example |
| ------------- | ---------- | ---------- | ----------------- | -------------- | ------- |
| Automation Account | *```resourceName```*-TotalJob | Metrics | ***\_amba-TotalJob-threshold-Override\_*** | Number | 10 |
| Front Door CDN profiles | *```resourceName```*-OriginHealthPercentage | Metrics | ***\_amba-OriginHealthPercentage-threshold-Override\_*** | Number | 35 |
| Front Door CDN profiles | *```resourceName```*-OriginLatencyAlert | Metrics | <span style="color:DarkOrange">***Not available since it uses dynamic thresholds***</span> | <span style="color:DarkOrange">***Not applicable***</span>| <span style="color:DarkOrange">***N/A***</span> |
| Front Door CDN profiles | *```resourceName```*-Percentage4XXAlert | Metrics | <span style="color:DarkOrange">***Not available since it uses dynamic thresholds***</span> | <span style="color:DarkOrange">***Not applicable***</span> | <span style="color:DarkOrange">***N/A***</span> |
| Front Door CDN profiles | *```resourceName```*-Percentage5XXAlert | Metrics | <span style="color:DarkOrange">***Not available since it uses dynamic thresholds***</span> | <span style="color:DarkOrange">***Not applicable***</span> | <span style="color:DarkOrange">***N/A***</span> |
| Key vault | *```resourceName```*-Availability | Metrics | ***\_amba-Availability-threshold-Override\_*** | Number | 80 |
| Key vault | *```resourceName```*-CapacityAlert | Metrics | ***\_amba-SaturationShoebox-threshold-Override\_*** | Number | 90 |
| Key vault | *```resourceName```*-LatencyAlert | Metrics | ***\_amba-ServiceApiLatency-threshold-Override\_*** | Number | 900 |
| Key vault | *```resourceName```*-RequestsAlert | Metrics | <span style="color:DarkOrange">***Not available since it uses dynamic thresholds***</span> | <span style="color:DarkOrange">***Not applicable***</span> | <span style="color:DarkOrange">***N/A***</span> |
| Azure Key Vault Managed HSM | *```resourceName```*-Availability | Metrics | ***\_amba-Availability-threshold-Override\_*** | Number | 80 |
| Azure Key Vault Managed HSM | *```resourceName```*-LatencyAlert | Metrics | ***\_amba-ServiceApiLatency-threshold-Override\_*** | Number | 900 |
| Application gateway | *```resourceName```*-agApplicationGatewayTotalTime | Metrics | <span style="color:DarkOrange">***Not available since it uses dynamic thresholds***</span> | <span style="color:DarkOrange">***Not applicable***</span> | <span style="color:DarkOrange">***N/A***</span> |
| Application gateway | *```resourceName```*-agBackendLastByteResponseTime | Metrics | <span style="color:DarkOrange">***Not available since it uses dynamic thresholds***</span> | <span style="color:DarkOrange">***Not applicable***</span> | <span style="color:DarkOrange">***N/A***</span> |
| Application gateway | *```resourceName```*-agCapacityUnits | Metrics | ***\_amba-CapacityUnits-threshold-Override\_*** | Number | 90 |
| Application gateway | *```resourceName```*-agComputeUnits | Metrics | ***\_amba-ComputeUnits-threshold-Override\_*** | Number | 90 |
| Application gateway | *```resourceName```*-agCpuUtilization | Metrics | ***\_amba-CpuUtilization-threshold-Override\_*** | Number | 75 |
| Application gateway | *```resourceName```*-agFailedRequests | Metrics | <span style="color:DarkOrange">***Not available since it uses dynamic thresholds***</span> | <span style="color:DarkOrange">***Not applicable***</span> | <span style="color:DarkOrange">***N/A***</span> |
| Application gateway | *```resourceName```*-agResponseStatus | Metrics | <span style="color:DarkOrange">***Not available since it uses dynamic thresholds***</span> | <span style="color:DarkOrange">***Not applicable***</span> | <span style="color:DarkOrange">***N/A***</span> |
| Application gateway | *```resourceName```*-agUnhealthyHostCount | Metrics | ***\_amba-UnhealthyHostCount-threshold-Override\_*** | Number | 25 |
| Firewall | *```resourceName```*-FirewallHealth | Metrics | ***\_amba-FirewallHealth-threshold-Override\_*** | Number | 75 |
| Firewall | *```resourceName```*-SNATPortUtilization | Metrics | ***\_amba-SNATPortUtilization-threshold-Override\_*** | Number | 90 |
| ExpressRoute circuit | *```resourceName```*-ArpAvailability | Metrics | ***\_amba-ArpAvailability-threshold-Override\_*** | Number | 85 |
| ExpressRoute circuit | *```resourceName```*-BgpAvailability | Metrics | ***\_amba-BgpAvailability-threshold-Override\_*** | Number | 85 |
| ExpressRoute circuit | *```resourceName```*-QosDropBitsInPerSecond | Metrics | <span style="color:DarkOrange">***Not available since it uses dynamic thresholds***</span> | <span style="color:DarkOrange">***Not applicable***</span> | <span style="color:DarkOrange">***N/A***</span> |
| ExpressRoute circuit | *```resourceName```*-QosDropBitsOutPerSecond | Metrics | <span style="color:DarkOrange">***Not available since it uses dynamic thresholds***</span> | <span style="color:DarkOrange">***Not applicable***</span> | <span style="color:DarkOrange">***N/A***</span> |
| ExpressRoute gateway | *```resourceName```*-GatewayERBitsInAlert | Metrics | ***\_amba-ERGatewayConnectionBitsInPerSecond-threshold-Override\_*** | Number | 10 |
| ExpressRoute gateway | *```resourceName```*-GatewayERBitsOutAlert | Metrics | ***\_amba-ERGatewayConnectionBitsOutPerSecond-threshold-Override\_*** | Number | 10 |
| ExpressRoute gateway | *```resourceName```*-GatewayERCPUAlert | Metrics | ***\_amba-ExpressRouteGatewayCpuUtilization-threshold-Override\_*** | Number | 85 |
| ExpressRoute port | *```resourceName```*-DirectERBitsInAlert | Metrics | ***\_amba-PortBitsInPerSecond-threshold-Override\_*** | Number | 10 |
| ExpressRoute port | *```resourceName```*-DirectERBitsOutAlert | Metrics | ***\_amba-PortBitsOutPerSecond-threshold-Override\_*** | Number | 10 |
| ExpressRoute port | *```resourceName```*-DirectERLineProtocolAlert | Metrics | ***\_amba-LineProtocol-threshold-Override\_*** | Number | 0.5 |
| ExpressRoute port | *```resourceName```*-DirectERRxLightLevelHighAlert | Metrics | ***\_amba-RxLightLevel-High-threshold-Override\_*** | Number | 4 |
| ExpressRoute port | *```resourceName```*-DirectERRxLightLevelLowAlert | Metrics | ***\_amba-RxLightLevel-Low-threshold-Override\_*** | Number | 4 |
| ExpressRoute port | *```resourceName```*-DirectERTxLightLevelHighAlert | Metrics | ***\_amba-TxLightLevel-High-threshold-Override\_*** | Number | 4 |
| ExpressRoute port | *```resourceName```*-DirectERTxLightLevelLowAlert | Metrics | ***\_amba-TxLightLevel-Low-threshold-Override\_*** | Number | 4 |
| Front Door | *```resourceName```*-BackendHealthPercentage | Metrics | ***\_amba-BackendHealthPercentage-threshold-Override\_*** | Number | 85 |
| Front Door | *```resourceName```*-BackendRequestLatencyAlert | Metrics | <span style="color:DarkOrange">***Not available since it uses dynamic thresholds***</span> | <span style="color:DarkOrange">***Not applicable***</span> | <span style="color:DarkOrange">***N/A***</span> |
| Load balancer | *```resourceName```*-ALBDataPathAvailability | Metrics | ***\_amba-VipAvailability-threshold-Override\_*** | Number | 85 |
| Load balancer | *```resourceName```*-ALBGlobalBackendAvailability | Metrics | ***\_amba-GlobalBackendAvailability-threshold-Override\_*** | Number | 85 |
| Load balancer | *```resourceName```*-ALBHealthProbeStatus | Metrics | ***\_amba-DipAvailability-threshold-Override\_*** | Number | 85 |
| Load balancer | *```resourceName```*-ALBUsedSNATPorts | Metrics | ***\_amba-UsedSNATPorts-threshold-Override\_*** | Number | 800 |
| Private DNS zone | *```resourceName```*-CapacityUtilizationAlert | Metrics | ***\_amba-VirtualNetworkLinkCapacityUtilization-threshold-Override\_*** | Number | 75 |
| Private DNS zone | *```resourceName```*-QueryVolumeAlert | Metrics | ***\_amba-QueryVolume-threshold-Override\_*** | Number | 400 |
| Private DNS zone | *```resourceName```*-RecordSet_Capacity_Utilization | Metrics | ***\_amba-RecordSetCapacityUtilization-threshold-Override\_*** | Number | 75 |
| Private DNS zone | *```resourceName```*-RequestsAlert | Metrics | ***\_amba-VirtualNetworkWithRegistrationCapacityUtilization-threshold-Override\_*** | Number | 75 |
| Public IP address | *```resourceName```*-BytesInDDOSAlert | Metrics | ***\_amba-bytesinddos-threshold-Override\_*** | Number | 7500000 |
| Public IP address | *```resourceName```*-DDOS_Attack | Metrics | ***\_amba-ifunderddosattack-threshold-Override\_*** | Number | 5 |
| Public IP address | *```resourceName```*-PacketsInDDosAlert | Metrics | ***\_amba-PacketsInDDoS-threshold-Override\_*** | Number | 35000 |
| Public IP address | *```resourceName```*-VIPAvailabityAlert | Metrics | ***\_amba-VipAvailability-threshold-Override\_*** | Number | 80 |
| Traffic Manager | *```resourceName```*-EndpointHealthAlert | Metrics | ***\_amba-EndpointHealth-threshold-Override\_*** | Number | 0.7 |
| Virtual network gateway | *```resourceName```*-TunnelBandwidthAlert | Metrics | ***\_amba-TunnelAverageBandwidth-threshold-Override\_*** | Number | 2 |
| Virtual network gateway | *```resourceName```*-TunnelEgressAlert | Metrics | ***\_amba-TunnelEgressBytes-threshold-Override\_*** | Number | 2 |
| Virtual network gateway | *```resourceName```*-TunnelEgressPacketDropCountAlert | Metrics | <span style="color:DarkOrange">***Not available since it uses dynamic thresholds***</span> | <span style="color:DarkOrange">***Not applicable***</span> | <span style="color:DarkOrange">***N/A***</span> |
| Virtual network gateway | *```resourceName```*-TunnelEgressPacketDropTSMismatchAlert | Metrics | <span style="color:DarkOrange">***Not available since it uses dynamic thresholds***</span> | <span style="color:DarkOrange">***Not applicable***</span> | <span style="color:DarkOrange">***N/A***</span> |
| Virtual network gateway | *```resourceName```*-GatewayERBitsAlert | Metrics | ***\_amba-ExpressRouteGatewayBitsPerSecond-threshold-Override\_*** | Number | 2 |
| Virtual network gateway | *```resourceName```*-GatewayERCPUAlert | Metrics | ***\_amba-ExpressRouteGatewayCpuUtilization-threshold-Override\_*** | Number | 75 |
| Virtual network gateway | *```resourceName```*-TunnelIngressAlert | Metrics | ***\_amba-TunnelIngressBytes-threshold-Override\_*** | Number | 2 |
| Virtual network gateway | *```resourceName```*-TunnelIngressPacketDropCountAlert | Metrics | <span style="color:DarkOrange">***Not available since it uses dynamic thresholds***</span> | <span style="color:DarkOrange">***Not applicable***</span> | <span style="color:DarkOrange">***N/A***</span> |
| Virtual network gateway | *```resourceName```*-TunnelIngressPacketDropTSMismatchAlert | Metrics | <span style="color:DarkOrange">***Not available since it uses dynamic thresholds***</span> | <span style="color:DarkOrange">***Not applicable***</span>| <span style="color:DarkOrange">***N/A***</span> |
| Virtual network | *```resourceName```*-DDOSAttackAlert | Metrics | ***\_amba-ifunderddosattack-threshold-Override\_*** | Number | 1 |
| VPN Gateway | *```resourceName```*-GatewayBandwidthAlert | Metrics | ***\_amba-tunnelaveragebandwidth-threshold-Override\_*** | Number | 2 |
| VPN Gateway | *```resourceName```*-BGPPeerStatusAlert | Metrics | ***\_amba-bgppeerstatus-threshold-Override\_*** | Number | 2 |
| VPN Gateway | *```resourceName```*-TunnelEgressAlert | Metrics | ***\_amba-tunnelegressbytes-threshold-Override\_*** | Number | 2 |
| VPN Gateway | *```resourceName```*-TunnelEgressPacketDropCountAlert | Metrics | <span style="color:DarkOrange">***Not available since it uses dynamic thresholds***</span> | <span style="color:DarkOrange">***Not applicable***</span> | <span style="color:DarkOrange">***N/A***</span> |
| VPN Gateway | *```resourceName```*-TunnelEgressPacketDropTSMismatchAlert | Metrics | <span style="color:DarkOrange">***Not available since it uses dynamic thresholds***</span> | <span style="color:DarkOrange">***Not applicable***</span> | <span style="color:DarkOrange">***N/A***</span> |
| VPN Gateway | *```resourceName```*-TunnelIngressAlert | Metrics | ***\_amba-tunnelingressbytes-threshold-Override\_*** | Number | 2 |
| VPN Gateway | *```resourceName```*-TunnelIngressPacketDropCount | Metrics | <span style="color:DarkOrange">***Not available since it uses dynamic thresholds***</span> | <span style="color:DarkOrange">***Not applicable***</span> | <span style="color:DarkOrange">***N/A***</span> |
| VPN Gateway | *```resourceName```*-TunnelIngressPacketDropTSMismatchAlert | Metrics | <span style="color:DarkOrange">***Not available since it uses dynamic thresholds***</span> | <span style="color:DarkOrange">***Not applicable***</span> | <span style="color:DarkOrange">***N/A***</span> |
| Storage account | *```resourceName```*-AvailabilityAlert | Metrics | ***\_amba-Availability-threshold-Override\_*** | Number | 90 |
| App Service plan | *```resourceName```*-CpuPercentage | Metrics | ***\_amba-CpuPercentage-threshold-Override\_*** | Number | 75 |
| App Service plan | *```resourceName```*-DiskQueueLengthAlert | Metrics | <span style="color:DarkOrange">***Not available since it uses dynamic thresholds***</span> | <span style="color:DarkOrange">***Not applicable***</span> | <span style="color:DarkOrange">***N/A***</span> |
| App Service plan | *```resourceName```*-HttpQueueLengthAlert | Metrics | <span style="color:DarkOrange">***Not available since it uses dynamic thresholds***</span> | <span style="color:DarkOrange">***Not applicable***</span> | <span style="color:DarkOrange">***N/A***</span> |
| App Service plan | *```resourceName```*-MemoryPercentage | Metrics | ***\_amba-MemoryPercentage-threshold-Override\_*** | Number | 75 |
