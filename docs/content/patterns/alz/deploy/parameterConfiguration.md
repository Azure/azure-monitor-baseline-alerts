
## 1. Parameter configuration

To start, you can either download a copy of the parameter file or clone/fork the repository.

- [alzArm.param.json](https://github.com/azure/azure-monitor-baseline-alerts/blob/main/patterns/alz/alzArm.param.json)

The following changes apply to all scenarios, whether you are aligned or unaligned with ALZ or have a single management group.

- Change the value of _```enterpriseScaleCompanyPrefix```_ to the management group where you wish to deploy the policies and the initiatives. This is usually the so called "pseudo root management group", for example, in [ALZ terminology](https://learn.microsoft.com/azure/cloud-adoption-framework/ready/landing-zone/design-area/resource-org-management-groups), this would be the so called "Intermediate Root Management Group" (directly beneath the "Tenant Root Group").
- Change the value of _```ALZMonitorResourceGroupName```_ to the name of the resource group where the activity logs, resource health alerts, actions groups and alert processing rules will be deployed in.
- Change the value of _```ALZMonitorResourceGroupTags```_ to specify the tags to be added to said resource group.
- Change the value of _```ALZMonitorResourceGroupLocation```_ to specify the location for said resource group.
- Change the value of _```ALZMonitorActionGroupEmail```_ (specific to the Service Health initiative) to the email address(es) where notifications of the alerts are sent to.

  {{< hint type=note >}}
  For multiple email addresses, make sure they are entered a single string with values separated by comma. Example:

    "ALZMonitorActionGroupEmail": {
      "value": "action1@mail.com , action2@mail.com , action3@mail.com"
      },
  {{< /hint >}}

- If you would like to disable initiative assignments, you can change the value on one or more of the following parameters; _```enableAMBAConnectivity```_, _```enableAMBAIdentity```_, _```enableAMBALandingZone```_, _```enableAMBAManagement```_, _```enableAMBAServiceHealth```_ to ***"No"***.

### If you are aligned to ALZ

- Change the value of _```platformManagementGroup```_ to the management group id for Platform.
- Change the value of _```IdentityManagementGroup```_ to the management group id for Identity.
- Change the value of _```managementManagementGroup```_ to the management group id for Management.
- Change the value of _```connectivityManagementGroup```_ to the management group id for Connectivity.
- Change the value of _```LandingZoneManagementGroup```_ to the management group id for Landing Zones.

### If you are unaligned to ALZ

- Change the value of _```platformManagementGroup```_ to the management group id for Platform. The same management group id may be repeated.
- Change the value of _```IdentityManagementGroup```_ to the management group id for Identity. The same management group id may be repeated.
- Change the value of _```managementManagementGroup```_ to the management group id for Management. The same management group id may be repeated.
- Change the value of _```connectivityManagementGroup```_ to the management group id for Connectivity. The same management group id may be repeated.
- Change the value of _```LandingZoneManagementGroup```_ to the management group id for Landing Zones. The same management group id may be repeated.

{{< hint type=note >}}
For ease of deployment and maintenance we have kept the same variables. If, for example, you combined Identity, Management and Connectivity into one management group you should configure the variables _```identityManagementGroup```_, _```managementManagementGroup```_ , _```connectivityMaagementGroup```_ and _```LZManagementGroup```_ with the same management group id.
{{< /hint >}}

### If you have a single management group

- Change the value of _```platformManagementGroup```_ to the pseudo root management group id, also called the "Intermediate Root Management Group".
- Change the value of _```IdentityManagementGroup```_ to the pseudo root management group id, also called the "Intermediate Root Management Group".
- Change the value of _```managementManagementGroup```_ to the pseudo root management group id, also called the "Intermediate Root Management Group".
- Change the value of _```connectivityManagementGroup```_ to the pseudo root management group id, also called the "Intermediate Root Management Group".
- Change the value of _```LandingZoneManagementGroup```_ to the pseudo root management group id, also called the "Intermediate Root Management Group".

{{< hint type=note >}}
For ease of deployment and maintenance we have kept the same variables. Configure the variables _```enterpriseScaleCompanyPrefix```_, _```identityManagementGroup```_, _```managementManagementGroup```_, _```connectivityManagementGroup```_ and _```LZManagementGroup```_ with the pseudo root management group id.
{{< /hint >}}

## 2. Example Parameter file

The parameter file shown below has been truncated for brevity, compared to the samples included.

```json
{
    "$schema": "https://schema.management.azure.com/schemas/2019-04-01/deploymentParameters.json#",
    "contentVersion": "1.0.0.0",
    "parameters": {
        "enterpriseScaleCompanyPrefix": {
            "value": "contoso"
        },
        "platformManagementGroup": {
            "value": "contoso-platform"
        },
        "IdentityManagementGroup": {
            "value": "contoso-identity"
        },
        "managementManagementGroup": {
            "value": "contoso-management"
        },
        "connectivityManagementGroup": {
            "value": "contoso-connectivity"
        },
        "LandingZoneManagementGroup": {
            "value": "contoso-landingzones"
        },
        "enableAMBAConnectivity": {
            "value": "Yes"
        },
        "enableAMBAIdentity": {
            "value": "Yes"
        },
        "enableAMBALandingZone": {
            "value": "Yes"
        },
        "enableAMBAManagement": {
            "value": "Yes"
        },
        "enableAMBAServiceHealth": {
            "value": "Yes"
        },
        "policyAssignmentParametersCommon": {
            "value": {
                "ALZMonitorResourceGroupName": {
                    "value": "rg-amba-monitoring-001"
                },
                "ALZMonitorResourceGroupTags": {
                    "value": {
                        "Project": "amba-monitoring"
                    }
                },
                "ALZMonitorResourceGroupLocation": {
                    "value": "eastus"
                }
            }
        }
    }
}
```
