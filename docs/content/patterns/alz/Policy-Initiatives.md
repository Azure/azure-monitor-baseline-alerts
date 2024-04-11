---
title: Policy Initiatives
geekdocCollapseSection: true
weight: 40
---

## Overview

This document details the ALZ-Monitor Azure policy initiatives leveraged for deploying the ALZ-Monitor baselines. For references on individual alerts/policies, refer to [Alert Details](../Alerts-Details).

## Connectivity initiative

This initiative is intended for assignment of policies relevant to networking components in ALZ. With the guidance provided in [Introduction to deploying the ALZ Pattern](../deploy/Introduction-to-deploying-the-ALZ-Pattern), this will assign to the alz-platform-connectivity management group structure in the ALZ reference architecture. For details on which policies are included in the initiative as well as what the default enablement state of the policy is, refer to the below table.

| **Policy Name**                                     | **Path to policy json file**                                                                                                                                 | **Policy default effect** |
| --------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------ | ------------------------- |
| Deploy_ERCIR_QosDropBitsInPerSecond_Alert           | [deploy-ercir_qosdropsbitsin_alert.json](../../../services/Network/expressRouteCircuits/Deploy-ERCIR-QOSDropsBitsIn-Alert.json)                              | deployIfNotExists         |
| Deploy_ERCIR_QosDropBitsOutPerSecond_Alert          | [deploy-ercir_qosdropsbitsout_alert.json](../../../services/Network/expressRouteCircuits/Deploy-ERCIR-QOSDropsBitsOut-Alert.json)                            | deployIfNotExists         |
| Deploy_VPNGw_BGPPeerStatus_Alert                    | [deploy-vpng_bgppeerstatus_alert.json](../../../services/Network/vpnGateways/Deploy-VPNG-BGPPeerStatus-Alert.json)                                           | deployIfNotExists         |
| Deploy_VnetGw_ExpressRouteCpuUtil_Alert             | [deploy-vnetg_expressroutecpuutilization_alert.json](../../../services/Network/virtualNetworkGateways/Deploy-VNETG-ERGCPUUtilization-Alert.json)             | deployIfNotExists         |
| Deploy_VnetGw_TunnelBandwidth_Alert                 | [deploy-vnetg_bandwidthutilization_alert.json](../../../services/Network/virtualNetworkGateways/Deploy-VNETG-BandwidthUtilization-Alert.json)                | deployIfNotExists         |
| Deploy_VnetGw_TunnelEgress_Alert                    | [deploy-vnetg_egress_alert.json](../../../services/Network/virtualNetworkGateways/Deploy-VNETG-Egress-Alert.json)                                            | disabled                  |
| Deploy_VnetGw_TunnelIngress_Alert                   | [deploy-vnetg_ingress_alert.json](../../../services/Network/virtualNetworkGateways/Deploy-VNETG-Ingress-Alert.json)                                          | disabled                  |
| Deploy_VPNGw_BandwidthUtil_Alert                    | [deploy-vpng_bandwidthutilization_alert.json](../../../services/Network/vpnGateways/Deploy-VPNG-BandwidthUtilization-Alert.json)                             | deployIfNotExists         |
| Deploy_VPNGw_Egress_Alert                           | [deploy-vpng_egress_alert.json](../../../services/Network/vpnGateways/Deploy-VPNG-Egress-Alert.json)                                                         | disabled                  |
| Deploy_VPNGw_TunnelEgressPacketDropCount_Alert      | [deploy-vpng_egresspacketdropcount_alert.json](../../../services/Network/vpnGateways/Deploy-VPNG-EgressPacketDropCount-Alert.json)                           | deployIfNotExists         |
| Deploy_VPNGw_TunnelEgressPacketDropMismatch_Alert   | [deploy-vpng_egresspacketdropmismatch_alert.json](../../../services/Network/vpnGateways/Deploy-VPNG-EgressPacketDropMismatch-Alert.json)                     | deployIfNotExists         |
| Deploy_VPNGw_Ingress_Alert                          | [deploy-vpng_ingress_alert.json](../../../services/Network/vpnGateways/Deploy-VPNG-Ingress-Alert.json)                                                       | disabled                  |
| Deploy_VPNGw_TunnelIngressPacketDropCount_Alert     | [deploy-vpng_ingresspacketdropcount_alert.json](../../../services/Network/vpnGateways/Deploy-VPNG-IngressPacketDropCount-Alert.json)                         | deployIfNotExists         |
| Deploy_VPNGw_TunnelIngressPacketDropMismatch_Alert  | [deploy-vpng_ingresspacketdropmismatch_alert.json](../../../services/Network/vpnGateways/Deploy-VPNG-IngressPacketDropMismatch-Alert.json)                   | deployIfNotExists         |
| Deploy_PDNSZ_CapacityUtil_Alert                     | [deploy-pdnsz_capacityutilization_alert.json](../../../services/Network/privateDnsZones/Deploy-PDNSZ-CapacityUtilization-Alert.json)                         | deployIfNotExists         |
| Deploy_PDNSZ_QueryVolume_Alert                      | [deploy-pdnsz_queryvolume_alert.json](../../../services/Network/privateDnsZones/Deploy-PDNSZ-QueryVolume-Alert.json)                                         | disabled                  |
| Deploy_PDNSZ_RecordSetCapacity_Alert                | [deploy-pdnsz_recordsetcapacity_alert.json](../../../services/Network/privateDnsZones/Deploy-PDNSZ-RecordSetCapacity-Alert.json)                             | deployIfNotExists         |
| Deploy_DNSZ_RegistrationCapacityUtil_Alert          | [deploy-pdnsz_registrationcapacityutilization_alert.json](../../../services/Network/privateDnsZones/Deploy-PDNSZ-RegistrationCapacityUtilization-Alert.json) | deployIfNotExists         |
| Deploy_ERGw_ExpressRouteBitsIn_Alert                | [deploy-erg_bitsinpersecond_alert.json](../../../services/Network/expressRouteGateways/Deploy-ERG-BitsInPerSecond-Alert.json)                                | disabled                  |
| Deploy_ERGw_ExpressRouteBitsOut_Alert               | [deploy-erg_bitsoutpersecond_alert.json](../../../services/Network/expressRouteGateways/Deploy-ERG-BitsOutPerSecond-Alert.json)                              | disabled                  |
| Deploy_ERGw_ExpressRouteCpuUtil_Alert               | [deploy-erg_expressroutecpuutilization_alert.json](../../../services/Network/expressRouteGateways/Deploy-ERG-CPUUtilization-Alert.json)                      | deployIfNotExists         |
| Deploy_VnetGw_TunnelEgressPacketDropMismatch_Alert  | [deploy-vnetg_egresspacketdropmismatch_alert.json](../../../services/Network/virtualNetworkGateways/Deploy-VNETG-EgressPacketDropMismatch-Alert.json)        | deployIfNotExists         |
| Deploy_VnetGw_ExpressRouteBitsPerSecond_Alert       | [deploy-vnetg_expressroutebitspersecond_alert.json](../../../services/Network/virtualNetworkGateways/Deploy-VNETG-ERGBitsPerSecond-Alert.json)               | deployIfNotExists         |
| Deploy_VnetGw_TunnelIngressPacketDropMismatch_Alert | [deploy-vnetg_ingresspacketdropmismatch_alert.json](../../../services/Network/virtualNetworkGateways/Deploy-VNETG-IngressPacketDropMismatch-Alert.json)      | deployIfNotExists         |
| Deploy_VnetGw_TunnelIngressPacketDropCount_Alert    | [deploy-vnetg_ingresspacketdropcount_alert.json](../../../services/Network/virtualNetworkGateways/Deploy-VNETG-IngressPacketDropCount-Alert.json)            | deployIfNotExists         |
| Deploy_ERCIR_BgpAvailability_Alert                  | [deploy-ercir_bgpavailability_alert.json](../../../services/Network/expressRouteCircuits/Deploy-ERCIR-BGPAvailability-Alert.json)                            | deployIfNotExists         |
| Deploy_ERCIR_ArpAvailability_Alert                  | [deploy-ercir_arpavailability_alert.json](../../../services/Network/expressRouteCircuits/Deploy-ERCIR-ARPAvailability-Alert.json)                            | deployIfNotExists         |
| Deploy_AFW_SNATPortUtilization_Alert                | [deploy-afw_snatportutilization_alert.json](../../../services/Network/azureFirewalls/Deploy-AFW-SNATPortUtilization-Alert.json)                              | deployIfNotExists         |
| Deploy_AFW_FirewallHealth_Alert                     | [deploy-afw_firewallhealth_alert](../../../services/Network/azureFirewalls/Deploy-AFW-FirewallHealth-Alert.json)                                             | deployIfNotExists         |
| Deploy_PublicIp_BytesInDDoSAttack_Alert             | [deploy-pip_bytesinddosattack_alert.json](../../../services/Network/publicIPAddresses/Deploy-PIP-BytesInDDOSAttack-Alert.json)                               | disabled                  |
| Deploy_PublicIp_DDoSAttack_Alert                    | [deploy-pip_ddosattack_alert.json](../../../services/Network/publicIPAddresses/Deploy-PIP-DDOSAttack-Alert.json)                                             | deployIfNotExists         |
| Deploy_PublicIp_PacketsInDDoSAttack_Alert           | [deploy-pip_packetsinddos_alert.json](../../../services/Network/publicIPAddresses/Deploy-PIP-PacketsInDDOS-Alert.json)                                       | disabled                  |
| Deploy_PublicIp_VIPAvailability_Alert               | [deploy-pip_vipavailability_alert.json](../../../services/Network/publicIPAddresses/Deploy-PIP-VIPAvailability-Alert.json)                                   | deployIfNotExists         |
| Deploy_VNET_DDoSAttack_Alert                        | [deploy-vnet_ddosattack_alert.json](../../../services/Network/virtualNetworks/Deploy-VNET-DDOSAttack-Alert.json)                                             | deployIfNotExists         |
| Deploy_ALB_DataPathAvailability_Alert               | [Deploy-LB-DatapathAvailability-Alert.json](../../../services/Network/loadBalancers/Deploy-LB-DatapathAvailability-Alert.json)                               | deployIfNotExists         |
| Deploy_ALB_GlobalBackendAvailability_Alert          | [Deploy-LB-GlobalBackendAvailability-Alert.json](../../../services/Network/loadBalancers/Deploy-LB-GlobalBackendAvailability-Alert.json)                     | deployIfNotExists         |
| Deploy_ALB_HealthProbeStatus_Alert                  | [Deploy-LB-HealthProbeStatus-Alert.json](../../../services/Network/loadBalancers/Deploy-LB-HealthProbeStatus-Alert.json)                                     | deployIfNotExists         |
| Deploy_ALB_UsedSNATPorts_Alert                      | [Deploy-LB-UsedSNATPorts-Alert.json](../../../services/Network/loadBalancers/Deploy-LB-UsedSNATPorts-Alert.json)                                             | deployIfNotExists         |
| Deploy_activitylog_Firewall_Delete                  | [deploy-activitylog-AzureFirewall-Del.json](../../../services/Network/azureFirewalls/Deploy-ActivityLog-AzureFirewall-Del.json)                              | deployIfNotExists         |
| Deploy_activitylog_RouteTable_Update                | [deploy-activitylog-RouteTable-Update.json](../../../services/Network/routeTables/Deploy-ActivityLog-RouteTable-Update.json)                                 | deployIfNotExists         |
| Deploy_activitylog_NSG_Delete                       | [deploy-activitylog-NSG-Del.json](../../../services/Network/networkSecurityGroups/Deploy-ActivityLog-NSG-Del.json)                                           | deployIfNotExists         |
| Deploy_activitylog_VPNGateway_Delete                | [deploy-activitylog-VPNGate-Del.json](../../../services/Network/vpnGateways/Deploy-ActivityLog-VPNG-Del.json)                                                | deployIfNotExists         |

## Management initiative

This initiative is intended for assignment of policies relevant to management components in ALZ. With the guidance provided in [Introduction to deploying the ALZ Pattern](../deploy/Introduction-to-deploying-the-ALZ-Pattern), this will assign to the alz-platform-management group structure in the ALZ reference architecture. For details on which policies are included in the initiative as well as what the default enablement state of the policy is, refer to the below table.

| **Policy Name**                          | **Path to policy json file**                                                                                                               | **Policy default effect** |
| ---------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------ | ------------------------- |
| Deploy_AA_TotalJob_Alert                 | [deploy-aa_totaljob_alert.json](../../../services/Automation/automationAccounts/Deploy-AA-TotalJob-Alert.json)                             | deployIfNotExists         |
| Deploy_RecoveryVault_BackupHealth_Alert  | [deploy-rv_backuphealth_alert.json](../../../services/RecoveryServices/vaults/Modify-RSV-BackupHealth-Alert.json)                          | modify                    |
| Deploy_StorageAccount_Availability_Alert | [deploy-sa_availability_alert.json](../../../services/Storage/storageAccounts/Deploy-SA-Availability-Alert.json)                           | deployIfNotExists         |
| Deploy_activitylog_StorageAccount_Delete | [Deploy_activitylog_StorageAccount_Delete.json](../../../services/Storage/storageAccounts/Deploy_activitylog_StorageAccount_Delete.json)   | deployIfNotExists         |
| Deploy_activitylog_LAWorkspace_Delete    | [deploy-activitylog-LAWorkspace-Del.json](../../../services/OperationalInsights/workspaces/Deploy-ActivityLog-LAWorkspace-Del.json)        | deployIfNotExists         |
| Deploy_activitylog_LAWorkspace_KeyRegen  | [deploy-activitylog-LAWorkspace-ReGen.json](../../../services/OperationalInsights/workspaces/Deploy-ActivityLog-LAWorkspace-KeyRegen.json) | deployIfNotExists         |

## Identity initiative

This initiative is intended for assignment of policies relevant to identity components in ALZ. With the guidance provided in [Introduction to deploying the ALZ Pattern](../deploy/Introduction-to-deploying-the-ALZ-Pattern), this will assign to the alz-platform-identity management group structure in the ALZ reference architecture. For details on which policies are included in the initiative as well as what the default enablement state of the policy is, refer to the below table.

| **Policy Name**                          | **Path to policy json file**                                                                                                             | **Policy default effect** |
| ---------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------- | ------------------------- |
| Deploy_KeyVault_Requests_Alert           | [deploy-kv_requests_alert.json](../../../services/KeyVault/vaults/Deploy-KV-Requests-Alert.json)                                         | disabled                  |
| Deploy_activitylog_StorageAccount_Delete | [Deploy_activitylog_StorageAccount_Delete.json](../../../services/Storage/storageAccounts/Deploy_activitylog_StorageAccount_Delete.json) | deployIfNotExists         |
| Deploy_KeyVault_Availability_Alert       | [deploy-kv_availability_alert.json](../../../services/KeyVault/vaults/Deploy-KV-Availability-Alert.json)                                 | disabled                  |
| Deploy_KeyVault_Latency_Alert            | [deploy-kv_latency_alert.json](../../../services/KeyVault/vaults/Deploy-KV-Latency-Alert.json)                                           | disabled                  |
| Deploy_KeyVault_Capacity_Alert           | [deploy-kv_capacity_alert.json](../../../services/KeyVault/vaults/Deploy-KV-Capacity-Alert.json)                                         | disabled                  |
| Deploy_activitylog_KeyVault_Delete       | [deploy-activitylog-KeyVault-Del.json](../../../services/KeyVault/vaults/Deploy-ActivityLog-KeyVault-Del.json)                           | deployIfNotExists         |

## Landing Zone initiative

This initiative is intended for assignment of policies relevant to a landing zone in the ALZ structure. With the guidance provided in [Introduction to deploying the ALZ Pattern](../deploy/Introduction-to-deploying-the-ALZ-Pattern) this will be assigned to the Landing Zones management group in the ALZ reference architecture. For details on which policies are included in the initiative as well as what the default enablement state of the policy is, refer to the below table.

| **Policy Name**                                | **Path to policy json file**                                                                                                                         | **Policy default effect** |
| ---------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------- |
| Deploy_StorageAccount_Availability_Alert       | [deploy-sa_availability_alert.json](../../../services/Storage/storageAccounts/Deploy-SA-Availability-Alert.json)                                     | deployIfNotExists         |
| Deploy_KeyVault_Requests_Alert                 | [deploy-kv_requests_alert.json](../../../services/KeyVault/vaults/Deploy-KV-Requests-Alert.json)                                                     | disabled                  |
| Deploy_KeyVault_Availability_Alert             | [deploy-kv_availability_alert.json](../../../services/KeyVault/vaults/Deploy-KV-Availability-Alert.json)                                             | deployIfNotExists-        |
| Deploy_KeyVault_Latency_Alert                  | [deploy-kv_latency_alert.json](../../../services/KeyVault/vaults/Deploy-KV-Latency-Alert.json)                                                       | deployIfNotExists         |
| Deploy_KeyVault_Capacity_Alert                 | [deploy-kv_capacity_alert.json](../../../services/KeyVault/vaults/Deploy-KV-Capacity-Alert.json)                                                     | deployIfNotExists         |
| Deploy_activitylog_KeyVault_Delete             | [deploy-activitylog-KeyVault-Del.json](../../../services/KeyVault/vaults/Deploy-ActivityLog-KeyVault-Del.json)                                       | deployIfNotExists         |
| Deploy_activitylog_RouteTable_Update           | [deploy-activitylog-RouteTable-Update.json](../../../services/Network/routeTables/Deploy-ActivityLog-RouteTable-Update.json)                         | deployIfNotExists         |
| Deploy_activitylog_NSG_Delete                  | [deploy-activitylog-NSG-Del.json](../../../services/Network/networkSecurityGroups/Deploy-ActivityLog-NSG-Del.json)                                   | deployIfNotExists         |
| Deploy_PublicIp_BytesInDDoSAttack_Alert        | [deploy-pip_bytesinddosattack_alert.json](../../../services/Network/publicIPAddresses/Deploy-PIP-BytesInDDOSAttack-Alert.json)                       | disabled                  |
| Deploy_PublicIp_DDoSAttack_Alert               | [deploy-pip_ddosattack_alert.json](../../../services/Network/publicIPAddresses/Deploy-PIP-DDOSAttack-Alert.json)                                     | deployIfNotExists         |
| Deploy_PublicIp_PacketsInDDoSAttack_Alert      | [deploy-pip_packetsinddos_alert.json](../../../services/Network/publicIPAddresses/Deploy-PIP-PacketsInDDOS-Alert.json)                               | disabled                  |
| Deploy_PublicIp_VIPAvailability_Alert          | [deploy-pip_vipavailability_alert.json](../../../services/Network/publicIPAddresses/Deploy-PIP-VIPAvailability-Alert.json)                           | deployIfNotExists         |
| Deploy_VNET_DDoSAttack_Alert                   | [deploy-vnet_ddosattack_alert.json](../../../services/Network/virtualNetworks/Deploy-VNET-DDOSAttack-Alert.json)                                     | deployIfNotExists         |
| Deploy_RecoveryVault_BackupHealthMonitor_Alert | [deploy-rv_backuphealth_monitor.json](../../../services/RecoveryServices/vaults/Modify-RSV-BackupHealth-Alert.json)                                  | modify                    |
| Deploy_VM_HeartBeat_Alert                      | [deploy-vm-HeartBeat_alert.json](../../../services/Compute/virtualMachines/Deploy-VM-HeartBeat-Alert.json)                                           | deployIfNotExists         |
| Deploy_VM_NetworkIn_Alert                      | [deploy-vm-NetworkIn_alert.json](../../../services/Compute/virtualMachines/Deploy-VM-NetworkIn-Alert.json)                                           | deployIfNotExists         |
| Deploy_VM_NetworkOut_Alert                     | [deploy-vm-NetworkOut_alert.json](../../../services/Compute/virtualMachines/Deploy-VM-NetworkOut-Alert.json)                                         | deployIfNotExists         |
| Deploy_VM_OSDiskreadLatency_Alert              | [deploy-vm-OSDiskreadLatency_alert.json](../../../services/Compute/virtualMachines/Deploy-VM-OSDiskReadLatency-Alert.json)                           | deployIfNotExists         |
| Deploy_VM_OSDiskwriteLatency_Alert             | [deploy-vm-OSDiskwriteLatency_alert.json](../../../services/Compute/virtualMachines/Deploy-VM-OSDiskWriteLatency-Alert.json)                         | deployIfNotExists         |
| Deploy_VM_OSDiskSpace_Alert                    | [deploy-vm-OSDiskSpace_alert.json](../../../services/Compute/virtualMachines/Deploy-VM-OSDiskSpace-Alert.json)                                       | deployIfNotExists         |
| Deploy_VM_CPU_Alert                            | [deploy-vm-PercentCPU_alert.json](../../../services/Compute/virtualMachines/Deploy-VM-PercentCPU-Alert.json)                                         | deployIfNotExists         |
| Deploy_VM_Memory_Alert                         | [deploy-vm-PercentMemory_alert.json](../../../services/Compute/virtualMachines/Deploy-VM-PercentMemory-Alert.json)                                   | deployIfNotExists         |
| Deploy_VM_dataDiskSpace_Alert                  | [deploy-vm-dataDiskSpace_alert.json](../../../services/Compute/virtualMachines/Deploy-VM-DataDiskSpace-Alert.json)                                   | deployIfNotExists         |
| Deploy_VM_dataDiskReadLatency_Alert            | [deploy-vm-dataDiskreadLatency_alert.json](../../../services/Compute/virtualMachines/Deploy-VM-DataDiskReadLatency-Alert.json)                       | deployIfNotExists         |
| Deploy_VM_dataDiskWriteLatency_Alert           | [deploy-vm-dataDiskwriteLatency_alert.json](../../../services/Compute/virtualMachines/Deploy-VM-DataDiskWriteLatency-Alert.json)                     | deployIfNotExists         |
| Deploy_AG_ApplicationGatewayTotalTime_Alert    | [Deploy-AGW-ApplicationGatewayTotalTime-Alert.json](../../../services/Network/applicationGateways/Deploy-AGW-ApplicationGatewayTotalTime-Alert.json) | deployIfNotExists         |
| Deploy_AG_BackendLastByteResponseTime_Alert    | [Deploy-AGW-BackendLastByteResponseTime-Alert.json](../../../services/Network/applicationGateways/Deploy-AGW-BackendLastByteResponseTime-Alert.json) | deployIfNotExists         |
| Deploy_AG_CapacityUnits_Alert                  | [Deploy-AGW-CapacityUnits-Alert.json](../../../services/Network/applicationGateways/Deploy-AGW-CapacityUnits-Alert.json)                             | deployIfNotExists         |
| Deploy_AG_ComputeUnits_Alert                   | [Deploy-AGW-ComputeUnits-Alert.json](../../../services/Network/applicationGateways/Deploy-AGW-ComputeUnits-Alert.json)                               | deployIfNotExists         |
| Deploy_AG_CPUUtilization_Alert                 | [Deploy-AGW-CPUUtil-Alert.json](../../../services/Network/applicationGateways/Deploy-AGW-CPUUtil-Alert.json)                                         | deployIfNotExists         |
| Deploy_AG_FailedRequests_Alert                 | [Deploy-AGW-FailedRequests-Alert.json](../../../services/Network/applicationGateways/Deploy-AGW-FailedRequests-Alert.json)                           | deployIfNotExists         |
| Deploy_AG_ResponseStatus_Alert                 | [Deploy-AGW-ResponseStatus-Alert.json](../../../services/Network/applicationGateways/Deploy-AGW-ResponseStatus-Alert.json)                           | deployIfNotExists         |
| Deploy_AG_UnhealthyHostCount_Alert             | [Deploy-AGW-UnhealthyHostCount-Alert.json](../../../services/Network/applicationGateways/Deploy-AGW-UnhealthyHostCount-Alert.json)                   | deployIfNotExists         |

## Service Health initiative

This initiative is intended for assignment of policies relevant to service health alerts in ALZ. With the guidance provided in [Introduction to deploying the ALZ Pattern](../deploy/Introduction-to-deploying-the-ALZ-Pattern), this will assign to the alz intermediate root management group structure in the ALZ reference architecture. For details on which policies are included in the initiative as well as what the default enablement state of the policy is, refer to the below table.

| **Policy Name**                                   | **Path to policy json file**                                                                                                                                 | **Policy default effect** |
| ------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------ | ------------------------- |
| Deploy_activitylog_ServiceHealth_SecurityAdvisory | [deploy-activitylog-ServiceHealth-Security.json](../../../services/Resources/subscriptions/Deploy-ActivityLog-ServiceHealth-Security.json)                   | deployIfNotExists         |
| Deploy_activitylog_ResourceHealth_Unhealthy_Alert | [deploy-activitylog-ResourceHealth-UnHealthly-alert.json](../../../services/Resources/subscriptions/Deploy-ActivityLog-ResourceHealth-UnHealthly-Alert.json) | deployIfNotExists         |
| Deploy_activitylog_ServiceHealth_HealthAdvisory   | [deploy-activitylog-ServiceHealth-Health.json](../../../services/Resources/subscriptions/Deploy-ActivityLog-ServiceHealth-Health.json)                       | deployIfNotExists         |
| Deploy_activitylog_ServiceHealth_Incident         | [deploy-activitylog-ServiceHealth-Incident.json](../../../services/Resources/subscriptions/Deploy-ActivityLog-ServiceHealth-Incident.json)                   | deployIfNotExists         |
| Deploy_activitylog_ServiceHealth_Maintenance      | [deploy-activitylog-ServiceHealth-Maintenance.json](../../../services/Resources/subscriptions/Deploy-ActivityLog-ServiceHealth-Maintenance.json)             | deployIfNotExists         |
| Deploy_ServiceHealth_ActionGroups                 | [deploy-ServiceHealth-ActionGroups.json](../../../services/Resources/subscriptions/Deploy-ServiceHealth-ActionGroups.json)                                   | deployIfNotExists         |

## Notification Assets initiative

This initiative is intended for assignment of policies relevant to notification in ALZ. With the guidance provided in [Introduction to deploying the ALZ Pattern](../deploy/Introduction-to-deploying-the-ALZ-Pattern), this will assign to the alz intermediate root management group structure in the ALZ reference architecture. For details on which policies are included in the initiative as well as what the default enablement state of the policy is, refer to the below table.

| **Policy Display Name**                    | **Reference ID**                     | **Path to policy json file**                                                                                                              | **Policy default effect** |
| ------------------------------------------ | ------------------------------------ | ----------------------------------------------------------------------------------------------------------------------------------------- | ------------------------- |
| Deploy AMBA Notification Assets            | ALZ_AlertProcessing_Rule             | [deploy-AlertProcessingRule-deploy.json](../../../services/AlertsManagement/actionRules/Deploy-AlertProcessingRule-Deploy.json)           | deployIfNotExists         |
| Deploy AMBA Notification Suppression Asset | ALZ_Suppression_AlertProcessing_Rule | [deploy-AlertProcessingRule-Suppression.json](../../../services/AlertsManagement/actionRules/Deploy-AlertProcessingRule-Suppression.json) | deployIfNotExists         |
