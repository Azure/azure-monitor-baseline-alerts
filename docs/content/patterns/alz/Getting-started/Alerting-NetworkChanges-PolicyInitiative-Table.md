---
title: Alerting-NetworkChanges Policy Initiative table
geekdocHidden: true
---

| Policy  Name | Policy Reference ID | Policy code (JSON) | Default policy effect |
| ------------ | ------------------- | ------------------ | --------------------- |
| Deploy Azure Monitor Baseline Alerts (AMBA-ALZ) - Activity Log NSG Delete Alert | ALZ_activityNSGDelete | [Deploy-ActivityLog-NSG-Del.json](../../../../services/Network/networkSecurityGroups/Deploy-ActivityLog-NSG-Del.json) | deployIfNotExists |
| [Preview]: Deploy Azure Monitor Baseline Alerts (AMBA-ALZ) - Activity Log Routes Delete Alert | ALZ_activityUDRRoutesDelete | [Deploy-ActivityLog-RouteTable-Routes-Delete.json](../../../../services/Network/routeTables/Deploy-ActivityLog-RouteTable-Routes-Delete.json) | deployIfNotExists |
| [Preview]: Deploy Azure Monitor Baseline Alerts (AMBA-ALZ) - Activity Log Route Table Delete Alert | ALZ_activityUDRDelete | [Deploy-ActivityLog-RouteTable-Delete.json](../../../../services/Network/routeTables/Deploy-ActivityLog-RouteTable-Delete.json) | deployIfNotExists |
| Deploy Azure Monitor Baseline Alerts (AMBA-ALZ) - Activity Log Route Table Update Alert | ALZ_activityUDRUpdate | [Deploy-ActivityLog-RouteTable-Update.json](../../../../services/Network/routeTables/Deploy-ActivityLog-RouteTable-Update.json) | deployIfNotExists |
