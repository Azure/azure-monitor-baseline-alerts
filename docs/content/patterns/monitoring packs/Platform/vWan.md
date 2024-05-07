---
title: vWan Monitoring Pack
geekdocCollapseSection: true
weight: 50
---
[Alerts](#alerts)

## Alerts

|DisplayName|Type|Description|
|---|---|---|
|[VPN Gateway Egress Packet Drop Count Alert](#vpn-gateway-egress-packet-drop-count-alert)|Microsoft.Insights/metricAlerts|VPNGW_EgDropCount_Alert|
|[Metric Alert for VPN Gateway tunnel ingress bytes](#metric-alert-for-vpn-gateway-tunnel-ingress-bytes)|Microsoft.Insights/metricAlerts|Deploy_VPNGW_TunnelIgBytes_Alert|
|[Metric Alert for VPN Gateway tunnel egress bytes](#metric-alert-for-vpn-gateway-tunnel-egress-bytes)|Microsoft.Insights/metricAlerts|Tunnel_Egress_Bytes_Alert|
|[Tunnel Average Bandwidth](#tunnel-average-bandwidth)|Microsoft.Insights/metricAlerts|Tunnel Average Bandwidth|
|[Metric Alert for VPN Gateway BGP peer status](#metric-alert-for-vpn-gateway-bgp-peer-status)|Microsoft.Insights/metricAlerts|BGP_Peer_Status_Alert|

### VPN Gateway Egress Packet Drop Count Alert

|Property | Value |
|---|---|
|Alert Type                    | Microsoft.Insights/metricAlerts |
|Alert Name                    |VPNGW_EgDropCount_Alert|
|Alert DisplayName             |VPN Gateway Egress Packet Drop Count Alert|
|Alert Description             |VPN Gateway Egress Packet Drop Count Alert|
|Metric Namespace             |microsoft.network/vpngateways|
|Severity                    |2|
|Metric Name                  |TunnelEgressPacketDropCount|
|Operator                     |GreaterThan|
|Evaluation Frequency       |PT15M|
|Windows Size                |PT15M|
|Threshold                 ||
|Auto Mitigate              |false|
|Initiative Member             |True|
|Pack Type                     |Platform|
|Time Aggregation              |Average|

### Metric Alert for VPN Gateway tunnel ingress bytes

|Property | Value |
|---|---|
|Alert Type                    | Microsoft.Insights/metricAlerts |
|Alert Name                    |Deploy_VPNGW_TunnelIgBytes_Alert|
|Alert DisplayName             |Metric Alert for VPN Gateway tunnel ingress bytes|
|Alert Description             |Policy to audit/deploy Metric Alert for VPN Gateway tunnel ingress bytes|
|Metric Namespace             |microsoft.network/vpngateways|
|Severity                    |0|
|Metric Name                  |tunnelingressbytes|
|Operator                     |LessThan|
|Evaluation Frequency       |PT5M|
|Windows Size                |PT5M|
|Threshold                 |1|
|Auto Mitigate              |false|
|Initiative Member             |True|
|Pack Type                     |Platform|
|Time Aggregation              ||

### Metric Alert for VPN Gateway tunnel egress bytes

|Property | Value |
|---|---|
|Alert Type                    | Microsoft.Insights/metricAlerts |
|Alert Name                    |Tunnel_Egress_Bytes_Alert|
|Alert DisplayName             |Metric Alert for VPN Gateway tunnel egress bytes|
|Alert Description             |Metric Alert for VPN Gateway tunnel egress bytes|
|Metric Namespace             |microsoft.network/vpngateways|
|Severity                    |0|
|Metric Name                  |tunnelegressbytes|
|Operator                     |LessThan|
|Evaluation Frequency       |PT5M|
|Windows Size                |PT5M|
|Threshold                 |1|
|Auto Mitigate              |false|
|Initiative Member             |True|
|Pack Type                     |Platform|
|Time Aggregation              ||

### Tunnel Average Bandwidth

|Property | Value |
|---|---|
|Alert Type                    | Microsoft.Insights/metricAlerts |
|Alert Name                    |Tunnel Average Bandwidth|
|Alert DisplayName             |Tunnel Average Bandwidth|
|Alert Description             |Metric Alert for VPN Gateway Bandwidth Utilization|
|Metric Namespace             |microsoft.network/vpngateways|
|Severity                    |0|
|Metric Name                  |tunnelaveragebandwidth|
|Operator                     |LessThan|
|Evaluation Frequency       |PT1M|
|Windows Size                |PT5M|
|Threshold                 |1|
|Auto Mitigate              |false|
|Initiative Member             |True|
|Pack Type                     |Platform|
|Time Aggregation              ||

### Metric Alert for VPN Gateway BGP peer status

|Property | Value |
|---|---|
|Alert Type                    | Microsoft.Insights/metricAlerts |
|Alert Name                    |BGP_Peer_Status_Alert|
|Alert DisplayName             |Metric Alert for VPN Gateway BGP peer status|
|Alert Description             |Metric Alert for VPN Gateway BGP peer status|
|Metric Namespace             |microsoft.network/vpngateways|
|Severity                    |0|
|Metric Name                  |bgppeerstatus|
|Operator                     |LessThan|
|Evaluation Frequency       |PT1M|
|Windows Size                |PT5M|
|Threshold                 |1|
|Auto Mitigate              |false|
|Initiative Member             |True|
|Pack Type                     |Platform|
|Time Aggregation              ||

## Diagnostic Settings

|Diagnostics Log|
|---|
|@{categoryGroup=allLogs; enabled=True}|
