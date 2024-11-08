---
title: What's New
geekdocCollapseSection: true
weight: 09
---

For the latest updates, visit the [Releases](https://github.com/Azure/azure-monitor-baseline-alerts/releases) page.

To update your deployment with the latest release, refer to the [Update to new releases](../../HowTo/UpdateToNewReleases) guide.

## 2024-09-02

### New Features

- **AMBA Portal Accelerator**: Introducing the Azure Monitor Baseline Alerts Accelerator, now in preview! Deploy alerts quickly and confidently through the Azure Portal UI. For detailed instructions, see [Deploy via the Azure Portal (Preview)](../deploy/Deploy-via-Azure-Portal-UI).

- **Modular Initiatives**: The former Landing Zone Initiative is deprecated. We now offer a modular approach with distinct components. For more details, visit [Policy Initiatives](../Policy-Initiatives).

  - Key Management
  - Load Balancing
  - Network Changes
  - Recovery Services
  - Storage
  - VM
  - Web

- **Threshold Override**: Adjust alert thresholds for specific resources using a tag. This feature is available for metrics and log alerts. Learn more: [Alert Threshold Override](../Available_features/Threshold-Override).

- **Custom Tags to Disable Monitoring**: Specify a tag name and values to disable monitoring for certain resources.

- New alert rule for Azure Key Vault Managed HSM, included in Identity and Key Management initiatives.
- New Daily Cap threshold alert for Log Analytics workspace, added to the Management initiative.
- New Application Insight Throttling alert, included in the Web initiative.
- New ActivityLog Alert for deleting Application Insight, added to the Web initiative.
- Ability to change Application Gateway dynamic alert sensitivity.

- **Deprecated** the Landing Zone Initiative.

### Bug Fixes

- Fixed [[#280](https://github.com/Azure/azure-monitor-baseline-alerts/issues/280)]: AGW Compute Units Alert and AGW Unhealthy Host Count Alert remain non-compliant after remediation.
- Fixed [[#278](https://github.com/Azure/azure-monitor-baseline-alerts/issues/278)]: Deploy VNetG ExpressRoute CPU Utilization Alert remediation fails.
- Fixed [[#284](https://github.com/Azure/azure-monitor-baseline-alerts/issues/284)]: AMBA policy ALZ_ServiceHealth_ActionGroups missing during remediation.
- Fixed [[#253](https://github.com/Azure/azure-monitor-baseline-alerts/issues/253)]: Older version used in documentation.
- Fixed [[#261](https://github.com/Azure/azure-monitor-baseline-alerts/issues/261)]: Display name VMLowOSDisk(Write/Read)LatencyAlert should be VMHighOSDisk(Write/Read)LatencyAlert.
- Fixed [[#260](https://github.com/Azure/azure-monitor-baseline-alerts/issues/260)]: No threshold parameter for ALZ alerts ALZ_WSFMemoryPercentage, ALZ_WSFCPUPercentage.
- Fixed casing in metadata and policies.
- Fixed default values for multiple parameters in VM and Hybrid initiatives.

### Documentation Updates

- Added new policies for ExpressRoute Ports to Connectivity table. [Policy Initiatives](../Policy-Initiatives).
- Updated documentation on unsupported/unrecommended Tenant Root Group deployment. [FAQ](../FAQ).
- New guidance for bringing your own Managed Identity. [Bring Your Own User Assigned Managed Identity](../Available_features/Bring-Your-Own-User-Assigned-Managed-Identity).
- Updated Policy Initiatives documentation to include Policy Reference ID and display names. [Policy Initiatives](../Policy-Initiatives).

### Tools

- **Automation**: New workflow automates ARM template creation for Azure Policies/PolicySets, triggered by pull request events.

## 2024-06-05

### New Features

- Added new PIDs for additional deployment methods. See [Disable telemetry tracking](../../HowTo/Telemetry) for more information.
- New initiative to monitor Azure Arc-enabled Virtual Machines. [Alerting-HybridVM](https://github.com/Azure/azure-monitor-baseline-alerts/blob/main/patterns/alz/policySetDefinitions/Deploy-HybridVM-Alerts.json).

### Bug Fixes

- Changed minFailingPeriodsToAlert and numberOfEvaluationPeriods in existenceCondition from 2 to 4 to fix compliance evaluation.
- Changed timeAggregation to Average for AGW BackendLastByteResponseTime and AGW ApplicationGatewayTotalTime policies. [Issue #194](https://github.com/Azure/azure-monitor-baseline-alerts/issues/194).
- Fixed case-sensitive parameters [Issue #185](https://github.com/Azure/azure-monitor-baseline-alerts/issues/185).

### Documentation Updates

- Updated Deploy only Service Health Alert documentation for json-strings in cloud shell.

## 2024-04-12

### New Features

- Updated Existence Condition to detect and remediate configuration drift. The following parameters were added to the Existence Condition of the policies:

  - Static alerts: EvaluationFrequency, WindowSize, Threshold, Severity, Operator, autoMitigate

  - Dynamic alerts: alertSensitivity, numberOfEvaluationPeriods, minFailingPeriodsToAlert

- Added suppression Alert Processing Rule in notification Assets policy. See [Temporarily disabling notifications](../../HowTo/Temporarily-disabling-notifications) for details.
- Email address for Action Group is no longer mandatory.
- Bring your own Action Group and/or Alert Processing Rules. See [Bring Your Own Notifications (BYON)](../../HowTo/Bring-your-own-Notifications) for details.

### Bug Fixes

- Fixed operator for `SNATPortUtilization` for Azure Firewall.
- Corrected name for Deploy Activity Log Storage Account Delete Policy.

### Documentation Updates

- Updated deployment documentation to use the latest release.
- Updated Deploy only Service Health Alert documentation.
- Updated AMBA-ALZ Diagrams to include new notification assets initiative and Action group options. [AMBA-Diagram](../../media/AMBA-Diagrams.vsdx).

## 2024-03-01

### New Features

- Enhanced action group for more notification and action choices:
  - Email Azure Resource Manager Role
  - Azure Function
  - Event Hubs
  - Logic App
  - Webhook
- Service health initiative now has its own Action Group.
- Added [Notification Assets](https://raw.githubusercontent.com/Azure/azure-monitor-baseline-alerts/main/patterns/alz/policySetDefinitions/Deploy-Notification-Assets.json) initiative.
- New policy for Storage Account Deletion. [Issue #76](https://github.com/Azure/azure-monitor-baseline-alerts/issues/76).
- Updated remediation script for better experience with new action group for Service Health.

### Bug Fixes

- Fixed: unable to deploy via pipeline using ubuntu-latest. [Issue #64](https://github.com/Azure/azure-monitor-baseline-alerts/issues/64).
- Fixed PIP VIP alert existence condition to check only for standard SKU. [Issue #80](https://github.com/Azure/azure-monitor-baseline-alerts/issues/80).

### Documentation Updates

- Updated [Deploy with GitHub Actions](../deploy/Deploy-with-GitHub-Actions) addressing [Issue #102](https://github.com/Azure/azure-monitor-baseline-alerts/issues/102).
- Updated guidance for AMA in [Monitoring and Alerting](../../Getting-started/Monitoring-and-Alerting).

## 2023-11-14

### New Features

- Service Health Policy Set Definition now includes parameters to set Policy Effect. Default value is "deployIfNotExists".
- Added alert rules in Landing Zone Policy Set Definition:
  - Front door (Microsoft.Cdn/profiles)
  - Front door classic (Microsoft.Network/frontdoors)
  - Traffic Manager (Microsoft.Network/trafficmanagerprofiles)
  - App Service (Microsoft.Web/serverfarms)

### Bug Fixes

- Updated path in sample-workflow [Issue #30](https://github.com/Azure/azure-monitor-baseline-alerts/issues/30).
- Updated sample commands in Start-AMBARemediation.ps1 [Pull #49](https://github.com/Azure/azure-monitor-baseline-alerts/pull/49).
- Fixed Role Assignment cleanup script [Issue #42](https://github.com/Azure/azure-monitor-baseline-alerts/issues/42).
- Fixed VSCode template validation error [Issue #43](https://github.com/Azure/azure-monitor-baseline-alerts/issues/43).

### Documentation Updates

- How to modify individual policies - [How to modify individual policies](../../HowTo/deploy/Introduction-to-deploying-the-ALZ-Pattern/#how-to-modify-individual-policies).
- Added guidance for Server Health alert rules - [Deploy only Service Health Alerts](../../HowTo/deploy/Deploy-only-Service-Health-Alerts).
- New documentation on updating to a new release - [Update to new releases](../../HowTo/UpdateToNewReleases).
- FAQ Updates - [Frequently Asked Questions](../../Resources//FAQ).

[Back to top of page](.)
