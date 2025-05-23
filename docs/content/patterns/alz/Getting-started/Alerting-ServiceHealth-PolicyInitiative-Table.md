---
title: Alerting-ServiceHealth Policy Initiative table
geekdocHidden: true
---

| Policy  Name | Policy Reference ID | Policy code (JSON) | Default policy effect |
| ------------ | ------------------- | ------------------ | --------------------- |
| Deploy Azure Monitor Baseline Alerts (AMBA-ALZ) - Service Health Action Group | ALZ_ServiceHealth_ActionGroups | [Deploy-ServiceHealth-ActionGroups.json](../../../../services/Resources/subscriptions/Deploy-ServiceHealth-ActionGroups.json) | deployIfNotExists |
| Deploy Azure Monitor Baseline Alerts (AMBA-ALZ) - Resource Health Unhealthy Alert | ALZ_ResHlthUnhealthy | [Deploy-ActivityLog-ResourceHealth-UnHealthly-Alert.json](../../../../services/Resources/subscriptions/Deploy-ActivityLog-ResourceHealth-UnHealthly-Alert.json) | disabled |
| Deploy Azure Monitor Baseline Alerts (AMBA-ALZ) - Service Health Advisory Alert | ALZ_SvcHlthAdvisory | [Deploy-ActivityLog-ServiceHealth-Health.json](../../../../services/Resources/subscriptions/Deploy-ActivityLog-ServiceHealth-Health.json) | disabled |
| Deploy Azure Monitor Baseline Alerts (AMBA-ALZ) - Service Health Incident Alert | ALZ_SvcHlthIncident | [Deploy-ActivityLog-ServiceHealth-Incident.json](../../../../services/Resources/subscriptions/Deploy-ActivityLog-ServiceHealth-Incident.json) | disabled |
| Deploy Azure Monitor Baseline Alerts (AMBA-ALZ) - Service Health Maintenance Alert | ALZ_SvcHlthMaintenance | [Deploy-ActivityLog-ServiceHealth-Maintenance.json](../../../../services/Resources/subscriptions/Deploy-ActivityLog-ServiceHealth-Maintenance.json) | disabled |
| Deploy Azure Monitor Baseline Alerts (AMBA-ALZ) - Service Health Security Advisory Alert | ALZ_svcHlthSecAdvisory | [Deploy-ActivityLog-ServiceHealth-Security.json](../../../../services/Resources/subscriptions/Deploy-ActivityLog-ServiceHealth-Security.json) | disabled |
