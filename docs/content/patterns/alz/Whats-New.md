---
title: What´s new
geekdocCollapseSection: true
weight: 10
---

For information on what's new please refer to the [Releases](https://github.com/Azure/azure-monitor-baseline-alerts/releases) page.

To update your current deployment with the content from the latest release, please refer to the [Update to new releases](../UpdateToNewReleases) page.

## 2024-06-05

### New features

- Added new PIDs for different additional deployment methods. Refer to [Telemetry](../Telemetry) for more information.
- Added new initiative to monitor Azure Arc-enabled Virtual Machines. [Alerting-HybridVM](https://github.com/Azure/azure-monitor-baseline-alerts/blob/main/patterns/alz/policySetDefinitions/Deploy-HybridVM-Alerts.json)

### Bug fixes

- Changes the value of field minFailingPeriodsToAlert and numberOfEvaluationPeriods in the existenceCondition for the above alerts from 2 to 4 to fix the compliance evaluation issue.
- Changes the value of timeAggregation to Average for both Deploy AGW BackendLastByteResponseTime and Deploy AGW ApplicationGatewayTotalTime policy definitions. [Issue #194](https://github.com/Azure/azure-monitor-baseline-alerts/issues/194)
- Fixing case sensitive parameters [Issue #185](https://github.com/Azure/azure-monitor-baseline-alerts/issues/185)

### Documentation updates

- Updated the Deploy only Service Health Alert documentation. Addresses issues with using json-strings in cloud shell.

## 2024-04-12

### New features

- Updated Existence Condition to detect and remediate configuration drift. The following parameters were added to the Existence Condition of the policies:
  - Static alerts: EvaluationFrequency, WindowSize, Threshold, Severity, Operator, autoMitigate
  - Dynamic alerts: alertSensitivity, numberOfEvaluationPeriods, minFailingPeriodsToAlert
- Added a suppression Alert Processing Rule, deployed as part of the notification Assets policy. Refer to [Temporarily disabling notifications](../Temporarily-disabling-notifications) for more details.
- Supplying an email address for the Action Group is no longer mandatory.
- Bring your own Action Group and/or Alert Processing Rules. This feature  will allow brownfield customers to use existing Action Groups and Alert Processing Rules. Please refer to [Bring Your Own Notifications (BYON)](../Bring-your-own-Notifications) for more details.

### Bug fixes

- Fixed operator for `SNATPortUtilization` for Azure Firewall
- Corrected the name for the Deploy Activity Log Storage Account Delete Policy

### Documentation updates

- Updated deployment documentation to use the latest approved release.
- Updated the Deploy only Service Health Alert documentation.
- Updated the AMBA-ALZ Diagrams to include the new notification assets initiative and Action group options. [AMBA-Diagram](../../media/AMBA-Diagrams.vsdx)

## 2024-03-01

### New features

- The action group has been enhanced to allow more choices for notifications and actions
  - Email Azure Resource Manager Role
  - Azure Function
  - Event Hubs
  - Logic App
  - Webhook
- The service health initiative no longer includes the deployment of the Alert Processing Rule policy. Service Health now has its own Action Group.
- Added the [Notification Assets](https://raw.githubusercontent.com/Azure/azure-monitor-baseline-alerts/main/patterns/alz/policySetDefinitions/Deploy-Notification-Assets.json) initiative, which deploys the Alert Processing Rule and the Action Group used by the Connectivity, Identity, Management and Landing zone initiatives.
- New policy for Policy for Storage Account Deletion. [Issue #76](https://github.com/Azure/azure-monitor-baseline-alerts/issues/76)
- Updating the remediation script to allow for a better experience while remediating the new action group for Service Health

### Bug fixes

- Fixed: unable to deploy via pipeline using ubuntu-latest. [Issue #64](https://github.com/Azure/azure-monitor-baseline-alerts/issues/64)
- Fixed the PIP VIP alert existence condition to only check for standard SKU. [Issue #80](https://github.com/Azure/azure-monitor-baseline-alerts/issues/80)

### Documentation updates

- Updated [Deploy with GitHub Actions](../deploy/Deploy-with-GitHub-Actions) addressing [Issue #102](https://github.com/Azure/azure-monitor-baseline-alerts/issues/102)
- Updated guidance for AMA in [Monitoring and Alerting](../Monitoring-and-Alerting) documentation

## 2023-11-14

### New features

- The Service Health Policy Set Definition now includes parameters to set the Policy Effect. With this you can choose which Server Health alert rules are deployed. Note that the default value for the parameters is "deployIfNotExists". The parameter file has been updated.
- Added alert rules in the Landing Zone Policy Set Definition.
  - Front door (Microsoft.Cdn/profiles)
  - Front door classic (Microsoft.Network/frontdoors)
  - Traffic Manager (Microsoft.Network/trafficmanagerprofiles)
  - App Service (Microsoft.Web/serverfarms)

### Bug fixes

- Update path in sample-workflow [Issue #30](https://github.com/Azure/azure-monitor-baseline-alerts/issues/30)
- Update sample commands in Start-AMBARemediation.ps1 [Pull #49](https://github.com/Azure/azure-monitor-baseline-alerts/pull/49)
- Fixes to Role Assignment cleanup, cleanup script [Issue #42](https://github.com/Azure/azure-monitor-baseline-alerts/issues/42)
- Fixed VSCode template validation error [Issue #43](https://github.com/Azure/azure-monitor-baseline-alerts/issues/43)

### Documentation updates

- How to modify individual policies - [How to modify individual policies](../deploy/Introduction-to-deploying-the-ALZ-Pattern/#how-to-modify-individual-policies)
- Added guidance to only Server Health alert rules - [Deploy only Service Health Alerts](../deploy/Deploy-only-Service-Health-Alerts)
- New documentation on updating to a new release - [Update to new releases](../UpdateToNewReleases)
- FAQ Updates - [Frequently Asked Questions](../FAQ)
