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

## Failed to deploy to a different location

### Error includes

*Error: Code=InvalidDeploymentLocation; Message=Invalid deployment location 'westeurope'. The deployment 'ALZARM' already exists in location 'uksouth'.*

### Cause

A deployment has been performed using one region (i.e. 'uksouth') in the command line. A subsequent cleanup is performed to allow a second deploy against a different region (i.e. 'westeurope'). Deployment entries still exists from the previous operation, so a region conflict is detected blocking you to run another deployment using a different region.

### Resolution

To resolve this issue, follow the steps below:

1. Navigate to ***Management Groups***
2. Select the management group (corresponding to the value entered for the *enterpriseScaleCompanyPrefix* during the deployment) were AMBA deployment was targeted to
3. Click ***Deployment***
4. Select all the deployment instances related to AMBA and click ***Delete***.

{{< hint type=Important >}}
To recognize the deployment names belonging to AMBA, select those whose names start with:

1. amba-
2. pid-
3. alzArm
4. preparingToLaunch

If you deployed AMBA just one time, you have 14 deployment instances

{{< /hint >}}
