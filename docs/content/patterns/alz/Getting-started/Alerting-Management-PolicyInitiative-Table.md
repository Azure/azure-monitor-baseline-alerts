---
title: Alerting-Management Policy Initiative table
geekdocHidden: true
---

| Policy  Name | Policy Reference ID | Policy code (JSON) | Default policy effect |
| ------------ | ------------------- | ------------------ | --------------------- |
| Deploy Azure Monitor Baseline Alerts (AMBA-ALZ) - Activity Log LA Workspace Delete Alert | ALZ_activityLAWDelete | [Deploy-ActivityLog-LAWorkspace-Del.json](../../../../services/OperationalInsights/workspaces/Deploy-ActivityLog-LAWorkspace-Del.json) | deployIfNotExists |
| Deploy Azure Monitor Baseline Alerts (AMBA-ALZ) - Activity Log LA Workspace Regenerate Key Alert | ALZ_activityLAWKeyRegen | [Deploy-ActivityLog-LAWorkspace-KeyRegen.json](../../../../services/OperationalInsights/workspaces/Deploy-ActivityLog-LAWorkspace-KeyRegen.json) | deployIfNotExists |
| Deploy Azure Monitor Baseline Alerts (AMBA-ALZ) - LA Workspace Daily Cap Limit Reached Alert | ALZ_LAWorkspaceDailyCapLimitReached | [Deploy-LAWorkspace-DailyCapLimitReached-Alert.json](../../../../services/OperationalInsights/workspaces/Deploy-LAWorkspace-DailyCapLimitReached-Alert.json) | deployIfNotExists |
| Deploy Azure Monitor Baseline Alerts (AMBA-ALZ) - Automation Account TotalJob Alert | ALZ_AATotalJob | [Deploy-AA-TotalJob-Alert.json](../../../../services/Automation/automationAccounts/Deploy-AA-TotalJob-Alert.json) | deployIfNotExists |
| Deploy Azure Monitor Baseline Alerts (AMBA-ALZ) - RV Backup Health Monitoring Alerts | ALZ_RVBackupHealth | [Modify-RSV-BackupHealth-Alert.json](../../../../services/RecoveryServices/vaults/Modify-RSV-BackupHealth-Alert.json) | modify |
| Deploy Azure Monitor Baseline Alerts (AMBA-ALZ) - RV ASR Health Monitoring Alerts | ALZ_RVASRHealthMonitor | [Modify-RSV-ASRHealth-Alert.json](../../../../services/RecoveryServices/vaults/Modify-RSV-ASRHealth-Alert.json) | modify |
| Deploy Azure Monitor Baseline Alerts (AMBA-ALZ) - SA Availability Alert | ALZ_StorageAccountAvailability | [Deploy-SA-Availability-Alert.json](../../../../services/Storage/storageAccounts/Deploy-SA-Availability-Alert.json) | deployIfNotExists |
| Deploy Azure Monitor Baseline Alerts (AMBA-ALZ) - Activity Log Storage Account Delete Alert | ALZ_activitySADelete | [Deploy-ActivityLog-SA-Delete-Alert.json](../../../../services/Storage/storageAccounts/Deploy-ActivityLog-SA-Delete-Alert.json) | deployIfNotExists |
