---
title: Known Issues
geekdocCollapseSection: true
weight: 100
---

## VM Log Alert policies fail to remediate

#### Error includes

*failed to resolve table or column expression named*

#### Cause
The underlying data is not present in the Log Analytics table. For VM Alerts please enable [VM Insights](Monitoring-and-Alerting#log-alerts)

## Tagging on resources from preview version is not updated

Alerts created by the preview version will not get the tag updated. This is affecting the cleanup operation, preventing the alerts to be correctly removed.

#### Workaround

Should you need to cleanup your environment, you need to:

- run the cleanup as documented at [Cleaning up an AMBA Deployment](../alz/Cleaning-up-a-Deployment.md)
- run the cleanup for the old deployment as documented at [Cleaning up an ALZMonitor Deployment](../alz/Cleaning-Up-Preview-Version-Deployment.md)

## Untagged resources from preview version remain untagged

Some alerts created by the preview version were missing the tagging. After an update, since remediation will use the same policy definitions, resources that were not tagged remains untagged. This is affecting the cleanup operation, preventing the alerts to be correctly removed.

#### Workaround

Proceed with manual tagging for the following resources by adding the tag with name *_deployed_by_amba* with value of *True*:

- 

## Failed to deploy because of role assignemnt issue

Deployment of AMBA fails when there are orphaned role assignements.

#### Error includes

*"error": { </br>
&emsp;"code": "RoleAssignmentUpdateNotPermitted", </br>
&emsp;"message": "Tenant ID, application ID, principal ID, and scope are not allowed to be updated." </br>
&emsp;}*

#### Cause

When a a previous installation is removed using the cleanup script, the previous role assignments become orphaned.

#### Resolution

1. Navigate to ***Management Groups***
2. Select the management group (corresponding to the value entered for the *enterpriseScaleCompanyPrefix* during the deployment) were AMBA deployment was targeted to
3. Select ***Access control (IAM)***
4. Under the ***Contributor*** role, select all records named ***Identity not found*** entry and click ***Remove***
