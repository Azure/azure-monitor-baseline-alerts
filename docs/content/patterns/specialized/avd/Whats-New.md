---
title: What´s new
geekdocCollapseSection: true
weight: 10
---

For information on what's new please refer to the [Releases](https://github.com/Azure/azure-monitor-baseline-alerts/releases) page.

To update your current deployment with the content from the latest release, please refer to the [Update to new release](Update-to-new-Release.md) page.

## 2024-12-18
Bug fixes [(See Known Issues Section)](Known-Issues.md)
Added option to select alternate subscription for Log Analytics and Storage as well as an initial prerequisites note on the first screen.

## 2024-12-10
### After 3/21/2024 Host Pool Capacity Alert Rule would not fire
An issue was discovered where the Automation Account Identity was not being assigned the Virtual Desktop Reader role on the Resource Group hosting all the AVD Resources. Thus, the output of the script was null which yielded no alerts, regardless of what the host pool capacity currently was. There was a condition on the role assignment that was adjusted so that it will be added at deployment.

Fix without Redeploying:
Simply assigning the identity tied to the Automation Account the Virtual Desktop Reader role on the Resource Group that houses the Host Pools.

## 2024-11-20
### Deployment Names over 64 characters
An issue was discovered in which the deployment for some alerts would fail if the deployment name was over 64 characters. This was due to the Storage Account and/or ANF Volume names being too long and appended to the deployment name. Those names are now truncated if over 20 characters.

## 2024-01-25
### New features
Initial relocation from the Azure AVD Accelerator Brownfield with AVD specific Alerts on a per Host Pool basis.
- Session Host monitoring both on performance, AVD agent health, storage, and fslogix profiles

### Bug fixes
#### ISSUE #221
(Fixed on 6/28/2024)

Storage calculation script in the runbook which was yielding a much higher remaining value than truly existed. Values were in the 99.xx% range vs actual for remaining meaning the alert may never trigger when remaining storage is truly low.

Runbook: AvdStorageLogData
Script: Get-StorAcctInfo.ps1 line 46

Was --- $RemainingPercent = 100 - ($shareUsageInGB / $shareQuota)
New --- $RemainingPercent = 100 - ($shareUsageInGB / $shareQuota * 100)
