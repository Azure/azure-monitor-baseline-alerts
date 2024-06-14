---
title: What´s new
geekdocCollapseSection: true
weight: 10
---

To update your current deployment with the content from the latest release, please refer to the [Update to new release](Update-to-new-Release.md) page.

## Version 3.0 (2024-06-13)

### New features
Complete integration with AMBA sourced alerts! Previously the source of the alerts were based on Azure Engineer based criteria versus what is now vetted via the Product Group. This includes those for the Host Pool, Virtual Machines, and Storage. (including Azure NetApp Files)

### Breaking Change(s)
No more automation account for Host Pool Capacity! - This feature was regretably reversed feature due to the complexity and desire to remove additional service requirements.  It is intended to be recreated at a later time and possibly in a few months for Azure Global cloud customers.

### Bug fixes
- Fixed issue where VM performance related alerts like that for Disk Free Space would fire multiple times.

- Fixed issue where Alert for 'Session Host Healthcheck Failure' which was not providing the Host RG and Name. (Updated Query)

### Future updates planned
The next update is anticipated this summer and will incorporate things like an automation account and runbook to place the VMs in drain mode when one of the performance based metrics fire.

Additionally, some sort of method to customize the alert emails is intended but may be further out towards the fall.


