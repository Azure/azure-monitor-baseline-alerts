---
title: What´s new
geekdocCollapseSection: true
weight: 10
---

For information on what's new please refer to the [Releases](https://github.com/Azure/azure-monitor-baseline-alerts/releases) page.

To update your current deployment with the content from the latest release, please refer to the [Update to new releases](../UpdateToNewReleases) page.

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
