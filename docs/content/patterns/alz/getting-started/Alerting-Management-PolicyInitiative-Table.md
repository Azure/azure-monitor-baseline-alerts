---
title: Alerting-Management Policy Initiative table
geekdocHidden: true
---

| Policy Display Name | Policy Internal Name | Policy Reference ID | Policy code (JSON) | Default policy effect |
| ------------------- | -------------------- |-------------------- | ------------------ | --------------------- |
| Deploy Azure Monitor Baseline Alerts (AMBA-ALZ) - Activity Log LA Workspace Delete Alert | Deploy_activitylog_LAWorkspace_Delete | ALZ_activityLAWDelete | [Deploy-ActivityLog-LAWorkspace-Del.json](../../../../services/OperationalInsights/workspaces/Deploy-ActivityLog-LAWorkspace-Del.json) | deployIfNotExists |
| Deploy Azure Monitor Baseline Alerts (AMBA-ALZ) - Activity Log LA Workspace Regenerate Key Alert | Deploy_activitylog_LAWorkspace_KeyRegen | ALZ_activityLAWKeyRegen | [Deploy-ActivityLog-LAWorkspace-KeyRegen.json](../../../../services/OperationalInsights/workspaces/Deploy-ActivityLog-LAWorkspace-KeyRegen.json) | deployIfNotExists |
| Deploy Azure Monitor Baseline Alerts (AMBA-ALZ) - LA Workspace Daily Cap Limit Reached Alert | Deploy_LAWorkspace_DailyCapLimitReached_Alert | ALZ_LAWorkspaceDailyCapLimitReached | [Deploy-LAWorkspace-DailyCapLimitReached-Alert.json](../../../../services/OperationalInsights/workspaces/Deploy-LAWorkspace-DailyCapLimitReached-Alert.json) | deployIfNotExists |
| Deploy Azure Monitor Baseline Alerts (AMBA-ALZ) - Automation Account TotalJob Alert | Deploy_AA_TotalJob_Alert | ALZ_AATotalJob | [Deploy-AA-TotalJob-Alert.json](../../../../services/Automation/automationAccounts/Deploy-AA-TotalJob-Alert.json) | deployIfNotExists |
| Deploy Azure Monitor Baseline Alerts (AMBA-ALZ) - RV Backup Health Monitoring Alerts | Deploy_RecoveryVault_BackupHealthMonitor_Alert | ALZ_RVBackupHealth | [Modify-RSV-BackupHealth-Alert.json](../../../../services/RecoveryServices/vaults/Modify-RSV-BackupHealth-Alert.json) | modify |
| Deploy Azure Monitor Baseline Alerts (AMBA-ALZ) - RV ASR Health Monitoring Alerts | Deploy_RecoveryVault_ASRHealthMonitor_Alert | ALZ_RVASRHealthMonitor | [Modify-RSV-ASRHealth-Alert.json](../../../../services/RecoveryServices/vaults/Modify-RSV-ASRHealth-Alert.json) | modify |
| Deploy Azure Monitor Baseline Alerts (AMBA-ALZ) - SA Availability Alert | Deploy_StorageAccount_Availability_Alert | ALZ_StorageAccountAvailability | [Deploy-SA-Availability-Alert.json](../../../../services/Storage/storageAccounts/Deploy-SA-Availability-Alert.json) | deployIfNotExists |
| Deploy Azure Monitor Baseline Alerts (AMBA-ALZ) - Activity Log Storage Account Delete Alert | Deploy_activitylog_StorageAccount_Delete | ALZ_activitySADelete | [Deploy-ActivityLog-SA-Delete-Alert.json](../../../../services/Storage/storageAccounts/Deploy-ActivityLog-SA-Delete-Alert.json) | deployIfNotExists |
