---
title: Known Issues
geekdocCollapseSection: true
weight: 100
---

## VM Log Alert policies fail to remediate

> ### Error includes
>
> The error can be presented with one of the two following messages:
>
> ```TEXT
> failed to resolve table or column expression named
> ```
>
> ```json
> {
>    "code": "BadRequest",
>    "message": {
>        "error": {
>            "code": "DraftClientException",
>            "message": "The request had some invalid properties Activity D: 3332f9c0-b4d4-464b-8ec4-44a670ba745b."
>        }
>    }
>}
> ```
>
> ### Cause
>
> The underlying data is not present in the Log Analytics table or there's no virtual machine associated to any VM Insights data collection rule.
>
> ### Resolution
>
> For VM Alerts, enable [VM Insights](../Monitoring-and-Alerting#log-alerts). After VM Insights is enabled, run the remediation again.

## Failed to deploy because of role assignment issue

> Deployment of AMBA-ALZ fails when there are orphaned role assignments.
>
> ### Error includes
>
> ```JSON
> {
>    "code": "RoleAssignmentUpdateNotPermitted",
>    "message": "Tenant ID, application ID, principal ID, and scope are not allowed to be updated."
> }
> ```
>
> ### Cause
>
> When a role or a role assignment is removed, some orphaned object can still appear, preventing a successful deployment.
>
> ### Resolution
>
> 1. Navigate to **_Management Groups_**
> 2. Select the management group (corresponding to the value entered for the _enterpriseScaleCompanyPrefix_ during the deployment) were AMBA deployment was targeted to
> 3. Select **_Access control (IAM)_**
> 4. Under the **_Contributor_** role, select all records named **_Identity not found_** entry and click **_Remove_**
> 5. Run the deployment

## Failed to deploy to a different location

> ### Error includes
>
> ```TEXT
> Error: Code=InvalidDeploymentLocation; Message=Invalid deployment location 'westeurope'. The deployment 'ALZARM' already exists in location 'uksouth'.
> ```
>
> ### Cause
>
> A deployment has been performed using one region, for example "uksouth", and when you try to deploy again to the same scope but to a different region you will receive an error. This happens even when a cleanup has been performed (see [Cleaning up a Deployment](../Cleaning-up-a-Deployment) for more details). This is because deployment entries still exist from the previous operation, so a region conflict is detected blocking you to run another deployment using a different region.
>
> ### Resolution
>
> Situation 1: You are trying to deploy to a region different from the one used in previous deployment. Deploying to the same scope in a different region is not necessary. The definitions and assignments are scoped to a management group and are not region-specific. No action is required.
>
> Situation 2: You cleaned up a previous implementation and want to deploy again to a different region. To resolve this issue, follow the steps below:
>
> 1. Navigate to **_Management Groups_**
> 2. Select the management group (corresponding to the value entered for the _enterpriseScaleCompanyPrefix_ during the deployment) were AMBA deployment was targeted to
> 3. Click **_Deployment_**
> 4. Select all the deployment instances related to AMBA and click **_Delete_**.
>
> {{< hint type=Note >}} To recognize the deployment names belonging to AMBA, select those deployments whose names start with:

1. amba-
2. pid-
3. alzArm
4. ambaPreparingToLaunch

If you deployed AMBA just one time, you have 14 deployment instances

{{< /hint >}}

## Failed to deploy because of the limit of 800 deployments per management group has been reached

> ### Error includes
>
> ```TEXT
> Error: Code=MultipleErrorsOccurred; Message=Multiple errors occurred: Conflict,Conflict,Conflict,Conflict,Conflict,Conflict.
> ```
>
> ### Cause
>
> The limit of 800 deployment for the given management group scope has been reached. More information can be found at [Management group limits](https://learn.microsoft.com/en-us/azure/azure-resource-manager/management/azure-subscription-service-limits#management-group-limits)
>
> ### Resolution
>
> To resolve this issue, follow the steps below:
>
> 1. Navigate to **_Management Groups_**
> 2. Select the management group (corresponding to the value entered for the _enterpriseScaleCompanyPrefix_ during the deployment) were AMBA deployment was targeted to
> 3. Click **_Deployment_**
> 4. Select all the deployments that could be deleted (example: instances of previous deployment related to AMBA) and click **_Delete_**
> 5. Run the deployment
>
> {{< hint type=Note >}} To recognize the deployment names belonging to AMBA, select those deployments whose names start with:

1. amba-
2. pid-
3. alzArm
4. ambaPreparingToLaunch

If you deployed AMBA-ALZ just one time, you have 14 deployment instances

{{< /hint >}}

## Failed to deploy because of 'location' property not specified

> ### Error includes
>
> The error can be presented with one of the two following messages:
>
> ```JSON
> {
>    "code": "InvalidDeployment",
>    "message": "The 'location' property must be specified for 'amba-id-amba-prod-001'. Please see https://aka.ms/arm-deployment-subscription for usage details."
> }
> ```
>
> ```TEXT
> InvalidDeployment - Long running operation failed with status 'Failed'. Additional Info:'The 'location' property must be specified for 'amba-id-amba-prod-001'. Please see https://aka.ms/arm-deployment-subscription for usage details.'
> ```
>
> ### Cause
>
> The new [Bring Your Own User Assigned Managed Identity (BYO UAMI)](../Bring-your-own-Managed-Identity) allows you to either use an existing User Assigned Managed Identity (UAMI) or to create a new one in the management subscription automatically assigning the Monitoring reader role to it at the parent pseudo root Management Group. If you opted for creating a new UAMI, the management subscription id is needed.
>
> ### Resolution
>
> Set the parameter for the management subscription id correctly in the parameter file:
>
> ![New UAMI deployed by the template](../media/alz-UAMI-Param-Example-2.png)

## Failed to deploy action group(s) and/or alert processing rule(s)

> The following remediation tasks are failing for one or more resource when the subscription name is used as part of the resource name and contains invalid characters:
>
> - Deploy AMBA Notification Assets
> - Deploy AMBA Notification Suppression Asset
>
> ### Error includes
>
> ```TEXT
> At least one resource name segment is invalid according to the Resource Provider specification. (Code: InvalidResourceNameFormat)
> ```
>
> ### Cause
>
> When action group(s) and alert processing rule(s) are deployed, they get the subscription name as part of their display name. If the subscription in which they are about to be deployed contains invalid characters in the name, this will make the remediation task failing with a the misleading error reported above.
>
> ### Resolution
>
> Rename the subscription to avoid invalid characters. A list of supported characters for any resource can be found on the [Naming rules and restrictions for Azure resources](https://learn.microsoft.com/en-us/azure/azure-resource-manager/management/resource-name-rules) public documentation page. As an example that you can find in the referenced documentation, the alert suppression rules only allow alphanumerics, underscores, and hyphens as valid characters and at the beginning of the same page, alphanumeric is referring to:
>
> - **_a_** through **_z_** (lowercase letters)
> - **_A_** through **_Z_** (uppercase letters)
> - **_0_** through **_9_** (numbers)
>
> After the subscription is renamed correctly, run the remediation

## Failed to edit action group(s)

> Editing a previously deployed action group is returning a misleading error in the Azure portal page.
>
> ![Api-version required error](../media/api-version_required.png)
>
> ### Error includes
>
> The error message appearing in the Azure portal includes the following message:
>
> ```TEXT
> The api-version query parameter (?api-version=) is required for all requests. (Code: MissingApiVersionParameter)
> ```
>
> ### Cause
>
> Action group are deployed using a name which contain the subscription name. If the subscription name contains characters which are not considered valid for the resource, editing the action group will fail.
>
> ### Resolution
>
> Rename the subscription to avoid invalid characters. A list of supported characters for any resource can be found on the [Naming rules and restrictions for Azure resources](https://learn.microsoft.com/en-us/azure/azure-resource-manager/management/resource-name-rules) public documentation page. As an example that you can find in the referenced documentation, the alert suppression rules only allow alphanumerics, underscores, and hyphens as valid characters and at the beginning of the same page, alphanumeric is referring to:
>
> - **_a_** through **_z_** (lowercase letters)
> - **_A_** through **_Z_** (uppercase letters)
> - **_0_** through **_9_** (numbers)
>
> After the subscription is renamed correctly, remove the existing action groups (those whose name starts with either **_ag-AMBA-_** or **_ag-AMBA-SH-_**) and run the remediation.
