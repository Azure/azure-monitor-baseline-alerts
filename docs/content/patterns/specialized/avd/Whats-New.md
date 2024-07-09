---
title: What´s new
geekdocCollapseSection: true
weight: 10
---

For information on what's new please refer to the [Releases](https://github.com/Azure/azure-monitor-baseline-alerts/releases) page.

To update your current deployment with the content from the latest release, please refer to the [Update to new release](Update-to-new-Release.md) page.

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
