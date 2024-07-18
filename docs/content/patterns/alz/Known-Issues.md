---
title: Known Issues
geekdocCollapseSection: true
weight: 100
---

>## VM Log Alert policies fail to remediate
>
>### Error includes
>
>*failed to resolve table or column expression named*
>
>### Cause
>
>The underlying data is not present in the Log Analytics table.
>
>### Resolution
>
>For VM Alerts, enable [VM Insights](../Monitoring-and-Alerting#log-alerts). After VM Insights is enabled, run the remediation again.

>## Failed to deploy because of role assignment issue
>
>Deployment of AMBA-ALZ fails when there are orphaned role assignments.
>
>### Error includes
>
>*"error": { </br>
>&emsp;"code": "RoleAssignmentUpdateNotPermitted", </br>
>&emsp;"message": "Tenant ID, application ID, principal ID, and scope are not allowed to be updated." </br>
>&emsp;}*
>
>### Cause
>
>When a role or a role assignment is removed, some orphaned object can still appear, preventing a successful deployment.
>
>### Resolution
>
>1. Navigate to ***Management Groups***
>2. Select the management group (corresponding to the value entered for the *enterpriseScaleCompanyPrefix* during the deployment) were AMBA deployment was targeted to
>3. Select ***Access control (IAM)***
>4. Under the ***Contributor*** role, select all records named ***Identity not found*** entry and click ***Remove***
>5. Run the deployment

>## Failed to deploy to a different location
>
>### Error includes
>
>*Error: Code=InvalidDeploymentLocation; Message=Invalid deployment location 'westeurope'. The deployment 'ALZARM' already exists in location 'uksouth'.*
>
>### Cause
>
>A deployment has been performed using one region, for example "uksouth", and when you try to deploy again to the same scope but to a different region you will receive an error. This happens even when a cleanup has been performed (see [Cleaning up a Deployment](../Cleaning-up-a-Deployment) for more details). This is because deployment entries still exist from the previous operation, so a region conflict is detected blocking you to run another deployment using a different region.
>
>### Resolution
>Situation 1: You are trying to deploy to a region different from the one used in previous deployment. Deploying to the same scope in a different region is not necessary. The definitions and assignments are scoped to a management group and are not region-specific. No action is required.
>
>Situation 2: You cleaned up a previous implementation and want to deploy again to a different region. To resolve this issue, follow the steps below:
>
>1. Navigate to ***Management Groups***
>2. Select the management group (corresponding to the value entered for the *enterpriseScaleCompanyPrefix* during the deployment) were AMBA deployment was targeted to
>3. Click ***Deployment***
>4. Select all the deployment instances related to AMBA and click ***Delete***.
>
>{{< hint type=Note >}}
To recognize the deployment names belonging to AMBA, select those deployments whose names start with:

1. amba-
2. pid-
3. alzArm
4. ambaPreparingToLaunch

If you deployed AMBA just one time, you have 14 deployment instances

>{{< /hint >}}

>## Failed to deploy because of the limit of 800 deployments per management group has been reached
>
>### Error includes
>
>*Error: Code=MultipleErrorsOccurred; Message=Multiple errors occurred: Conflict,Conflict,Conflict,Conflict,Conflict,Conflict.*
>
>### Cause
>
>The limit of 800 deployment for the given management group scope has been reached. More information can be found at [Management group limits](https://learn.microsoft.com/en-us/azure/azure-resource-manager/management/azure-subscription-service-limits#management-group-limits)
>
>### Resolution
>To resolve this issue, follow the steps below:
>
>1. Navigate to ***Management Groups***
>2. Select the management group (corresponding to the value entered for the *enterpriseScaleCompanyPrefix* during the deployment) were AMBA deployment was targeted to
>3. Click ***Deployment***
>4. Select all the deployments that could be deleted (example: instances of previous deployment related to AMBA) and click ***Delete***
>5. Run the deployment
>
>{{< hint type=Note >}}
To recognize the deployment names belonging to AMBA, select those deployments whose names start with:

1. amba-
2. pid-
3. alzArm
4. ambaPreparingToLaunch

If you deployed AMBA-ALZ just one time, you have 14 deployment instances

>{{< /hint >}}
>
>## Failed to deploy action group(s) and/or alert processing rule(s)
>
>The following remediation tasks are failing for one or more resource when the subscription name is used as part of the resource name and contains invalid characters:
>
>- Deploy AMBA Notification Assets
>- Deploy AMBA Notification Suppression Asset
>
>### Error includes
>
>*At least one resource name segment is invalid according to the Resource Provider specification. (Code: InvalidResourceNameFormat)*
>
>### Cause
>
>When action group(s) and alert processing rule(s) are deployed, they get the subscription name as part of their display name. If the subscription in which they are about to be deployed contains invalid characters in the name, this will make the remediation task failing with a the misleading error reported above.

>### Resolution
>
>Rename the subscription to avoid invalid characters. A list of supported characters for any resource can be found on the [Naming rules and restrictions for Azure resources](https://learn.microsoft.com/en-us/azure/azure-resource-manager/management/resource-name-rules) public documentation page. As an example that you can find in the referenced documentation, the alert suppression rules only allow alphanumerics, underscores, and hyphens as valid characters and at the beginning of the same page, alphanumeric is referring to:
>
>- a through z (lowercase letters)
>- A through Z (uppercase letters)
>- 0 through 9 (numbers)
>
>After the subscription is renamed correctly, run the remediation

>## Failed to edit action group(s)
>
>Editing a previously deployed action group is returning a misleading error in the Azure portal page.
>
>![Api-version required error](../media/api-version%20required.png)
>
>### Error includes
>
>The error message appearing in the Azure portal includes the following message: *The api-version query parameter (?api-version=) is required for all requests. (Code: MissingApiVersionParameter)*
>
>### Cause
>
>Action group are deployed using a name which contain the subscription name. If the subscription name contains characters which are not considered valid for the resource, editing the action group will fail.
>
>### Resolution
>
>Rename the subscription to avoid invalid characters. A list of supported characters for any resource can be found on the [Naming rules and restrictions for Azure resources](https://learn.microsoft.com/en-us/azure/azure-resource-manager/management/resource-name-rules) public documentation page. As an example that you can find in the referenced documentation, the alert suppression rules only allow alphanumerics, underscores, and hyphens as valid characters and at the beginning of the same page, alphanumeric is referring to:
>
>- a through z (lowercase letters)
>- A through Z (uppercase letters)
>- 0 through 9 (numbers)
>
>After the subscription is renamed correctly, remove the existing action groups (those whose name starts with either ***ag-AMBA-*** or ***ag-AMBA-SH-***) and run the remediation.
