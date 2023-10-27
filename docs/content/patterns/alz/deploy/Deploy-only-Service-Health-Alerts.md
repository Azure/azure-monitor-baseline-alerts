---
title: Deploy only Service Health Alerts
geekdocCollapseSection: true
weight: 70
---

The following guide describes the steps to leverage the ALZ pattern to implement Service Health Alerts. When you deploy one Policy Set Definition, like Service Health, you will only need the Policy Definitions required by that Policy Set Definition. You can still choose to deploy all Policy Definitions that are provided in the ALZ Pattern, this is recommended when you want to deploy other Policy Set Definitions in the future. In case you first deploy a subset of the Policy Definitions, you can easily deploy additional definitions at a later stage. This document covers two deployment options:

1. [Quick Deployment](../Deploy-only-Service-Health-Alerts/#quick-deployment): Deploys the ALZ Pattern including all Policy Definitions, Policy Set Definitions, however, this assigns only the Service Health Policy Set Definition.
1. [Custom Deployment](../Deploy-only-Service-Health-Alerts/#custom-deployment): Deploy only the Policy Definitions and Policy Set Definition that are needed for the Service Health Alerts. Assings only the Service Health Policy Set Definition.

{{< hint type=note >}}
In this example we will deploy the Service Health Policy Set Definition via Azure CLI. However, the same principles and steps apply to other Policy Set Definitions and deployment methods as well. 
{{< /hint >}}

&nbsp;
# Quick deployment

## 1. Parameter configuration

To start, you can either download a copy of the parameter file or clone/fork the repository.

- [alzArm.param.json](https://github.com/azure/azure-monitor-baseline-alerts/blob/main/patterns/alz/alzArm.param.json)

Make the following changes to the parameter file:

- Change the value of ```enterpriseScaleCompanyPrefix``` to the management group where you wish to deploy the policies and the Policy Set Definitions. This is usually the so called "pseudo root management group", e.g. in [ALZ terminology](https://learn.microsoft.com/azure/cloud-adoption-framework/ready/landing-zone/design-area/resource-org-management-groups), this would be the so called "Intermediate Root Management Group" (directly beneath the "Tenant Root Group").
- Disable Policy Set Definition assignments. When deploying only the Service Health Policy Set Definition you should change the value of the following parameters; ```enableAMBAConnectivity```, ```enableAMBAIdentity```, ```enableAMBALandingZone```, ```enableAMBAManagement``` to "No".
- Change the value of ```ALZMonitorResourceGroupName``` to the name of the resource group where the activity logs, resource health alerts, actions groups and alert processing rules will be deployed in.
- Change the value of ```ALZMonitorResourceGroupTags``` to specify the tags to be added to said resource group.
- Change the value of ```ALZMonitorResourceGroupLocation``` to specify the location for said resource group.
- Change the value of ```ALZMonitorActionGroupEmail``` (specific to the Service Health Policy Set Definition) to the email address(es) where notifications of the alerts are sent to.

  {{< hint type=note >}}
  For multiple email addresses, make sure they are entered a single string with values separated by comma. Example:

    "ALZMonitorActionGroupEmail": {
      "value": "action1@mail.com , action2@mail.com , action3@mail.com"
      },
  {{< /hint >}}

## 2. Example Parameter file

Note that the following parameter file example shows a specific example configuration that already shows other Policy Set Definitions as disabled. The file shown has been truncated for brevity, compared to the samples included.

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
            "value": "No"
        },
        "enableAMBAIdentity": {
            "value": "No"
        },
        "enableAMBALandingZone": {
            "value": "No"
        },
        "enableAMBAManagement": {
            "value": "No"
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

## 3. Configuring variables for deployment

Open your preferred command line tool (Windows PowerShell, Cmd, Bash or other Unix shells), and navigate to the root of the cloned repo and log on to Azure with an account with at least Resource Policy Contributor access at the root of the management group hierarchy where you will be creating the policies and Policy Set Definitions.

Run the following commands:

```bash
location="Your Azure location of choice"
pseudoRootManagementGroup="The pseudo root management group id parenting the identity, management and connectivity management groups"
```

{{< hint type=Important >}}
When running Azure CLI from PowerShell the variables have to start with a $.

Above-mentioned ```pseudoRootManagementGroup``` variable value, being the so called "pseudo root management group id", should _coincide_ with the value of the ```enterpriseScaleCompanyPrefix``` parameter, as set previously within the parameter files.

The ```location``` variable refers to the deployment location. Deploying to multiple regions is not necessary as the definitions and assignments are scoped to a management group and are not region specific.
{{< /hint >}}

## 4. Deploying AMBA

Using your preferred command line tool (Windows PowerShell, Cmd, Bash or other Unix shells), if you closed your previous session, navigate again to the root of the cloned repo and log on to Azure with an account with at least Resource Policy Contributor access at the root of the management group hierarchy where you will be creating the policies and Policy Set Definitions.

```bash
az deployment mg create --template-uri https://raw.githubusercontent.com/Azure/azure-monitor-baseline-alerts/main/patterns/alz/alzArm.json --location $location --management-group-id $pseudoRootManagementGroup --parameters .\patterns\alz\alzArm.param.json
```
&nbsp;
# Custom deployment

## 1. Create a copy of policies.bicep

To create a copy of a Bicep policy file (policies.bicep), you can use standard file copying techniques based on your operating system and programming language of choice. For example, run the following command in PowerShell:

```powershell
Copy-Item -Path .\patterns\alz\templates\policies.bicep -Destination .\patterns\alz\templates\policies-sh.bicep
```

## 2. Edit policies-sh.bicep

Open the newly created Bicep file in your favorite text editor, such as Visual Studio Code (VSCode). Edit the variables ```loadPolicyDefinitions``` and ```loadPolicySetDefinitions``` in your Bicep file to include only the relevant policy definitions. You should delete or comment out the unnecessary lines. In bicep use ``` // ``` to comment a line. The example below shows the lines you need to keep for the Service Health Policy Set Definition. 

**loadPolicyDefinitions variable**

```bicep
{
var loadPolicyDefinitions = {
  All: [
    loadTextContent('../../../services/AlertsManagement/actionRules/Deploy-AlertProcessingRule-Deploy.json')
    loadTextContent('../../../services/Resources/subscriptions/Deploy-ActivityLog-ResourceHealth-UnHealthly-Alert.json')
    loadTextContent('../../../services/Resources/subscriptions/Deploy-ActivityLog-ServiceHealth-Health.json')
    loadTextContent('../../../services/Resources/subscriptions/Deploy-ActivityLog-ServiceHealth-Incident.json')
    loadTextContent('../../../services/Resources/subscriptions/Deploy-ActivityLog-ServiceHealth-Maintenance.json')
    loadTextContent('../../../services/Resources/subscriptions/Deploy-ActivityLog-ServiceHealth-Security.json')
  ]
  AzureCloud: []
  AzureChinaCloud: []
  AzureUSGovernment: []
}
}
```

**loadPolicySetDefinitions variable**

```bicep
var loadPolicySetDefinitions = {
  All: [
    loadTextContent('../policySetDefinitions/Deploy-ServiceHealth-Alerts.json')
  ]
  AzureCloud: []
  AzureChinaCloud: []
  AzureUSGovernment: []
}
```

## 3. Build policies-sh.json

To compile your Bicep file and generate the corresponding JSON ARM template file, you can use the bicep build command. Follow these steps:

```bash
bicep build .\patterns\alz\templates\policies-sh.bicep --outfile .\patterns\alz\policyDefinitions\policies-sh.json
```

{{< hint type=note >}}
Make sure you have the [Bicep CLI](https://learn.microsoft.com/en-us/azure/azure-resource-manager/bicep/install) installed and configured in your environment before running this command.
{{< /hint >}}

## 4. Configuring variables for deployment

Open your preferred command line tool (Windows PowerShell, Cmd, Bash or other Unix shells), and navigate to the root of the cloned repo and log on to Azure with an account with at least Resource Policy Contributor access at the root of the management group hierarchy where you will be creating the policies and Policy Set Definitions.

Run the following commands:

```bash
location="Your Azure location of choice"
pseudoRootManagementGroup="The pseudo root management group id parenting the identity, management and connectivity management groups"
```

{{< hint type=Important >}}
When running Azure CLI from PowerShell the variables have to start with a $.

Above-mentioned ```pseudoRootManagementGroup``` variable value, being the so called "pseudo root management group id", should _coincide_ with the value of the ```enterpriseScaleCompanyPrefix``` parameter, as set previously within the parameter files.

The ```location``` variable refers to the deployment location. Deploying to multiple regions is not necessary as the definitions and assignments are scoped to a management group and are not region specific.
{{< /hint >}}


## 5. Deploy Policy Definitions
To deploy policy definitions to the intermediate management group, run the following command:

```bash
az deployment mg create --template-file .\patterns\alz\policyDefinitions\policies-sh.json --location $location --management-group-id $pseudoRootManagementGroup
```

## 6. Assign the Service Health Policy Policy Set Definition
Assign a Policy Set Definition by running the following command:

```bash
az deployment mg create --template-file .\patterns\alz\policyAssignments\DINE-ServiceHealthAssignment.json --location $location --management-group-id $pseudoRootManagementGroup --parameters '{ \"topLevelManagementGroupPrefix\": { \"value\": \"contoso\" }, \"policyAssignmentParameters\": { \"value\": { \"ALZMonitorResourceGroupName\": { \"value\": \"rg-amba-monitoring-001\" }, \"ALZMonitorResourceGroupTags\": { \"value\": { \"Project\": \"amba-monitoring\" } }, \"ALZMonitorResourceGroupLocation\": { \"value\": \"eastus\" }, \"ALZMonitorActionGroupEmail\": { \"value\": \"test@test.com\"} } } }'
```

{{< hint type=important >}}
The final parameter is the ```--parameters``` parameter, which is used to pass a JSON string that contains the parameters for the deployment. The JSON string is enclosed in single quotes and contains escaped double quotes for the keys and values of the parameters.

The JSON object contains two parameters: ```topLevelManagementGroupPrefix``` and ```policyAssignmentParameters```. The ```topLevelManagementGroupPrefix``` parameter is used to specify the intermediate root management group, and should _coincide_ with the value of the ```pseudoRootManagementGroup```. The ```policyAssignmentParameters``` parameter is an object that contains the values for the parameters that are used to configure the monitoring resource group. The parameters include the name of the resource group, the tags for the resource group, the location of the resource group, and the email address for the action group associated with the Service Health Policy Set Definition.
{{< /hint >}}

&nbsp;
# Next steps

To remediate non-compliant policies, please proceed with [Policy remediation](../Remediate-Policies)
