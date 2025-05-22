---
title: What's New
geekdocCollapseSection: true
weight: 09
---

### In this page

> [2025-04-04](../Whats-New#2025-04-04) </br>
> [2025-03-03](../Whats-New#2025-03-03) </br>
> [2025-02-05](../Whats-New#2025-02-05) </br>
> [2025-01-10](../Whats-New#2025-01-10) </br>
> [2024-12-10](../Whats-New#2024-12-10) </br>
> [2024-11-01](../Whats-New#2024-11-01) </br>
> [2024-09-02](../Whats-New#2024-09-02) </br>
> [2024-06-05](../Whats-New#2024-06-05) </br>
> [2024-04-12](../Whats-New#2024-04-12) </br>
> [2024-03-01](../Whats-New#2024-03-01) </br>
> [2023-11-14](../Whats-New#2023-11-14) </br>

For the latest updates, visit the [Releases](https://github.com/Azure/azure-monitor-baseline-alerts/releases) page.

To update your deployment with the latest release, refer to the [Update to new releases](../../HowTo/UpdateToNewReleases) guide.

To see what we have been and are working on, refer to the [AMBA Public Roadmap](https://aka.ms/amba/roadmap/alz) filtered for the ALZ pattern.

## 2025-04-04

### New Features

- Ability to exclude Management Groups and/or Subscriptions from policy assignments [Exclude Management Groups and/or Subscriptions from Policy Assignment](../../HowTo/Exclude_resources_from_policy_assignment).

### Bug Fixes

- Resolved [[#553](https://github.com/Azure/azure-monitor-baseline-alerts/pull/553)]: AMBA-ALZ portal not honoring RG name customization

### Documentation Updates

- The [MonitorDisable Parameter](../../HowTo/Disabling-Policies#monitordisable-parameter) section of the [Disable Policies](../../HowTo/Disabling-Policies) page Was updated to clarify the parameter behavior difference when used with metric or log-search alerts.
- Added a new entry under the [How to](../../HowTo/_index) section to document the new [Exclude Management Groups and/or Subscriptions from Policy Assignment](../../HowTo/Exclude_resources_from_policy_assignment) feature.

### Tools

- Updated the UnitTest to ensure the correct policy version update.

## 2025-03-03

### New Features

- Ability to securely store log-search alerts in the CMK protected linked storage account. Detailed information on how to use this new feature can be found in the [Secure log search alert queries with Customer-managed key](../../HowTo/Customer_managed_key_for_log_search_alerts) page.
- Added the following new alerts to the Web Initiative:
  - LA Workspace Daily Cap Limit Reached Alert
  - Activity Log LA Workspace Workspace Regenerate Key Alert
  - Activity Log LA Workspace Delete Alert

### Bug Fixes

- Resolved [[#530](https://github.com/Azure/azure-monitor-baseline-alerts/issues/530)]: [General workload issue]: deployment validation failed (Az Portal) when disabling both Hybrid VM and Azure VM options (MG Settings)

### Documentation Updates

- The [The Azure Landing Zones (ALZ) Pattern](../../Overview/ALZ-Pattern) page contains an info box to raise awareness about an upcoming change in the Azure Service health space, which has no impact on the AMBA-ALZ functionalities.has been aligned with the alerts.
- The [Deploy only Service Health Alerts](../../HowTo/deploy/Deploy-only-Service-Health-Alerts) page contains an info box to raise awareness about an upcoming change in the Azure Service health space, which has no impact on the AMBA-ALZ functionalities.has been aligned with the alerts.
- Added a new entry in the [Known Issues](../../Resources/Known-Issues) page to help customer resolving common errors during the AMBA-ALZ update from previous versions

### Tools

- Added a new UnitTest to ensure the correct policy versioning for updated or new policies.

## 2025-02-05

### New Features

- Exclusion of logical volumes from the following alerts for both ***Azure*** and ***Hybrid*** Virtual Machines:
  - Operating System Disk Free space
  - Operating System DiskRead latency
  - Operating System DiskWrite latency
  - Data Disks Free space
  - Data Disks Read latency
  - Data Disks Write latency

  Detailed information on how to use this new feature can be found in the [Exclude logical volumes](../../HowTo/Exclude-Logical-Volumes) page.

- Optimizations of calls to Azure Resource Graph inside log-search alert queries. This optimization should reduce and mitigate the throttling issue.

### Bug Fixes

- Resolved [[#508](https://github.com/Azure/azure-monitor-baseline-alerts/issues/508)]: [General workload issue]: deploy-amba-web assignment missing Managed Identity Operator role on UAMI
- Resolved [[#499](https://github.com/Azure/azure-monitor-baseline-alerts/pull/499)]: fix: ALZ Pattern add missing `/` to fix regression introduced by PG

### Documentation Updates

- The [Policy Initiatives](../../Getting-started/Policy-Initiatives.md) page has been aligned with the alerts.
- The [Bring Your Own User Assigned Managed Identity](../../HowTo/Bring-your-own-Managed-Identity) page has been updated with list the policy initiatives that make use of Managed Identity for log-search alerts.
- An ***In this page*** section with links to contained paragraphs has been added at the top of each page to increase the navigation experience.
- Broken links are fixed.

### Tools

- NONE

## 2025-01-10

### New Features

- General Availability for AMBA Portal accelerator. Together with this, the portal accelerator has been enhanced with some nice filtering capabilities allowing you to see only management groups parented with the selected pseudo. The same capability also applies to subscription selection for which you will be only presented those belonging to the pseudo management group
- Remediation script enhancement: The former **Start-AMBARemediation.ps1** remediation script has been redesigned, optimized and standardized into a new one called [***Start-AMBA-ALZ-Remediation.ps1***](https://github.com/Azure/azure-monitor-baseline-alerts/blob/main/patterns/alz/scripts/Start-AMBA-ALZ-Remediation.ps1)
- Added new policy definition for Application Insights alerts as part of the Alerting-Web initiative:
  - Deploy Activity Log Application Insights Delete Alert (Preview)
  - Deploy Application Insights Throttling Limit Reached Alert (Preview)
- Added new policies to create Alert rules for Route Table activity:
  - [Preview]: Deploy Activity Log Routes Delete Alert
  - [Preview]: Deploy Activity Log Route Table Delete Alert
- Alert Processing Rule flexibility: Alert Processing Rule policy now includes new parameters to specify which severities are including as a filter. By default the Alert Processing Rule includes all 5 severities from ***Sev0*** to ***Sev4***. Customer can leave the default values or remove the unnecessary ones to reduce the number of alerts that will be processed by the Alert Processing Rule

### Bug Fixes

- Resolved [[#455](https://github.com/Azure/azure-monitor-baseline-alerts/issues/455)]: Property name case consistency and remediation script rename
- Resolved [[#460](https://github.com/Azure/azure-monitor-baseline-alerts/issues/460)]: Portal accelerator bug
- Resolved [[#465](https://github.com/Azure/azure-monitor-baseline-alerts/issues/465)]: Fix policyDefinitionId format
- Resolved [[#475](https://github.com/Azure/azure-monitor-baseline-alerts/issues/475)]: [Bug]: Unable to cleanup AMBA deployment - Property "Id" cannot be found

### Documentation Updates

- Added examples of tag value and type in the [Override alert thresholds](../HowTo/Threshold-Override.md) documentation page

### Tools

- NONE

## 2024-12-10

### New Features

- Assignment of VM and Hybrid VM initiatives to Platform MG.
- Faster deployment thanks to both template and ARM engine improvements.

### Bug Fixes

- Resolved [[#400](https://github.com/Azure/azure-monitor-baseline-alerts/pull/400)]: Fix for log alerts policy remediation not working when the ALZMonitorDisableTagName parameter value contains dashes.

### Documentation Updates

- Improved navigation for the ALZ pattern content by restructuring the menu.
- Improved spelling and grammar for the ALZ pattern content.
- Updated the ***Introduction to deploying the AMBA-ALZ Pattern*** page with the new Platform Management Group assignment for both **VM initiative** and **Hybrid VM initiative**.
- Updated broken links.

### Tools

- **Automation:**
  - Created a workflow to assign issues to the relevant owner based on labels.
  - Added GitHub action to validate yml schemas.

## 2024-11-01

### New Features

- Introduced a new policy definition to audit/update Recovery Vault ASR Health Alerting to Azure Monitor alerts.
- **Script Consolidation**: The *Remove-AMBADeployments.ps1*, *Remove-AMBANotificationAssets.ps1*, *Start-AMBACleanup.ps1*, *Start-AMBAOldArpCleanup.ps1*, and *Start-AMBAPolicyInitiativesAndAssignmentsCleanup.ps1* scripts have been merged into a single script named [***Start-AMBA-ALZ-Maintenance.ps1***](https://github.com/Azure/azure-monitor-baseline-alerts/blob/main/patterns/alz/scripts/Start-AMBA-ALZ-Maintenance.ps1) [[#352](https://github.com/Azure/azure-monitor-baseline-alerts/pull/352): Consolidate maintenance scripts]. This enhancement allows the removal of alerts for deleted resources (orphaned alerts).

### Bug Fixes

- Resolved [[#323](https://github.com/Azure/azure-monitor-baseline-alerts/pull/323)]: Ensured the -WhatIf parameter is honored by all script commands and fixed the hybrid disconnected alert bug.
- Resolved [[#342](https://github.com/Azure/azure-monitor-baseline-alerts/pull/342)]: Fixed GitHub issue link and Management Subscription ID.
- Resolved [[#346](https://github.com/Azure/azure-monitor-baseline-alerts/pull/346)]: Updated useCommonSchema to useCommonAlertSchema in Deploy_ServiceHealth_ActionGroups and Deploy_Suppression_AlertProcessing_Rule Policy Definitions.
- Resolved [[#357](https://github.com/Azure/azure-monitor-baseline-alerts/pull/357)]: Fixed the ExpressRoute QoS remediation issue.
- Resolved [[#362](https://github.com/Azure/azure-monitor-baseline-alerts/pull/362)]: Standardized parameter usage for failingPeriods and evaluationPeriods.
- Resolved [[#381](https://github.com/Azure/azure-monitor-baseline-alerts/pull/381)]: Fixed Connectivity policy initiative, tag name case consistency, and updated tag override documentation.

### Documentation Updates

- Improved clarity on the 'Update to new releases' page.
- Added examples using the new consolidated maintenance script to the 'Update to new releases' page: [Updating to release 2024-09-02](../../HowTo/UpdateToNewReleases#2024-09-02), [Updating to release 2024-03-01](../../HowTo/UpdateToNewReleases#2024-03-01).
- Clarified identification of the pseudoRootManagementGroup as the parent of the Platform and Landing Zones management groups.
- Updated AMBA diagrams in the [Introduction to deploying the ALZ Pattern](../../HowTo/deploy/Introduction-to-deploying-the-ALZ-Pattern) section.
- Added remediation command for the ***Deploy Azure Monitor Baseline Alerts for Recovery Services*** policy initiative to the [Remediate Policies](../../HowTo/deploy/Remediate-Policies) list.

### Tools

- **Automation:**
  - Removed the previous workflow that automated the creation of ARM templates for Azure Policies/PolicySets due to a security issue.
  - Introduced a new workflow to ensure policy updates and verify the Bicep build has been run by the contributor.

## 2024-09-02

### New Features

- **AMBA Portal Accelerator**: Launched the Azure Monitor Baseline Alerts Accelerator in preview, enabling quick and confident alert deployment through the Azure portal UI. For detailed instructions, see [Deploy via the Azure Portal (Preview)](../../HowTo/deploy/Deploy-via-Azure-Portal-UI).
- **Modular Initiatives**: Deprecated the former Landing Zone Initiative in favor of a modular approach with distinct components. For more details, visit [Policy Initiatives](../../Getting-started/Policy-Initiatives).

  - Key Management
  - Load Balancing
  - Network Changes
  - Recovery Services
  - Storage
  - VM
  - Web

- **Threshold Override**: Allows adjustment of alert thresholds for specific resources using a tag. This feature is available for metrics and log alerts. Learn more: [Alert Threshold Override](../../HowTo/Threshold-Override).

- **Custom Tags to Disable Monitoring**: Specify a tag name and values to disable monitoring for certain resources.

- Added new alert rules for Azure Key Vault Managed HSM, included in Identity and Key Management initiatives.
- Added a new Daily Cap threshold alert for Log Analytics workspace, included in the Management initiative.
- Added a new Application Insight Throttling alert, included in the Web initiative.
- Added a new ActivityLog Alert for deleting Application Insight, included in the Web initiative.
- Enabled changing Application Gateway dynamic alert sensitivity.

- **Deprecated** the Landing Zone Initiative.

### Bug Fixes

- Resolved [[#280](https://github.com/Azure/azure-monitor-baseline-alerts/issues/280)]: Fixed AGW Compute Units Alert and AGW Unhealthy Host Count Alert non-compliance after remediation.
- Resolved [[#278](https://github.com/Azure/azure-monitor-baseline-alerts/issues/278)]: Fixed Deploy VNetG ExpressRoute CPU Utilization Alert remediation failure.
- Resolved [[#284](https://github.com/Azure/azure-monitor-baseline-alerts/issues/284)]: Fixed missing AMBA policy ALZ_ServiceHealth_ActionGroups during remediation.
- Resolved [[#253](https://github.com/Azure/azure-monitor-baseline-alerts/issues/253)]: Updated older version used in documentation.
- Resolved [[#261](https://github.com/Azure/azure-monitor-baseline-alerts/issues/261)]: Corrected display name VMLowOSDisk(Write/Read)LatencyAlert to VMHighOSDisk(Write/Read)LatencyAlert.
- Resolved [[#260](https://github.com/Azure/azure-monitor-baseline-alerts/issues/260)]: Added threshold parameter for ALZ alerts ALZ_WSFMemoryPercentage, ALZ_WSFCPUPercentage.
- Fixed casing in metadata and policies.
- Fixed default values for multiple parameters in VM and Hybrid initiatives.

### Documentation Updates

- Added new policies for ExpressRoute Ports to the Connectivity table. [Policy Initiatives](../../Getting-started/Policy-Initiatives).
- Updated documentation on unsupported/unrecommended Tenant Root Group deployment. [FAQ](../../Resources/FAQ).
- Provided new guidance for bringing your own Managed Identity. [Bring Your Own User Assigned Managed Identity](../../HowTo/Bring-Your-Own-User-Assigned-Managed-Identity).
- Updated Policy Initiatives documentation to include Policy Reference ID and display names. [Policy Initiatives](../../Getting-started/Policy-Initiatives).

### Tools

- **Automation**: Introduced a new workflow to automate ARM template creation for Azure Policies/PolicySets, triggered by pull request events.

## 2024-06-05

### New Features

- Added new PIDs for additional deployment methods. See [Disable telemetry tracking](../../HowTo/Telemetry) for more information.
- Introduced a new initiative to monitor Azure Arc-enabled Virtual Machines. [Alerting-HybridVM](https://github.com/Azure/azure-monitor-baseline-alerts/blob/main/patterns/alz/policySetDefinitions/Deploy-HybridVM-Alerts.json).

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
- Introduced a new policy for Storage Account Deletion. [Issue #76](https://github.com/Azure/azure-monitor-baseline-alerts/issues/76).
- Updated remediation script for better experience with the new action group for Service Health.

### Bug Fixes

- Resolved: unable to deploy via pipeline using ubuntu-latest. [Issue #64](https://github.com/Azure/azure-monitor-baseline-alerts/issues/64).
- Fixed PIP VIP alert existence condition to check only for standard SKU. [Issue #80](https://github.com/Azure/azure-monitor-baseline-alerts/issues/80).

### Documentation Updates

- Updated [Deploy with GitHub Actions](../../HowTo/deploy/Deploy-with-GitHub-Actions) addressing [Issue #102](https://github.com/Azure/azure-monitor-baseline-alerts/issues/102).
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
- FAQ Updates - [Frequently Asked Questions](../../Resources/FAQ).
