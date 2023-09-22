---
title: Known Issues
geekdocCollapseSection: true
weight: 100
---

## VM Log Alert policies fail to remediate

### Error includes

*failed to resolve table or column expression named*

### Cause

The underlying data is not present in the Log Analytics table.

### Resolution

For VM Alerts please enable [VM Insights](Monitoring-and-Alerting#log-alerts).

## Failed to deploy because of role assignemnt issue

Deployment of AMBA fails when there are orphaned role assignements.

### Error includes

*"error": { </br>
&emsp;"code": "RoleAssignmentUpdateNotPermitted", </br>
&emsp;"message": "Tenant ID, application ID, principal ID, and scope are not allowed to be updated." </br>
&emsp;}*

### Cause

When a role or a role assignement is removed, some orphaned object can still appear, preventing a successful deployment.

### Resolution

1. Navigate to ***Management Groups***
2. Select the management group (corresponding to the value entered for the *enterpriseScaleCompanyPrefix* during the deployment) were AMBA deployment was targeted to
3. Select ***Access control (IAM)***
4. Under the ***Contributor*** role, select all records named ***Identity not found*** entry and click ***Remove***
