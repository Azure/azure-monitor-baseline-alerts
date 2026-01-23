---
title: Metric alerts override tags table
geekdocHidden: true
---

| Resource Type | Alert Name | Override Tag name | Tag value type | Operator | Original threshold value | Sample override value |
| ------------- | ---------- | ----------------- | -------------- | -------- | ------------------------ | --------------------- |
| Microsoft.Automation/automationAccounts | resourceName-TotalJob | ***\_amba-TotalJob-threshold-Override\_*** | Number | GreaterThan | 0 | 4 |
| Microsoft.Cdn/profiles | resourceName-OriginHealthPercentage | ***\_amba-OriginHealthPercentage-threshold-Override\_*** | Number | LessThan | 90 | 102 |
| Microsoft.Cdn/profiles | resourceName-OriginLatencyAlert |  <span style="color:DarkOrange">***Not applicable to alerts configured with dynamic thresholds***</span>  | String |  <span style="color:DarkOrange">***N/A***</span>  | DynamicThresholdCriterion |  <span style="color:DarkOrange">***N/A***</span>  |
| Microsoft.Cdn/profiles | resourceName-Percentage4XXAlert |  <span style="color:DarkOrange">***Not applicable to alerts configured with dynamic thresholds***</span>  | String |  <span style="color:DarkOrange">***N/A***</span>  | DynamicThresholdCriterion |  <span style="color:DarkOrange">***N/A***</span>  |
| Microsoft.Cdn/profiles | resourceName-Percentage5XXAlert |  <span style="color:DarkOrange">***Not applicable to alerts configured with dynamic thresholds***</span>  | String |  <span style="color:DarkOrange">***N/A***</span>  | DynamicThresholdCriterion |  <span style="color:DarkOrange">***N/A***</span>  |
| Microsoft.Compute/virtualMachines | resourceName-AvailableMemoryAlert | ***\_amba-AvailableMemoryBytes-threshold-Override\_*** | Number | LessThan | 1000 | 1092 |
| microsoft.keyvault/managedHSMs | resourceName-Availability | ***\_amba-Availability-threshold-Override\_*** | Number | LessThan | 90 | 98 |
| microsoft.keyvault/managedHSMs | resourceName-LatencyAlert | ***\_amba-ServiceApiLatency-threshold-Override\_*** | Number | GreaterThan | 1000 | 754 |
| microsoft.keyvault/vaults | resourceName-Availability | ***\_amba-Availability-threshold-Override\_*** | Number | LessThan | 90 | 93 |
| microsoft.keyvault/vaults | resourceName-CapacityAlert | ***\_amba-SaturationShoebox-threshold-Override\_*** | Number | GreaterThan | 75 | 2 |
| microsoft.keyvault/vaults | resourceName-LatencyAlert | ***\_amba-ServiceApiLatency-threshold-Override\_*** | Number | GreaterThan | 1000 | 578 |
| microsoft.keyvault/vaults | resourceName-RequestsAlert |  <span style="color:DarkOrange">***Not applicable to alerts configured with dynamic thresholds***</span>  | String |  <span style="color:DarkOrange">***N/A***</span>  | DynamicThresholdCriterion |  <span style="color:DarkOrange">***N/A***</span>  |
| Microsoft.Network/applicationgateways | resourceName-agApplicationGatewayTotalTime |  <span style="color:DarkOrange">***Not applicable to alerts configured with dynamic thresholds***</span>  | String |  <span style="color:DarkOrange">***N/A***</span>  | DynamicThresholdCriterion |  <span style="color:DarkOrange">***N/A***</span>  |
| Microsoft.Network/applicationgateways | resourceName-agBackendLastByteResponseTime |  <span style="color:DarkOrange">***Not applicable to alerts configured with dynamic thresholds***</span>  | String |  <span style="color:DarkOrange">***N/A***</span>  | DynamicThresholdCriterion |  <span style="color:DarkOrange">***N/A***</span>  |
| Microsoft.Network/applicationgateways | resourceName-agCapacityUnits | ***\_amba-CapacityUnits-threshold-Override\_*** | Number | GreaterThan | 75 | 31 |
| Microsoft.Network/applicationgateways | resourceName-agComputeUnits | ***\_amba-ComputeUnits-threshold-Override\_*** | Number | GreaterThan | 75 | 11 |
| Microsoft.Network/applicationgateways | resourceName-agCpuUtilization | ***\_amba-CpuUtilization-threshold-Override\_*** | Number | GreaterThan | 80 | 72 |
| Microsoft.Network/applicationgateways | resourceName-agFailedRequests |  <span style="color:DarkOrange">***Not applicable to alerts configured with dynamic thresholds***</span>  | String |  <span style="color:DarkOrange">***N/A***</span>  | DynamicThresholdCriterion |  <span style="color:DarkOrange">***N/A***</span>  |
| Microsoft.Network/applicationgateways | resourceName-agResponseStatus |  <span style="color:DarkOrange">***Not applicable to alerts configured with dynamic thresholds***</span>  | String |  <span style="color:DarkOrange">***N/A***</span>  | DynamicThresholdCriterion |  <span style="color:DarkOrange">***N/A***</span>  |
| Microsoft.Network/applicationgateways | resourceName-agUnhealthyHostCount | ***\_amba-UnhealthyHostCount-threshold-Override\_*** | Number | GreaterThan | 20 | 1 |
| Microsoft.Network/azureFirewalls | resourceName-ApplicationRuleHit | ***\_amba-ApplicationRuleHit-threshold-Override\_*** | Number | GreaterThan | 50 | 37 |
| Microsoft.Network/azureFirewalls | resourceName-FirewallHealth | ***\_amba-FirewallHealth-threshold-Override\_*** | Number | LessThan | 90 | 93 |
| Microsoft.Network/azureFirewalls | resourceName-NetworkRuleHit | ***\_amba-NetworkRuleHit-threshold-Override\_*** | Number | GreaterThan | 50 | 0 |
| Microsoft.Network/azureFirewalls | resourceName-SNATPortUtilization | ***\_amba-SNATPortUtilization-threshold-Override\_*** | Number | GreaterThan | 80 | 23 |
| Microsoft.Network/expressRouteCircuits | resourceName-ArpAvailability | ***\_amba-ArpAvailability-threshold-Override\_*** | Number | LessThan | 90 | 101 |
| Microsoft.Network/expressRouteCircuits | resourceName-BgpAvailability | ***\_amba-BgpAvailability-threshold-Override\_*** | Number | LessThan | 90 | 96 |
| Microsoft.Network/expressRouteCircuits | resourceName-QosDropBitsInPerSecond |  <span style="color:DarkOrange">***Not applicable to alerts configured with dynamic thresholds***</span>  | String |  <span style="color:DarkOrange">***N/A***</span>  | DynamicThresholdCriterion |  <span style="color:DarkOrange">***N/A***</span>  |
| Microsoft.Network/expressRouteCircuits | resourceName-QosDropBitsOutPerSecond |  <span style="color:DarkOrange">***Not applicable to alerts configured with dynamic thresholds***</span>  | String |  <span style="color:DarkOrange">***N/A***</span>  | DynamicThresholdCriterion |  <span style="color:DarkOrange">***N/A***</span>  |
| Microsoft.Network/expressroutegateways | resourceName-GatewayERBitsInAlert | ***\_amba-ERGatewayConnectionBitsInPerSecond-threshold-Override\_*** | Number | LessThan | 1 | 10 |
| Microsoft.Network/expressroutegateways | resourceName-GatewayERBitsOutAlert | ***\_amba-ERGatewayConnectionBitsOutPerSecond-threshold-Override\_*** | Number | LessThan | 1 | 11 |
| Microsoft.Network/expressroutegateways | resourceName-GatewayERCPUAlert | ***\_amba-ExpressRouteGatewayCpuUtilization-threshold-Override\_*** | Number | GreaterThan | 80 | 45 |
| Microsoft.Network/expressroutegateways | resourceName-ExpressRouteGatewayActiveFlowsAlert | ***\_amba-ExpressRouteGatewayActiveFlows-threshold-Override\_*** | Number | GreaterThan | 200000 | 27381 |
| Microsoft.Network/expressRoutePorts | resourceName-DirectERBitsInAlert | ***\_amba-PortBitsInPerSecond-threshold-Override\_*** | Number | LessThan | 1 | 10 |
| Microsoft.Network/expressRoutePorts | resourceName-DirectERBitsOutAlert | ***\_amba-PortBitsOutPerSecond-threshold-Override\_*** | Number | LessThan | 1 | 11 |
| Microsoft.Network/expressRoutePorts | resourceName-DirectERLineProtocolAlert | ***\_amba-LineProtocol-threshold-Override\_*** | Number | LessThan | 0.9 | 10 |
| Microsoft.Network/expressRoutePorts | resourceName-DirectERRxLightLevelHighAlert | ***\_amba-RxLightLevel-High-threshold-Override\_*** | Number | GreaterThan | 0 | 4 |
| Microsoft.Network/expressRoutePorts | resourceName-DirectERRxLightLevelLowAlert | ***\_amba-RxLightLevel-Low-threshold-Override\_*** | Number | LessThan | -10 | 11 |
| Microsoft.Network/expressRoutePorts | resourceName-DirectERTxLightLevelHighAlert | ***\_amba-TxLightLevel-High-threshold-Override\_*** | Number | GreaterThan | 0 | 6 |
| Microsoft.Network/expressRoutePorts | resourceName-DirectERTxLightLevelLowAlert | ***\_amba-TxLightLevel-Low-threshold-Override\_*** | Number | LessThan | -10 | 11 |
| Microsoft.Network/frontdoors | resourceName-BackendHealthPercentage | ***\_amba-BackendHealthPercentage-threshold-Override\_*** | Number | LessThan | 90 | 92 |
| Microsoft.Network/frontdoors | resourceName-BackendRequestLatencyAlert |  <span style="color:DarkOrange">***Not applicable to alerts configured with dynamic thresholds***</span>  | String |  <span style="color:DarkOrange">***N/A***</span>  | DynamicThresholdCriterion |  <span style="color:DarkOrange">***N/A***</span>  |
| Microsoft.Network/loadBalancers | resourceName-ALBDataPathAvailability | ***\_amba-VipAvailability-threshold-Override\_*** | Number | LessThan | 90 | 104 |
| Microsoft.Network/loadBalancers | resourceName-ALBGlobalBackendAvailability | ***\_amba-GlobalBackendAvailability-threshold-Override\_*** | Number | LessThan | 90 | 105 |
| Microsoft.Network/loadBalancers | resourceName-ALBHealthProbeStatus | ***\_amba-DipAvailability-threshold-Override\_*** | Number | LessThan | 90 | 93 |
| Microsoft.Network/loadBalancers | resourceName-ALBUsedSNATPorts | ***\_amba-UsedSNATPorts-threshold-Override\_*** | Number | GreaterThan | 900 | 619 |
| microsoft.network/p2svpngateways | resourceName-P2SBandwidthAlert | ***\_amba-P2SBandwidth-threshold-Override\_*** | Number | GreaterThan | 9900 | 5795 |
| microsoft.network/p2svpngateways | resourceName-P2SConnectionCountAlert | ***\_amba-P2SConnectionCount-threshold-Override\_*** | Number | GreaterThan | 99000 | 48144 |
| microsoft.network/p2svpngateways | resourceName-UserVpnRouteCountAlert | ***\_amba-UserVpnRouteCount-threshold-Override\_*** | Number | GreaterThan | 9900 | 7132 |
| Microsoft.Network/privateDnsZones | resourceName-CapacityUtilizationAlert | ***\_amba-VirtualNetworkLinkCapacityUtilization-threshold-Override\_*** | Number | GreaterThanOrEqual | 80 | 21 |
| Microsoft.Network/privateDnsZones | resourceName-QueryVolumeAlert | ***\_amba-QueryVolume-threshold-Override\_*** | Number | GreaterThanOrEqual | 500 | 43 |
| Microsoft.Network/privateDnsZones | resourceName-RecordSet_Capacity_Utilization | ***\_amba-RecordSetCapacityUtilization-threshold-Override\_*** | Number | GreaterThanOrEqual | 80 | 25 |
| Microsoft.Network/privateDnsZones | resourceName-RequestsAlert | ***\_amba-VirtualNetworkWithRegistrationCapacityUtilization-threshold-Override\_*** | Number | GreaterThanOrEqual | 80 | 70 |
| Microsoft.Network/publicIPAddresses | resourceName-BytesInDDOSAlert | ***\_amba-bytesinddos-threshold-Override\_*** | Number | GreaterThan | 8000000 | 4045424 |
| Microsoft.Network/publicIPAddresses | resourceName-DDOS_Attack | ***\_amba-ifunderddosattack-threshold-Override\_*** | Number | GreaterThan | 0 | 1 |
| Microsoft.Network/publicIPAddresses | resourceName-PacketsInDDosAlert | ***\_amba-PacketsInDDoS-threshold-Override\_*** | Number | GreaterThanOrEqual | 40000 | 10293 |
| Microsoft.Network/publicIPAddresses | resourceName-VIPAvailabityAlert | ***\_amba-VipAvailability-threshold-Override\_*** | Number | LessThan | 90 | 90 |
| Microsoft.Network/trafficmanagerprofiles | resourceName-EndpointHealthAlert | ***\_amba-EndpointHealth-threshold-Override\_*** | Number | LessThan | 0.9 | 11 |
| microsoft.network/virtualhubs | resourceName-BgpPeerStatusAlert | ***\_amba-bgppeerstatus-threshold-Override\_*** | Number | LessThan | 1 | 12 |
| microsoft.network/virtualhubs | resourceName-CountOfRoutesAdvertisedToPeerAlert | ***\_amba-CountOfRoutesAdvertisedToPeer-threshold-Override\_*** | Number | GreaterThan | 1000 | 305 |
| microsoft.network/virtualhubs | resourceName-CountOfRoutesLearnedFromPeerAlert | ***\_amba-CountOfRoutesLearnedFromPeer-threshold-Override\_*** | Number | GreaterThan | 1000 | 956 |
| microsoft.network/virtualhubs | resourceName-RoutingInfrastructureUnitsAlert | ***\_amba-RoutingInfrastructureUnits-threshold-Override\_*** | Number | GreaterThan | 30 | 3 |
| microsoft.network/virtualhubs | resourceName-SpokeVMUtilizationAlert | ***\_amba-SpokeVMUtilization-threshold-Override\_*** | Number | GreaterThan | 90 | 51 |
| microsoft.network/virtualhubs | resourceName-VirtualHubDataProcessedAlert | ***\_amba-VirtualHubDataProcessed-threshold-Override\_*** | Number | GreaterThan | 5000 | 2481 |
| Microsoft.Network/virtualNetworkGateways | resourceName-TunnelBandwidthAlert | ***\_amba-TunnelAverageBandwidth-threshold-Override\_*** | Number | LessThan | 1 | 11 |
| Microsoft.Network/virtualNetworkGateways | resourceName-TunnelEgressAlert | ***\_amba-TunnelEgressBytes-threshold-Override\_*** | Number | LessThan | 1 | 11 |
| microsoft.network/virtualNetworkGateways | resourceName-TunnelEgressPacketDropCountAlert |  <span style="color:DarkOrange">***Not applicable to alerts configured with dynamic thresholds***</span>  | String |  <span style="color:DarkOrange">***N/A***</span>  | DynamicThresholdCriterion |  <span style="color:DarkOrange">***N/A***</span>  |
| microsoft.network/virtualNetworkGateways | resourceName-TunnelEgressPacketDropTSMismatchAlert |  <span style="color:DarkOrange">***Not applicable to alerts configured with dynamic thresholds***</span>  | String |  <span style="color:DarkOrange">***N/A***</span>  | DynamicThresholdCriterion |  <span style="color:DarkOrange">***N/A***</span>  |
| Microsoft.Network/virtualNetworkGateways | resourceName-GatewayERBitsAlert | ***\_amba-ExpressRouteGatewayBitsPerSecond-threshold-Override\_*** | Number | LessThan | 1 | 11 |
| Microsoft.Network/virtualNetworkGateways | resourceName-GatewayERCPUAlert | ***\_amba-ExpressRouteGatewayCpuUtilization-threshold-Override\_*** | Number | GreaterThan | 80 | 72 |
| Microsoft.Network/virtualNetworkGateways | resourceName-TunnelIngressAlert | ***\_amba-TunnelIngressBytes-threshold-Override\_*** | Number | LessThan | 1 | 11 |
| microsoft.network/virtualNetworkGateways | resourceName-TunnelIngressPacketDropCountAlert |  <span style="color:DarkOrange">***Not applicable to alerts configured with dynamic thresholds***</span>  | String |  <span style="color:DarkOrange">***N/A***</span>  | DynamicThresholdCriterion |  <span style="color:DarkOrange">***N/A***</span>  |
| microsoft.network/virtualNetworkGateways | resourceName-TunnelIngressPacketDropTSMismatchAlert |  <span style="color:DarkOrange">***Not applicable to alerts configured with dynamic thresholds***</span>  | String |  <span style="color:DarkOrange">***N/A***</span>  | DynamicThresholdCriterion |  <span style="color:DarkOrange">***N/A***</span>  |
| Microsoft.Network/virtualNetworks | resourceName-DDOSAttackAlert | ***\_amba-ifunderddosattack-threshold-Override\_*** | Number | GreaterThan | 0 | 8 |
| microsoft.network/vpngateways | resourceName-GatewayBandwidthAlert | ***\_amba-tunnelaveragebandwidth-threshold-Override\_*** | Number | LessThan | 1 | 10 |
| microsoft.network/vpngateways | resourceName-BGPPeerStatusAlert | ***\_amba-bgppeerstatus-threshold-Override\_*** | Number | LessThan | 1 | 10 |
| microsoft.network/vpngateways | resourceName-TunnelEgressAlert | ***\_amba-tunnelegressbytes-threshold-Override\_*** | Number | LessThan | 1 | 10 |
| microsoft.network/vpngateways | resourceName-TunnelEgressPacketDropCountAlert |  <span style="color:DarkOrange">***Not applicable to alerts configured with dynamic thresholds***</span>  | String |  <span style="color:DarkOrange">***N/A***</span>  | DynamicThresholdCriterion |  <span style="color:DarkOrange">***N/A***</span>  |
| microsoft.network/vpngateways | resourceName-TunnelEgressPacketDropTSMismatchAlert |  <span style="color:DarkOrange">***Not applicable to alerts configured with dynamic thresholds***</span>  | String |  <span style="color:DarkOrange">***N/A***</span>  | DynamicThresholdCriterion |  <span style="color:DarkOrange">***N/A***</span>  |
| microsoft.network/vpngateways | resourceName-TunnelIngressAlert | ***\_amba-tunnelingressbytes-threshold-Override\_*** | Number | LessThan | 1 | 12 |
| microsoft.network/vpngateways | resourceName-TunnelIngressPacketDropCountAlert |  <span style="color:DarkOrange">***Not applicable to alerts configured with dynamic thresholds***</span>  | String |  <span style="color:DarkOrange">***N/A***</span>  | DynamicThresholdCriterion |  <span style="color:DarkOrange">***N/A***</span>  |
| microsoft.network/vpngateways | resourceName-TunnelIngressPacketDropTSMismatchAlert |  <span style="color:DarkOrange">***Not applicable to alerts configured with dynamic thresholds***</span>  | String |  <span style="color:DarkOrange">***N/A***</span>  | DynamicThresholdCriterion |  <span style="color:DarkOrange">***N/A***</span>  |
| Microsoft.Storage/storageAccounts | resourceName-AvailabilityAlert | ***\_amba-Availability-threshold-Override\_*** | Number | LessThan | 90 | 100 |
| Microsoft.Web/serverfarms | resourceName-CpuPercentage | ***\_amba-CpuPercentage-threshold-Override\_*** | Number | GreaterThan | 90 | 29 |
| Microsoft.Web/serverfarms | resourceName-DiskQueueLengthAlert |  <span style="color:DarkOrange">***Not applicable to alerts configured with dynamic thresholds***</span>  | String |  <span style="color:DarkOrange">***N/A***</span>  | DynamicThresholdCriterion |  <span style="color:DarkOrange">***N/A***</span>  |
| Microsoft.Web/serverfarms | resourceName-HttpQueueLengthAlert |  <span style="color:DarkOrange">***Not applicable to alerts configured with dynamic thresholds***</span>  | String |  <span style="color:DarkOrange">***N/A***</span>  | DynamicThresholdCriterion |  <span style="color:DarkOrange">***N/A***</span>  |
| Microsoft.Web/serverfarms | resourceName-MemoryPercentage | ***\_amba-MemoryPercentage-threshold-Override\_*** | Number | GreaterThan | 85 | 8 |
