---
title: Deploy only Service Health Alerts
geekdocCollapseSection: true
weight: 70
---

The following guide describes the steps to use the ALZ pattern to implement Service Health Alerts. When you deploy one Policy Set Definition, like Service Health, you will only need the Policy Definitions required by that Policy Set Definition. You can still choose to deploy all Policy Definitions that are provided in the ALZ Pattern, this is recommended when you want to deploy other Policy Set Definitions in the future. In case you first deploy a subset of the Policy Definitions, you can easily deploy additional definitions at a later stage. This document covers two deployment options:

1. [Quick Deployment](../Deploy-only-Service-Health-Alerts/#quick-deployment): Deploys the ALZ Pattern including all Policy Definitions, Policy Set Definitions, however, this assigns only the Service Health Policy Set Definition.
2. [Custom Deployment](../Deploy-only-Service-Health-Alerts/#custom-deployment): Deploys only the Policy Definitions and Policy Set Definition that are needed for the Service Health Alerts. Assigns only the Service Health Policy Set Definition.

{{< hint type=note >}}
In this example we will deploy the Service Health Policy Set Definition via Azure CLI. However, the same principles and steps apply to other Policy Set Definitions and deployment methods as well.
{{< /hint >}}

# Quick deployment

## 1. Parameter configuration

To start, you can either download a copy of the parameter file or clone/fork the repository.

- [alzArm.param.json](https://github.com/azure/azure-monitor-baseline-alerts/blob/2024-08-30/patterns/alz/alzArm.param.json)

The following changes apply to all scenarios, whether you are aligned or unaligned with ALZ or have a single management group.

- Change the value of the following parameters at the beginning of parameter file according to the instructions below:

  {{< hint type=note >}}
  While it's technically possible to not add any notification information (no email, no ARM Role, no Logic App, etc.) it is strongly recommended to configure at least one option.
  {{< /hint >}}

  - Change the value of _```enterpriseScaleCompanyPrefix```_ to the management group where you wish to deploy the policies and the initiatives. This is usually the so called "pseudo root management group", for example, in [ALZ terminology](https://learn.microsoft.com/azure/cloud-adoption-framework/ready/landing-zone/design-area/resource-org-management-groups), this would be the so called "Intermediate Root Management Group" (directly beneath the "Tenant Root Group").
  - Change the value of _```bringYourownUserAssignedManagedIdentity```_ to **Yes** if you have an existing user assigned managed identity with the ***Monitoring Reader*** role assigned at the pseudo root management group level or leave it to **No** if you would like to create a new one with the proper rights as part of the deployment process.
  - Change the value of _```bringYourownUserAssignedManagedIdentityResourceId```_. If you set the _```bringYourownUserAssignedManagedIdentity```_ parameter to **Yes**, insert the resource id of your user assigned managed identity. If you left it with the default value of **No**, leave the value blank.
  - Change the value of _```userAssignedManagedIdentityName```_ to a name of your preference. This parameter is used only if the _```bringYourownUserAssignedManagedIdentity```_ has been set to **No**.
  - Change the value of _```managementSubscriptionId```_. If you set the _```bringYourownUserAssignedManagedIdentity```_ parameter to **No**, enter the subscriptionId of the management subscription, otherwise leave the default value.
  - Change the value of _```ALZMonitorResourceGroupName```_ to the name of the resource group where the activity logs, resource health alerts, actions groups and alert processing rules will be deployed in.
  - Change the value of _```ALZMonitorResourceGroupTags```_ to specify the tags to be added to said resource group.
  - Change the value of _```ALZMonitorResourceGroupLocation```_ to specify the location for said resource group.
  - Change the value of _```ALZMonitorActionGroupEmail```_ to the email address(es) where notifications of the alerts (including Service Health alerts) are sent to. Leave the value blank if no email notification is used.
  - Change the value of _```ALZLogicappResourceId```_ to the Logic app resource id to be used as action for the alerts (including Service Health alerts). Leave the value blank if no Logic app is used.
  - Change the value of _```ALZLogicappCallbackUrl```_ to the Logic app callback url of the Logic app you want to use as action for the alerts (including Service Health alerts). Leave the value blank if no Logic app is used. To retrieve the callback url you can either use the [_**Get-AzLogicAppTriggerCallbackUrl**_](https://learn.microsoft.com/en-us/powershell/module/az.logicapp/get-azlogicapptriggercallbackurl) PowerShell command or navigate to the Logic app in the Azure portal, go to _**Logic app designer**_, expand the trigger activity (_When an HTTP request is received_) and copy the value in the URL field using the 2-sheets icon.

    ![Get Logic app callback url](../../media/AMBA-LogicAppCallbackUrl.png)

  - Change the value of _```ALZArmRoleId```_ to the Azure Resource Manager Role(s) where notifications of the alerts (including Service Health alerts) are sent to. Leave the value blank if no Azure Resource Manager Role notification is required.
  - Change the value of _```ALZEventHubResourceId```_ to the Event Hubs to be used as action for the alerts (including Service Health alerts). Leave the value blank if no Event Hubs is used.
  - Change the value of _```ALZWebhookServiceUri```_ to the URI(s) to be used as action for the alerts (including Service Health alerts). Leave the value blank if no Webhook is used.
  - Change the value of _```ALZFunctionResourceId```_ to the Function resource id to be used as action for the alerts (including Service Health alerts). Leave the value blank if no Function is used.
  - Change the value of _```ALZFunctionTriggerUrl```_ to the Function App trigger url of the function to be used as action for the alerts (including Service Health alerts). Leave the value blank if no Function is used. To retrieve the Function App trigger url with the corresponding code, navigate to the HTTP-triggered functions in the Azure portal, go to _**Code + Test**_, select **Get function URL** from the menu top menu and copy the value in the URL field using the 2-sheets icon.

    ![Get function URL](../../media/AMBA-FunctionAppTriggerUrl.png)

  {{< hint type=note >}}
  It is possible use multiple email addresses, as well as multiple Arm Roles, Webhooks or Event Hubs (not recommended as per ALZ guidance). Should you set multiple entries, make sure they are entered as single string with values separated by comma. Example:

    "ALZMonitorActionGroupEmail": {
      "value": "action1@contoso.com , action2@contoso.com , action3@contoso.com"
      },

    "ALZArmRoleId": {
        "value": "8e3af657-a8ff-443c-a75c-2fe8c4bcb635, b24988ac-6180-42a0-ab88-20f7382dd24c"
      },

    "ALZWebhookServiceUri": {
      "value": "https://webhookUri1.webhook.com, http://webhookUri2.webhook.com"
    },
  {{< /hint >}}

- If you would like to disable initiative assignments, you can change the value on one or more of the following parameters; _```enableAMBAConnectivity```_, _```enableAMBAIdentity```_, _```enableAMBALandingZone```_, _```enableAMBAManagement```_, _```enableAMBAServiceHealth```_ to _**"No"**_.

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
For ease of deployment and maintenance we have kept the same variables. For example, if you combined Identity, Management and Connectivity into one management group you should configure the variables _```identityManagementGroup```_, _```managementManagementGroup```_ , _```connectivityManagementGroup```_ and _```LZManagementGroup```_ with the same management group id.
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

Open your preferred command-line tool (Windows PowerShell, Cmd, Bash or other Unix shells), and navigate to the root of the cloned repo and log on to Azure with an account with at least Resource Policy Contributor access at the root of the management group hierarchy where you will be creating the policies and Policy Set Definitions.

Run the following commands:

```bash
location="Your Azure location of choice"
pseudoRootManagementGroup="The pseudo root management group id parenting the Platform and Landing Zones management groups"
```

{{< hint type=Important >}}
When running Azure CLI from PowerShell the variables have to start with a $.

Above-mentioned ```pseudoRootManagementGroup``` variable value, being the so called "pseudo root management group id", should _coincide_ with the value of the ```enterpriseScaleCompanyPrefix``` parameter, as set previously within the parameter files.

The ```location``` variable refers to the deployment location. Deploying to multiple regions is not necessary as the definitions and assignments are scoped to a management group and are not region-specific.
{{< /hint >}}

## 4. Deploying AMBA

Using your preferred command-line tool (Windows PowerShell, Cmd, Bash or other Unix shells), if you closed your previous session, navigate again to the root of the cloned repo and log on to Azure with an account with at least Resource Policy Contributor access at the root of the management group hierarchy where you will be creating the policies and Policy Set Definitions.

```bash
az deployment mg create --template-uri https://raw.githubusercontent.com/Azure/azure-monitor-baseline-alerts/2024-08-30/patterns/alz/alzArm.json --name "amba-GeneralDeployment" --location $location --management-group-id $pseudoRootManagementGroup --parameters .\patterns\alz\alzArm.param.json
```

</br>

# Custom deployment

## 1. Create a copy of policies.bicep

To create a copy of a Bicep policy file (policies.bicep), you can use standard file copying techniques based on your operating system and programming language of choice. For example, run the following command in PowerShell:

```powershell
Copy-Item -Path .\patterns\alz\templates\policies.bicep -Destination .\patterns\alz\templates\policies-sh.bicep
```

## 2. Edit policies-sh.bicep

Open the newly created Bicep file in your favorite text editor, such as Visual Studio Code (VS Code). Edit the variables ```loadPolicyDefinitions``` and ```loadPolicySetDefinitions``` in your Bicep file to include only the relevant policy definitions. You should delete or comment out the unnecessary lines. In bicep use ``` // ``` to comment a line. The example below shows the lines you need to keep for the Service Health Policy Set Definition.

**loadPolicyDefinitions variable**

```bicep
{
var loadPolicyDefinitions = {
  All: [
    loadTextContent('../../../services/Resources/subscriptions/Deploy-ServiceHealth-ActionGroups.json')
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

Open your preferred command-line tool (Windows PowerShell, Cmd, Bash or other Unix shells), and navigate to the root of the cloned repo and log on to Azure with an account with at least Resource Policy Contributor access at the root of the management group hierarchy where you will be creating the policies and Policy Set Definitions.

Run the following commands:

```bash
location="Your Azure location of choice"
pseudoRootManagementGroup="The pseudo root management group id parenting the identity, management and connectivity management groups"
```

{{< hint type=Important >}}
When running Azure CLI from PowerShell the variables have to start with a $.

Above-mentioned ```pseudoRootManagementGroup``` variable value, being the so called "pseudo root management group id", should _coincide_ with the value of the ```enterpriseScaleCompanyPrefix``` parameter, as set previously within the parameter files.

The ```location``` variable refers to the deployment location. Deploying to multiple regions is not necessary as the definitions and assignments are scoped to a management group and are not region-specific.
{{< /hint >}}

## 5. Deploy Policy Definitions
To deploy policy definitions to the intermediate management group, run the following command:

```bash
az deployment mg create --name "amba-ServiveHealthOnly" --template-file .\patterns\alz\policyDefinitions\policies-sh.json --location $location --management-group-id $pseudoRootManagementGroup --parameters '{ \"topLevelManagementGroupPrefix\": { \"value\": \"contoso\" } }'
```

{{< hint type=note >}}
The command doesn't work in Azure Cloud shell. In Azure Cloud Shell run the following command:
{{< /hint >}}

```bash
az deployment mg create --name "amba-ServiveHealthOnly" --template-file ./patterns/alz/policyDefinitions/policies-sh.json --location $location --management-group-id $pseudoRootManagementGroup --parameters topLevelManagementGroupPrefix=contoso
```


## 6. Assign the Service Health Policy Set Definition
Assign a Policy Set Definition by running the following command:

```bash
az deployment mg create --name "amba-ServiceHealthAssignment" --template-file .\patterns\alz\policyAssignments\DINE-ServiceHealthAssignment.json --location $location --management-group-id $pseudoRootManagementGroup --parameters '{ \"topLevelManagementGroupPrefix\": { \"value\": \"contoso\" }, \"policyAssignmentParameters\": { \"value\": { \"ALZMonitorResourceGroupName\": { \"value\": \"rg-amba-monitoring-001\" }, \"ALZMonitorResourceGroupTags\": { \"value\": { \"Project\": \"amba-monitoring\" } }, \"ALZMonitorResourceGroupLocation\": { \"value\": \"eastus\" }, \"ALZMonitorActionGroupEmail\": { \"value\": \"test@test.com\"} } } }'
```

{{< hint type=important >}}
The final parameter is the ```--parameters``` parameter, which is used to pass a JSON string that contains the parameters for the deployment. The JSON string is enclosed in single quotes and contains escaped double quotes for the keys and values of the parameters. It is possible to create a parameter file instead of using a json-string.

The JSON object contains two parameters: ```topLevelManagementGroupPrefix``` and ```policyAssignmentParameters```. The ```topLevelManagementGroupPrefix``` parameter is used to specify the intermediate root management group, and should _coincide_ with the value of the ```pseudoRootManagementGroup```. The ```policyAssignmentParameters``` parameter is an object that contains the values for the parameters that are used to configure the monitoring resource group. The parameters include the name of the resource group, the tags for the resource group, the location of the resource group, and the email address for the action group associated with the Service Health Policy Set Definition.
{{< /hint >}}

&nbsp;
# Next steps

To remediate non-compliant policies, continue with [Policy remediation](../Remediate-Policies)
