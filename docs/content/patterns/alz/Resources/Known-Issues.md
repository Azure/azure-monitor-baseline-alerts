---
title: Known Issues
geekdocCollapseSection: true
weight: 100
---

### In this page

> [VM Log Alert policies fail to remediate](#vm-log-alert-policies-fail-to-remediate) </br>
> [Failed to deploy because of role assignment issue](#failed-to-deploy-because-of-role-assignment-issue) </br>
> [Failed to deploy to a different location](#failed-to-deploy-to-a-different-location) </br>
> [Failed to deploy because of the limit of 800 deployments per management group has been reached](#failed-to-deploy-because-of-the-limit-of-800-deployments-per-management-group-has-been-reached) </br>
> [Failed to deploy because of 'location' property not specified](#failed-to-deploy-because-of-location-property-not-specified) </br>
> [Failed to deploy action group(s) and/or alert processing rule(s)](#failed-to-deploy-action-groups-andor-alert-processing-rules) </br>
> [Failed to edit action group(s)](#failed-to-edit-action-groups) </br>
> [Failed to deploy because of InvalidPolicyParameterUpdate](#failed-to-deploy-because-of-invalidpolicyparameterupdate) </br>
> [Failed to deploy because of PolicyDefinitionNotFound](#failed-to-deploy-because-of-policydefinitionnotfound) </br>

## VM Log Alert policies fail to remediate

> ### Error includes
>
> The error can be presented with one of the following messages:
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
> For VM Alerts, enable [VM Insights](../../Getting-started/Monitoring-and-Alerting#log-alerts). After VM Insights is enabled, run the remediation again.

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
> When a role or a role assignment is removed, some orphaned objects can still appear, preventing a successful deployment.
>
> ### Resolution
>
> 1. Navigate to **_Management Groups_**
> 2. Select the management group (corresponding to the value entered for the _enterpriseScaleCompanyPrefix_ during the deployment) where the AMBA-ALZ deployment was targeted
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
> When attempting to deploy to a different region, such as "uksouth", after a previous deployment in another region, an error may occur. This issue persists even after performing a cleanup (refer to [Clean-up AMBA-ALZ Deployment](../../HowTo/Cleaning-up-a-Deployment) for more details). The error arises because deployment entries from the previous operation still exist, causing a region conflict that prevents the new deployment.
>
> ### Resolution
>
> Situation 1: You are attempting to deploy to a different region than the one used in a previous deployment. It is not necessary to deploy to the same scope in a different region, as the definitions and assignments are scoped to a management group and are not region-specific. No further action is required.

> Situation 2: You have cleaned up a previous deployment and now wish to deploy to a different region. Follow these steps to resolve the issue:

> 1. Navigate to **_Management Groups_**
> 2. Select the management group (corresponding to the value entered for the _enterpriseScaleCompanyPrefix_ during the deployment) where the AMBA deployment was targeted
> 3. Click **_Deployment_**
> 4. Select all the deployment instances related to AMBA and click **_Delete_**.
>
> {{< hint type=Note >}} To recognize the deployment names belonging to AMBA, select those whose names start with:
>
> 1. amba-
> 2. pid-
> 3. alzArm
> 4. ambaPreparingToLaunch
>
>If you have only deployed AMBA-ALZ once, you have 14 deployment instances.
>
>{{< /hint >}}

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
> To resolve this issue, follow these steps:
>
> 1. Navigate to **_Management Groups_**
> 2. Select the management group (corresponding to the value entered for the _enterpriseScaleCompanyPrefix_ during the deployment) where AMBA-ALZ deployment was targeted
> 3. Click **_Deployment_**
> 4. Select all the deployments that could be deleted (example: instances of previous deployments related to AMBA) and click **_Delete_**
> 5. Run the deployment
>
> {{< hint type=Note >}} To recognize the deployment names belonging to AMBA-ALZ, select those whose names start with:
>
> 1. amba-
> 2. pid-
> 3. alzArm
> 4. ambaPreparingToLaunch
>
>If you have only deployed AMBA-ALZ once, you have 14 deployment instances.
>
>{{< /hint >}}

## Failed to deploy because of 'location' property not specified

> ### Error includes
>
> The error can be presented with one of the following messages:
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
> The new [Bring Your Own User Assigned Managed Identity (BYO UAMI)](../../HowTo/Bring-your-own-Managed-Identity) feature allows you to either use an existing User Assigned Managed Identity (UAMI) or create a new one within the management subscription. This process automatically assigns the Monitoring Reader role to the UAMI at the parent pseudo root Management Group. If a new UAMI is created, ensure the management subscription ID is correctly specified.
>
> ### Resolution
>
> Ensure that the management subscription ID is accurately specified in the parameter file:
>
> ![New UAMI deployed by the template](../../media/alz-UAMI-Param-Example-2.png)

## Failed to deploy action group(s) and/or alert processing rule(s)

> The following remediation tasks fail when the subscription name, used as part of the resource name, contains invalid characters:
>
> - Deployment of AMBA Notification Assets
> - Deployment of AMBA Notification Suppression Assets
>
> ### Error includes
>
> ```TEXT
> At least one resource name segment is invalid according to the Resource Provider specification. (Code: InvalidResourceNameFormat)
> ```
>
> ### Cause
>
> When action groups and alert processing rules are deployed, the subscription name is included in their display names. If the subscription name contains invalid characters, the deployment will fail, resulting in the misleading error mentioned above.
>
> ### Resolution
>
> Rename the subscription to exclude invalid characters. Refer to the [Naming rules and restrictions for Azure resources](https://learn.microsoft.com/en-us/azure/azure-resource-manager/management/resource-name-rules) for a list of supported characters. For instance, alert suppression rules only permit alphanumeric characters, underscores, and hyphens. Specifically, alphanumeric characters include:
>
> - **_a_** through **_z_** (lowercase letters)
> - **_A_** through **_Z_** (uppercase letters)
> - **_0_** through **_9_** (numbers)
>
> After renaming the subscription correctly, rerun the remediation.

## Failed to edit action group(s)

> Editing a previously deployed action group is returning a misleading error in the Azure portal.
>
> ![Api-version required error](../../media/api-version_required.png)
>
> ### Error includes
>
> The error includes the following message:
>
> ```TEXT
> The api-version query parameter (?api-version=) is required for all requests. (Code: MissingApiVersionParameter)
> ```
>
> ### Cause
>
> Action groups are deployed with names that include the subscription name. If the subscription name contains invalid characters, editing the action group will fail.
>
> ### Resolution
>
> Rename the subscription to exclude invalid characters. Refer to the [Naming rules and restrictions for Azure resources](https://learn.microsoft.com/en-us/azure/azure-resource-manager/management/resource-name-rules) for a list of supported characters. For instance, alert suppression rules only permit alphanumeric characters, underscores, and hyphens. Specifically, alphanumeric characters include:
>
> - **_a_** through **_z_** (lowercase letters)
> - **_A_** through **_Z_** (uppercase letters)
> - **_0_** through **_9_** (numbers)
>
> Once the subscription has been renamed to exclude invalid characters, delete the existing action groups (those with names starting with **_ag-AMBA-_** or **_ag-AMBA-SH-_**) and rerun the remediation process.

## Failed to deploy because of InvalidPolicyParameterUpdate

> ### Error includes
>
> The error can be presented with one of the following messages:
> {{< hint type=Important >}}
> This message can be presented more than once during a deployment and with different parameter names.
> {{< /hint >}}
>
> ```JSON
> {
>    "code": "InvalidPolicyParameterUpdate",
>    "message": "The existing policy parameter(s) 'networkInterfacesToInclude' were not found in the policy being updated. The parameter names can not be changed."
> }
> ```
>
> ```TEXT
> At least one resource deployment operation failed. Please list deployment operations for details. Please see https://aka.ms/arm-deployment-operations for usage details. (Code: DeploymentFailed)
> ```
>
>
> ### Cause
>
> The last deployed version was using a parameter that is no longer available in the new version being deployed. This situation is the consequence of a necessary breaking change introduced between releases to allow for new feature implementation. To avoid this error, it is necessary to follow the documentation available under the [Update to new releases](../../HowTo/UpdateToNewReleases/#) page with specific reference to the new release being used.
>
> ### Resolution
>
> 1. Remove previous installation of AMBA-ALZ pattern (the one we are talking about) using the maintenance script and the procedure documented at [Clean-up AMBA-ALZ Deployment](../../HowTo/Cleaning-up-a-Deployment)
> 2. Align your local copy of param file
> 3. Deploy the new version using either the main branch or the latest available release. The main branch might be a little ahead (might contain some enhancements or bugfix not included in the latest availble release and that will be added to a new one) compared to the latest release.
>

## Failed to deploy because of PolicyDefinitionNotFound

> ### Error includes
>
> The error can be presented with similar message reporting a different policy and/or policy set definition in the text.
>
> ```TEXT
> Status Message: The policy set definition 'Alerting-Web' request is invalid. The following policy definition could not be found: '/providers/Microsoft.Management/managementGroups/MG NAME/providers/Microsoft.Authorization/policyDefinitions/Deploy_activitylog_LAWorkspace_Delete'. (Code:PolicyDefinitionNotFound)
> ```
>
>
> ### Cause
>
> This is a random transitient error caused by the time it take for the policy to be seen as deployed.
>
> ### Resolution
>
> Run the deployment one more time.
>
