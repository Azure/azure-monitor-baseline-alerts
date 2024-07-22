---
title: Known Issues
geekdocCollapseSection: true
weight: 100
---

## VM Log Alert policies fail to remediate

### Error includes

The error can be presented with one of the two following messages:

- *failed to resolve table or column expression named*

- *{"code": "BadRequest", "message": "{\r\n "error": {\r\n "code": "DraftClientException",\r\n "message": "The request had some invalid properties Activity D: 3332f9c0-b4d4-464b-8ec4-44a670ba745b."\r\n }\r\n}"}*

### Cause

The underlying data isn't present in the Log Analytics table or there's no virtual machine associated to any VM Insights data collection rule.

### Resolution

For VM Alerts, enable [VM Insights](../Monitoring-and-Alerting#log-alerts).

## Failed to deploy because of role assignment issue

Deployment of AMBA fails when there are orphaned role assignments.

### Error includes

*"error": { </br>
&emsp;"code": "RoleAssignmentUpdateNotPermitted", </br>
&emsp;"message": "Tenant ID, application ID, principal ID, and scope aren't allowed to be updated." </br>
&emsp;}*

### Cause

When a role or a role assignment is removed, some orphaned object can still appear, preventing a successful deployment.

### Resolution

1. Navigate to ***Management Groups***
2. Select the management group (corresponding to the value entered for the *enterpriseScaleCompanyPrefix* during the deployment) were AMBA deployment was targeted to
3. Select ***Access control (IAM)***
4. Under the ***Contributor*** role, select all records named ***Identity not found*** entry and click ***Remove***

## Failed to deploy to a different location

### Error includes

*Error: Code=InvalidDeploymentLocation; Message=Invalid deployment location 'westeurope'. The deployment 'ALZARM' already exists in location 'uksouth'.*

### Cause

A deployment has been performed using one region, for example "uksouth", and when you try to deploy again to the same scope but to a different region you'll receive an error. This happens even when a cleanup has been performed (see [Cleaning up a Deployment](../Cleaning-up-a-Deployment) for more details). This is because deployment entries still exist from the previous operation, so a region conflict is detected blocking you to run another deployment using a different region.

### Resolution
Situation 1: You're trying to deploy to a region different from the one used in previous deployment. Deploying to the same scope in a different region isn't necessary. The definitions and assignments are scoped to a management group and aren't region-specific. No action is required.

Situation 2: You cleaned up a previous implementation and want to deploy again to a different region. To resolve this issue, follow the following steps:

1. Navigate to ***Management Groups***
2. Select the management group (corresponding to the value entered for the *enterpriseScaleCompanyPrefix* during the deployment) were AMBA deployment was targeted to
3. Click ***Deployment***
4. Select all the deployment instances related to AMBA and click ***Delete***.

{{< hint type=Note >}}
To recognize the deployment names belonging to AMBA, select those deployments whose names start with:

1. amba-
2. pid-
3. alzArm
4. ambaPreparingToLaunch

If you deployed AMBA just one time, you have 14 deployment instances

{{< /hint >}}

## Failed to deploy because of the limit of 800 deployments per management group has been reached

### Error includes

*Error: Code=MultipleErrorsOccurred; Message=Multiple errors occurred: Conflict,Conflict,Conflict,Conflict,Conflict,Conflict.*

### Cause

The limit of 800 deployment for the given management group scope has been reached. More information can be found at [Management group limits](https://learn.microsoft.com/en-us/azure/azure-resource-manager/management/azure-subscription-service-limits#management-group-limits)

### Resolution
To resolve this issue, follow the following steps:

1. Navigate to ***Management Groups***
2. Select the management group (corresponding to the value entered for the *enterpriseScaleCompanyPrefix* during the deployment) were AMBA deployment was targeted to
3. Click ***Deployment***
4. Select all the deployments that could be deleted (example: instances of previous deployment related to AMBA) and click ***Delete***.

{{< hint type=Note >}}
To recognize the deployment names belonging to AMBA, select those deployments whose names start with:

1. amba-
2. pid-
3. alzArm
4. ambaPreparingToLaunch

If you deployed AMBA just one time, you have 14 deployment instances

{{< /hint >}}

## Failed to deploy because of 'location' property not specified

### Error includes

The error can be presented with one of the two following messages:

- *{"code": "InvalidDeployment", "message": "The 'location' property must be specified for 'amba-id-amba-prod-001'. Please see https://aka.ms/arm-deployment-subscription for usage details."}*

- *InvalidDeployment - Long running operation failed with status 'Failed'. Additional Info:'The 'location' property must be specified for 'amba-id-amba-prod-001'. Please see https://aka.ms/arm-deployment-subscription for usage details.'*

### Cause

The new [Bring Your Own User Assigned Managed Identity (BYO UAMI)](../Bring-your-own-Managed-Identity) allows you to either use an existing User Assigned Managed Identity (UAMI) or to create a new one in the management subscription automatically assigning the Monitoring reader role to it at the parent pseudo root Management Group. If you opted for creating a new UAMI, the management subscription id is needed.

### Resolution

Set the parameter for the management subscription id correctly in the parameter file:

![New UAMI deployed by the template](../media/alz-UAMI-Param-Example-2.png)
