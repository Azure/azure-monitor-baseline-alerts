---
title: Alerting-Web Policy Initiative table
geekdocHidden: true
---

| Policy  Name | Policy Reference ID | Policy code (JSON) | Default policy effect |
| ------------ | ------------------- | ------------------ | --------------------- |
| Deploy Azure Monitor Baseline Alerts (AMBA-ALZ) - App Service Plan CPU Percentage Alert | ALZ_WSFCPUPercentage | [Deploy-WSF-CPUPercentage-Alert.json](../../../../services/Web/serverFarms/Deploy-WSF-CPUPercentage-Alert.json) | deployIfNotExists |
| Deploy Azure Monitor Baseline Alerts (AMBA-ALZ) - App Service Plan Memory Percentage Alert | ALZ_WSFMemoryPercentage | [Deploy-WSF-MemoryPercentage-Alert.json](../../../../services/Web/serverFarms/Deploy-WSF-MemoryPercentage-Alert.json) | deployIfNotExists |
| Deploy Azure Monitor Baseline Alerts (AMBA-ALZ) - App Service Plan Disk Queue Length Alert | ALZ_WSFDiskQueueLength | [Deploy-WSF-DiskQueueLength-Alert.json](../../../../services/Web/serverFarms/Deploy-WSF-DiskQueueLength-Alert.json) | deployIfNotExists |
| Deploy Azure Monitor Baseline Alerts (AMBA-ALZ) - App Service Plan Http Queue Length Alert | ALZ_WSFHttpQueueLength | [Deploy-WSF-HttpQueueLength-Alert.json](../../../../services/Web/serverFarms/Deploy-WSF-HttpQueueLength-Alert.json) | deployIfNotExists |
| Deploy Azure Monitor Baseline Alerts (AMBA-ALZ) - Application Insights Throttling Limit Reached Alert | ALZ_AppInsightsThrottlingLimitReached_Alert | [Deploy-AppInsightsThrottlingLimit-Alert.json](../../../../services/Insights/components/Deploy-AppInsightsThrottlingLimit-Alert.json) | deployIfNotExists |
| Deploy Azure Monitor Baseline Alerts (AMBA-ALZ) - Activity Log Application Insights Delete Alert | ALZ_activityAppInsightsDelete | [Deploy-ActivityLog-AppInsights-Del.json](../../../../services/Insights/components/Deploy-ActivityLog-AppInsights-Del.json) | deployIfNotExists |
| Deploy Azure Monitor Baseline Alerts (AMBA-ALZ) - Activity Log LA Workspace Delete Alert | ALZ_activityLAWDelete | [Deploy-ActivityLog-LAWorkspace-Del.json](../../../../services/OperationalInsights/workspaces/Deploy-ActivityLog-LAWorkspace-Del.json) | deployIfNotExists |
| Deploy Azure Monitor Baseline Alerts (AMBA-ALZ) - Activity Log LA Workspace Regenerate Key Alert | ALZ_activityLAWKeyRegen | [Deploy-ActivityLog-LAWorkspace-KeyRegen.json](../../../../services/OperationalInsights/workspaces/Deploy-ActivityLog-LAWorkspace-KeyRegen.json) | deployIfNotExists |
| Deploy Azure Monitor Baseline Alerts (AMBA-ALZ) - LA Workspace Daily Cap Limit Reached Alert | ALZ_LAWorkspaceDailyCapLimitReached | [Deploy-LAWorkspace-DailyCapLimitReached-Alert.json](../../../../services/OperationalInsights/workspaces/Deploy-LAWorkspace-DailyCapLimitReached-Alert.json) | deployIfNotExists |
