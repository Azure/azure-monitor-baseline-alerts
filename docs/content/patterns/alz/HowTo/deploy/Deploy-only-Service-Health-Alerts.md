---
title: Deploy only Service Health Alerts
geekdocCollapseSection: true
weight: 80
---

{{< hint type=Info >}}
Accessing Security Advisories in Azure Service Health now requires elevated access across the Summary, Impacted Resources, and Issue Updates tabs. Users who have subscription reader access, or tenant roles at tenant scope, aren't able anymore to view security advisory details until they get the required roles. Complete details can be found at [Elevated access for viewing Security Advisories](https://learn.microsoft.com/en-us/azure/service-health/security-advisories-elevated-access?branch=pr-en-us-255499).
</br>
</br>
***This is not impacting AMBA-ALZ configuration that will continue to work independently.***
{{< /hint >}}

### In this page

> [Quick deployment](../Deploy-only-Service-Health-Alerts#quick-deployment) </br>
> [Custom deployment](../Deploy-only-Service-Health-Alerts#custom-deployment) </br>
> [Next Steps](../Deploy-only-Service-Health-Alerts#next-steps) </br>

{{< hint type=Important >}}
Updating from the ***preview*** version isn't supported. If you deployed the ***preview*** version, proceed with [Moving from preview to GA](../../../Resources/Moving-from-preview-to-GA) before continuing.
{{< /hint >}}

This guide describes the steps to use the ALZ pattern to implement Service Health Alerts. When deploying one Policy Set Definition, like Service Health, you will only need the Policy Definitions required by that Policy Set Definition. You can still choose to deploy all Policy Definitions provided in the ALZ Pattern, which is recommended if you plan to deploy other Policy Set Definitions in the future. If you first deploy a subset of the Policy Definitions, you can easily deploy additional definitions later. This document covers two deployment options:

1. [Quick Deployment](../Deploy-only-Service-Health-Alerts/#quick-deployment): Deploys the ALZ Pattern including all Policy Definitions and Policy Set Definitions, but assigns only the Service Health Policy Set Definition.
2. [Custom Deployment](../Deploy-only-Service-Health-Alerts/#custom-deployment): Deploys only the Policy Definitions and Policy Set Definition needed for the Service Health Alerts, and assigns only the Service Health Policy Set Definition.

{{< hint type=note >}}
In this example we will deploy the Service Health Policy Set Definition via Azure CLI. However, the same principles and steps apply to other Policy Set Definitions and deployment methods as well.
{{< /hint >}}

## Quick deployment

### 1. Parameter configuration

To begin, download the appropriate parameter file for the version of AMBA-ALZ you are deploying.

  {{< hint type=note >}}
  Forking or cloning the repository isn’t required for the deployment, unless you have customized the policies as described in [How to modify individual policies](../Introduction-to-deploying-the-ALZ-Pattern#how-to-modify-individual-policies)
  {{< /hint >}}


- [alzArm.param.json](https://github.com/azure/azure-monitor-baseline-alerts/blob/2025-04-04/patterns/alz/alzArm.param.json) aligned to the latest release
- [alzArm.param.json](https://github.com/azure/azure-monitor-baseline-alerts/blob/main/patterns/alz/alzArm.param.json) aligned to the main branch

The following changes apply to all scenarios, whether you are aligned or unaligned with ALZ or have a single management group.

- Change the value of the following parameters at the beginning of the parameter file according to the instructions below:

  {{< hint type=note >}}
  While it's technically possible to not add any notification information (no email, no ARM Role, no Logic App, etc.) it is recommended to configure at least one option.
  {{< /hint >}}

  - Change the value of *```enterpriseScaleCompanyPrefix```* to the management group where you wish to deploy the policies and the initiatives. This is usually the so called "pseudo root management group", for example, in [ALZ terminology](https://learn.microsoft.com/azure/cloud-adoption-framework/ready/landing-zone/design-area/resource-org-management-groups), this would be the so called "Intermediate Root Management Group" (directly beneath the "Tenant Root Group").
  - Change the value of *```bringYourownUserAssignedManagedIdentity```* to **Yes** if you have an existing user assigned managed identity with the ***Monitoring Reader*** role assigned at the pseudo root management group level or leave it to **No** if you would like to create a new one with the proper rights as part of the deployment process.
  - Change the value of *```bringYourownUserAssignedManagedIdentityResourceId```*. If you set the *```bringYourownUserAssignedManagedIdentity```* parameter to **Yes**, insert the resource ID of your user assigned managed identity. If you left it with the default value of **No**, leave the value blank.
  - Change the value of *```userAssignedManagedIdentityName```* to a name of your preference. This parameter is used only if the *```bringYourownUserAssignedManagedIdentity```* has been set to **No**.
  - Change the value of *```managementSubscriptionId```*. If you set the *```bringYourownUserAssignedManagedIdentity```* parameter to **No**, enter the subscriptionId of the management subscription, otherwise leave the default value.
  - Change the value of *```ALZMonitorResourceGroupName```* to the name of the resource group where the activity logs, resource health alerts, actions groups and alert processing rules will be deployed in.
  - Change the value of *```ALZMonitorResourceGroupTags```* to specify the tags to be added to said resource group.
  - Change the value of *```ALZMonitorResourceGroupLocation```* to specify the location for said resource group.
  - Change the value of *```ALZMonitorActionGroupEmail```* to the email address(es) where notifications of the alerts (including Service Health alerts) are sent to. Leave the value blank if no email notification is used.
  - Change the value of *```ALZLogicappResourceId```* to the Logic app resource ID to be used as action for the alerts (including Service Health alerts). Leave the value blank if no Logic app is used.
  - Change the value of *```ALZLogicappCallbackUrl```* to the Logic app callback url of the Logic app you want to use as action for the alerts (including Service Health alerts). Leave the value blank if no Logic app is used. To retrieve the callback url you can either use the [***Get-AzLogicAppTriggerCallbackUrl***](https://learn.microsoft.com/en-us/powershell/module/az.logicapp/get-azlogicapptriggercallbackurl) PowerShell command or navigate to the Logic app in the Azure portal, go to ***Logic app designer***, expand the trigger activity (*When an HTTP request is received*) and copy the value in the URL field using the 2-sheets icon.

    ![Get Logic app callback url](../../../media/AMBA-LogicAppCallbackUrl.png)

  - Change the value of *```ALZArmRoleId```* to the Azure Resource Manager Role(s) where notifications of the alerts (including Service Health alerts) are sent to. Leave the value blank if no Azure Resource Manager Role notification is required.
  - Change the value of *```ALZEventHubResourceId```* to the Event Hubs to be used as action for the alerts (including Service Health alerts). Leave the value blank if no Event Hubs is used.
  - Change the value of *```ALZWebhookServiceUri```* to the URI(s) to be used as action for the alerts (including Service Health alerts). Leave the value blank if no Webhook is used.
  - Change the value of *```ALZFunctionResourceId```* to the Function resource ID to be used as action for the alerts (including Service Health alerts). Leave the value blank if no Function is used.
  - Change the value of *```ALZFunctionTriggerUrl```* to the Function App trigger url of the function to be used as action for the alerts (including Service Health alerts). Leave the value blank if no Function is used. To retrieve the Function App trigger url with the corresponding code, navigate to the HTTP-triggered functions in the Azure portal, go to ***Code + Test***, select **Get function URL** from the menu top menu and copy the value in the URL field using the 2-sheets icon.

    ![Get function URL](../../../media/AMBA-FunctionAppTriggerUrl.png)

  {{< hint type=note >}}
  It is possible use multiple email addresses, as well as multiple Arm Roles, Webhooks or Event Hubs (not recommended as per ALZ guidance). Should you set multiple entries, make sure they are entered as single string with values separated by comma. Example:

  ```json
  "ALZMonitorActionGroupEmail": {
      "value": [
          "action1@contoso.com",
          "action2@contoso.com"
      ]
  },

  "ALZArmRoleId": {
      "value": [
          "8e3af657-a8ff-443c-a75c-2fe8c4bcb635",
          "b24988ac-6180-42a0-ab88-20f7382dd24c"
      ]
  },
  "ALZWebhookServiceUri": {
      "value": [
          "https://webookURI1.webook.com",
          "http://webookURI2.webook.com"
      ]
  }
  ```

  {{< /hint >}}

To disable initiative assignments, set the value of any of the following parameters to **"No"**: *```enableAMBAConnectivity```*, *```enableAMBAIdentity```*, *```enableAMBAManagement```*, *```enableAMBAServiceHealth```*, *```enableAMBANotificationAssets```*, *```enableAMBAHybridVM```*, *```enableAMBAKeyManagement```*, *```enableAMBALoadBalancing```*, *```enableAMBANetworkChanges```*, *```enableAMBARecoveryServices```*, *```enableAMBAStorage```*, *```enableAMBAVM```*, or *```enableAMBAWeb```*.

#### If you are aligned to ALZ

- Change the value of *```platformManagementGroup```* to the management group ID for Platform.
- Change the value of *```IdentityManagementGroup```* to the management group ID for Identity.
- Change the value of *```managementManagementGroup```* to the management group ID for Management.
- Change the value of *```connectivityManagementGroup```* to the management group ID for Connectivity.
- Change the value of *```LandingZoneManagementGroup```* to the management group ID for Landing Zones.

#### If you are unaligned to ALZ

- Change the value of *```platformManagementGroup```* to the management group ID for Platform. The same management group ID may be repeated.
- Change the value of *```IdentityManagementGroup```* to the management group ID for Identity. The same management group ID may be repeated.
- Change the value of *```IdentityManagementGroup```* to the management group ID for Identity. The same management group ID may be repeated.
- Change the value of *```managementManagementGroup```* to the management group ID for Management. The same management group ID may be repeated.
- Change the value of *```connectivityManagementGroup```* to the management group ID for Connectivity. The same management group ID may be repeated.
- Change the value of *```LandingZoneManagementGroup```* to the management group ID for Landing Zones. The same management group ID may be repeated.

{{< hint type=note >}}
For ease of deployment and maintenance we have kept the same variables. For example, if you combined Identity, Management and Connectivity into one management group you should configure the variables *```identityManagementGroup```*, *```managementManagementGroup```* , *```connectivityManagementGroup```* and *```LZManagementGroup```* with the same management group id.
{{< /hint >}}

#### If you have a single management group

- Change the value of *```platformManagementGroup```* to the pseudo root management group ID, also called the "Intermediate Root Management Group".
- Change the value of *```IdentityManagementGroup```* to the pseudo root management group ID, also called the "Intermediate Root Management Group".
- Change the value of *```managementManagementGroup```* to the pseudo root management group ID, also called the "Intermediate Root Management Group".
- Change the value of *```connectivityManagementGroup```* to the pseudo root management group ID, also called the "Intermediate Root Management Group".
- Change the value of *```LandingZoneManagementGroup```* to the pseudo root management group ID, also called the "Intermediate Root Management Group".

{{< hint type=note >}}
For ease of deployment and maintenance we have kept the same variables. Configure the variables *```enterpriseScaleCompanyPrefix```*, *```platformManagementGroup```*, *```identityManagementGroup```*, *```managementManagementGroup```*, *```connectivityManagementGroup```* and *```LZManagementGroup```* with the pseudo root management group ID.
{{< /hint >}}

### 2. Example Parameter file

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
    "enableAMBAManagement": {
      "value": "No"
    },
    "enableAMBAServiceHealth": {
      "value": "Yes"
    },
    "enableAMBANotificationAssets": {
      "value": "No"
    },
    "enableAMBAHybridVM": {
      "value": "No"
    },
    "enableAMBAKeyManagement": {
      "value": "No"
    },
    "enableAMBALoadBalancing": {
      "value": "No"
    },
    "enableAMBANetworkChanges": {
      "value": "No"
    },
    "enableAMBARecoveryServices": {
      "value": "No"
    },
    "enableAMBAStorage": {
      "value": "No"
    },
    "enableAMBAVM": {
      "value": "No"
    },
    "enableAMBAWeb": {
      "value": "No"
    },
    "telemetryOptOut": {
      "value": "No"
    },
    "bringYourOwnUserAssignedManagedIdentity": {
      "value": "No"
    },
    "bringYourOwnUserAssignedManagedIdentityResourceId": {
      "value": ""
    },
    "userAssignedManagedIdentityName": {
      "value": "id-amba-prod-001"
    },
    "managementSubscriptionId": {
      "value": ""
    },
    "ALZMonitorResourceGroupName": {
      "value": "rg-amba-monitoring-001"
    },
    "ALZMonitorResourceGroupLocation": {
      "value": "eastus"
    },
    "ALZMonitorResourceGroupTags": {
      "value": {
        "Project": "amba-monitoring"
      }
    },
    "ALZMonitorDisableTagName": {
      "value": "MonitorDisable"
    },
    "ALZMonitorDisableTagValues": {
      "value": [
        "true",
        "Test",
        "Dev",
        "Sandbox"
      ]
    },
    .
    .
    .
    .
  }
}
```

### 3. Configuring variables for deployment

Open your preferred command-line tool (Windows PowerShell, Cmd, Bash or other Unix shells), and navigate to the folder where the parameter file was downloaded and log into Azure with an account with at least Resource Policy Contributor access at the root of the management group hierarchy where you will be creating the policies and Policy Set Definitions.

Run the following commands:

```bash
location="Your Azure location of choice"
pseudoRootManagementGroup="The pseudo root management group ID parenting the Platform and Landing Zones management groups"
```

{{< hint type=Important >}}
When running Azure CLI from PowerShell the variables have to start with a $.

Above-mentioned ```pseudoRootManagementGroup``` variable value, being the so called "pseudo root management group id", should *coincide* with the value of the ```enterpriseScaleCompanyPrefix``` parameter, as set previously within the parameter files.

The ```location``` variable refers to the deployment location. Deploying to multiple regions is not necessary as the definitions and assignments are scoped to a management group and are not region-specific.
{{< /hint >}}

### 4. Deploying AMBA-ALZ

Using your preferred command-line tool (Windows PowerShell, Cmd, Bash or other Unix shells), if you closed your previous session, navigate again to the folder where the parameter file was downloaded and log on to Azure with an account with at least Resource Policy Contributor access at the root of the management group hierarchy where you will be creating the policies and Policy Set Definitions.

```bash
az deployment mg create --template-uri https://raw.githubusercontent.com/Azure/azure-monitor-baseline-alerts/2025-04-04/patterns/alz/alzArm.json --name "amba-GeneralDeployment" --location $location --management-group-id $pseudoRootManagementGroup --parameters alzArm.param.json
```

</br>

## Custom deployment

### 1. Create a copy of policies.bicep

To create a copy of a Bicep policy file (policies.bicep), you can use standard file copying techniques based on your operating system and programming language of choice. For example, run the following command in PowerShell:

```powershell
Copy-Item -Path .\patterns\alz\templates\policies.bicep -Destination .\patterns\alz\templates\policies-sh.bicep
```

### 2. Edit policies-sh.bicep

Open the newly created Bicep file in your favorite text editor, such as Visual Studio Code (VS Code). Edit the variables ```loadPolicyDefinitions``` and ```loadPolicySetDefinitions``` in your Bicep file to include only the relevant policy definitions. You should delete or comment out the unnecessary lines. In bicep use ``` // ``` to comment a line. The example below shows the lines you need to keep for the Service Health Policy Set Definition.

#### loadPolicyDefinitions variable

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

#### loadPolicySetDefinitions variable

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

### 3. Build policies-sh.json

To compile your Bicep file and generate the corresponding JSON ARM template file, you can use the bicep build command. Follow these steps:

```bash
bicep build .\patterns\alz\templates\policies-sh.bicep --outfile .\patterns\alz\policyDefinitions\policies-sh.json
```

{{< hint type=note >}}
Make sure you have the [Bicep CLI](https://learn.microsoft.com/en-us/azure/azure-resource-manager/bicep/install) installed and configured in your environment before running this command.
{{< /hint >}}

### 4. Configuring variables for deployment

Open your preferred command-line tool (Windows PowerShell, Cmd, Bash or other Unix shells), and navigate to the folder where the parameter file was downloaded log on to Azure with an account with at least Resource Policy Contributor access at the root of the management group hierarchy where you will be creating the policies and Policy Set Definitions.

Run the following commands:

```bash
location="Your Azure location of choice"
pseudoRootManagementGroup="The pseudo root management group id parenting the identity, management and connectivity management groups"
```

{{< hint type=Important >}}
When running Azure CLI from PowerShell the variables have to start with a $.

Above-mentioned ```pseudoRootManagementGroup``` variable value, being the so called "pseudo root management group id", should *coincide* with the value of the ```enterpriseScaleCompanyPrefix``` parameter, as set previously within the parameter files.

The ```location``` variable refers to the deployment location. Deploying to multiple regions is not necessary as the definitions and assignments are scoped to a management group and are not region-specific.
{{< /hint >}}

### 5. Deploy Policy Definitions

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

### 6. Assign the Service Health Policy Set Definition

Assign a Policy Set Definition by running the following command:

```bash
az deployment mg create --name "amba-ServiceHealthAssignment" --template-file .\patterns\alz\policyAssignments\DINE-ServiceHealthAssignment.json --location $location --management-group-id $pseudoRootManagementGroup --parameters '{ \"topLevelManagementGroupPrefix\": { \"value\": \"contoso\" }, \"policyAssignmentParameters\": { \"value\": { \"ALZMonitorResourceGroupName\": { \"value\": \"rg-amba-monitoring-001\" }, \"ALZMonitorResourceGroupTags\": { \"value\": { \"Project\": \"amba-monitoring\" } }, \"ALZMonitorResourceGroupLocation\": { \"value\": \"eastus\" }, \"ALZMonitorActionGroupEmail\": { \"value\": \"test@test.com\"} } } }'
```

{{< hint type=important >}}
The final parameter is the ```--parameters``` parameter, which is used to pass a JSON string that contains the parameters for the deployment. The JSON string is enclosed in single quotes and contains escaped double quotes for the keys and values of the parameters. It is possible to create a parameter file instead of using a json-string.

The JSON object contains two parameters: ```topLevelManagementGroupPrefix``` and ```policyAssignmentParameters```. The ```topLevelManagementGroupPrefix``` parameter is used to specify the intermediate root management group, and should *coincide* with the value of the ```pseudoRootManagementGroup```. The ```policyAssignmentParameters``` parameter is an object that contains the values for the parameters that are used to configure the monitoring resource group. The parameters include the name of the resource group, the tags for the resource group, the location of the resource group, and the email address for the action group associated with the Service Health Policy Set Definition.
{{< /hint >}}

## Next steps

To remediate non-compliant policies, continue with [Policy remediation](../Remediate-Policies)
