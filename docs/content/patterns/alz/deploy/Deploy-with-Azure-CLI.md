---
title: Deploy with Azure CLI
weight: 30
---

{{< hint type=Important >}}
Updating from a preview version is not supported. If you deployed a preview version, please proceed with [Moving from preview to GA](../../Moving-from-preview-to-GA) before continuing.
{{< /hint >}}

## 1. Parameter configuration

To start, you can either download a copy of the parameter file or clone/fork the repository.

- [alzArm.param.json](https://github.com/azure/azure-monitor-baseline-alerts/blob/main/patterns/alz/alzArm.param.json)

The following changes apply to all scenarios, whether you are aligned or unaligned with ALZ or have a single management group.

- Change the value of _enterpriseScaleCompanyPrefix_ to the management group where you wish to deploy the policies and the initiatives. This is usually the so called "pseudo root management group", e.g. in [ALZ terminology](https://learn.microsoft.com/azure/cloud-adoption-framework/ready/landing-zone/design-area/resource-org-management-groups), this would be the so called "Intermediate Root Management Group" (directly beneath the "Tenant Root Group").
- Change the value of _ALZMonitorResourceGroupName_ to the name of the resource group where the activity logs, resource health alerts, actions groups and alert processing rules will be deployed in.
<!--
- Change the value of _ALZMonitorResourceGroupTags_ to specify the tags to be added to said resource group.
-->
- Change the value of _ALZMonitorResourceGroupLocation_ to specify the location for said resource group.
- Change the value of _ALZMonitorActionGroupEmail_ (specific to the Service Health initiative) to the email address where notifications of the alerts are sent to.
- If you would like to disable initiative assignments, you can change the value on one or more of the following parameters; _enableAMBAConnectivity_, _enableAMBAIdentity_, _enableAMBALandingZone_, _enableAMBAManagement_, _enableAMBAServiceHealth_ to "No".

### If you are aligned to ALZ

- Change the value of _platformManagementGroup_ to the management group id for Platform.
- Change the value of _IdentityManagementGroup_ to the management group id for Identity.
- Change the value of _managementManagementGroup_ to the management group id for Management.
- Change the value of _connectivityManagementGroup_ to the management group id for Connectivity.
- Change the value of _LandingZoneManagementGroup_ to the management group id for Landing Zones.

### If you are unaligned to ALZ

- Change the value of _platformManagementGroup_ to the management group id for Platform. The same management group id may be repeated.
- Change the value of _IdentityManagementGroup_ to the management group id for Identity. The same management group id may be repeated.
- Change the value of _managementManagementGroup_ to the management group id for Management. The same management group id may be repeated.
- Change the value of _connectivityManagementGroup_ to the management group id for Connectivity. The same management group id may be repeated.
- Change the value of _LandingZoneManagementGroup_ to the management group id for Landing Zones. The same management group id may be repeated.

{{< hint type=note >}}
For ease of deployment and maintenance we have kept the same variables. If, for example, you combined Identity, Management and Connectivity into one management group you should configure the variables _identityManagementGroup_, _managementManagementGroup_ and _connectivityManagementGroup_ with the same management group id.
{{< /hint >}}

### If you have a single management group

- Change the value of _platformManagementGroup_ to the pseudo root management group id, also called the "Intermediate Root Management Group".
- Change the value of _IdentityManagementGroup_ to the pseudo root management group id, also called the "Intermediate Root Management Group".
- Change the value of _managementManagementGroup_ to the pseudo root management group id, also called the "Intermediate Root Management Group".
- Change the value of _connectivityManagementGroup_ to the pseudo root management group id, also called the "Intermediate Root Management Group".
- Change the value of _LandingZoneManagementGroup_ to the pseudo root management group id, also called the "Intermediate Root Management Group".

{{< hint type=note >}}
For ease of deployment and maintenance we have kept the same variables. Configure the variables _enterpriseScaleCompanyPrefix_, _identityManagementGroup_, _managementManagementGroup_, _connectivityManagementGroup_ and _LZManagementGroup_ with the pseudo root management group id.
{{< /hint >}}

## 2. Example Parameter file

Note that the parameter file shown below has been truncated for brevity, compared to the samples included.

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
                    "value": "rg-alz-monitor"
                },
                "ALZMonitorResourceGroupTags": {
                    "value": {
                        "Project": "alz-monitor"
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

## 3. Configuring variables for deployment

The following commands apply to all scenarios, whether you are aligned or unaligned with ALZ or have a single management group.

Open your preferred command line tool (Windows PowerShell, Cmd, Bash or other Unix shells), and navigate to the root of the cloned repo and log on to Azure with an account with at least Resource Policy Contributor access at the root of the management group hierarchy where you will be creating the policies and initiatives.

Run the following commands:

```bash
location="Your Azure location of choice"
pseudoRootManagementGroup="The pseudo root management group id parenting the identity, management and connectivity management groups"
```

{{< hint type=Important >}}
When running Azure CLI from PowerShell the variables have to start with a $.

Above-mentioned "pseudoRootManagementGroup" variable value, being the so called "pseudo root management group id", should _coincide_ with the value of the "enterpriseScaleCompanyPrefix" parameter, as set previously within the parameter files.

The location variable refers to the deployment location. Deploying to multiple regions is not necessary as the definitions and assignments are scoped to a management group and are not region specific.
{{< /hint >}}

## 4. Deploying AMBA

The following commands apply to all scenarios, whether you are aligned or unaligned with ALZ or have a single management group.

Using your preferred command line tool (Windows PowerShell, Cmd, Bash or other Unix shells), if you closed your previous session, navigate again to the root of the cloned repo and log on to Azure with an account with at least Resource Policy Contributor access at the root of the management group hierarchy where you will be creating the policies and initiatives.

{{< hint type=note >}}
This should be tested in a safe environment. If you are subsequently looking to deploy to prod environments, consider leveraging the guidance found in [Customize Policy Assignment](../Customize-Policy-Assignment), to deploy and enable alerts in a controlled manner.
{{< /hint >}}

```bash
az deployment mg create --template-uri https://raw.githubusercontent.com/Azure/azure-monitor-baseline-alerts/main/patterns/alz/alzArm.json --location $location --management-group-id $pseudoRootManagementGroup --parameters .\patterns\alz\alzArm.param.json
```

## Next steps

To remediate non-compliant policies, please proceed with [Policy remediation](../Remediate-Policies)
