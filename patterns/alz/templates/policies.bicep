targetScope = 'managementGroup'

@metadata({ message: 'The JSON version of this file is programatically generated from Bicep. PLEASE DO NOT UPDATE MANUALLY!!' })
@description('Provide a prefix (unique at tenant-scope) for the Management Group hierarchy and other resources created as part of an Azure landing zone. DEFAULT VALUE = "alz"')
param topLevelManagementGroupPrefix string = 'alz'

@description('Optionally set the deployment location for policies with Deploy If Not Exists effect. DEFAULT VALUE = "deployment().location"')
param location string = deployment().location

@description('Optionally set the scope for custom Policy Definitions used in Policy Set Definitions (Initiatives). Must be one of \'/\', \'/subscriptions/id\' or \'/providers/Microsoft.Management/managementGroups/id\'. DEFAULT VALUE = \'/providers/Microsoft.Management/managementGroups/\${topLevelManagementGroupPrefix}\'')
param scope string = tenantResourceId('Microsoft.Management/managementGroups', topLevelManagementGroupPrefix)

// Extract the environment name to dynamically determine which policies to deploy.
var cloudEnv = environment().name

// Default deployment locations used in templates
var defaultDeploymentLocationByCloudType = {
  AzureCloud: 'northeurope'
  AzureChinaCloud: 'chinaeast2'
  AzureUSGovernment: 'usgovvirginia'
}

// Used to identify template variables used in the templates for replacement.
var templateVars = {
  scope: '/providers/Microsoft.Management/managementGroups/contoso'
  defaultDeploymentLocation: '"location": "northeurope"'
  localizedDeploymentLocation: '"location": "${defaultDeploymentLocationByCloudType[cloudEnv]}"'
}

var targetDeploymentLocationByCloudType = {
  AzureCloud: location ?? 'northeurope'
  AzureChinaCloud: location ?? 'chinaeast2'
  AzureUSGovernment: location ?? 'usgovvirginia'
}

var deploymentLocation = '"location": "${targetDeploymentLocationByCloudType[cloudEnv]}"'

// Unable to do the following commented out approach due to the error "The value must be a compile-time constant.bicep(BCP032)"
// See: https://github.com/Azure/bicep/issues/3816#issuecomment-1191230215

// The following vars are used to load the list of Policy Definitions to import
// var listPolicyDefinitionsAll = loadJsonContent('../data/policyDefinitions.All.json')
// var listPolicyDefinitionsAzureCloud = loadJsonContent('../data/policyDefinitions.AzureCloud.json')
// var listPolicyDefinitionsAzureChinaCloud = loadJsonContent('../data/policyDefinitions.AzureChinaCloud.json')
// var listPolicyDefinitionsAzureUSGovernment = loadJsonContent('../data/policyDefinitions.AzureUSGovernment.json')

// The following vars are used to load the list of Policy Set Definitions to import
// var listPolicySetDefinitionsAll = loadJsonContent('../data/policySetDefinitions.All.json')
// var listPolicySetDefinitionsAzureCloud = loadJsonContent('../data/policySetDefinitions.AzureCloud.json')
// var listPolicySetDefinitionsAzureChinaCloud = loadJsonContent('../data/policySetDefinitions.AzureChinaCloud.json')
// var listPolicySetDefinitionsAzureUSGovernment = loadJsonContent('../data/policySetDefinitions.AzureUSGovernment.json')

// The following vars are used to load the list of Policy Definitions to import
// var loadPolicyDefinitionsAll = [for item in listPolicyDefinitionsAll: loadTextContent(item)]
// var loadPolicyDefinitionsAzureCloud = [for item in listPolicyDefinitionsAzureCloud: loadTextContent(item)]
// var loadPolicyDefinitionsAzureChinaCloud = [for item in listPolicyDefinitionsAzureChinaCloud: loadTextContent(item)]
// var loadPolicyDefinitionsAzureUSGovernment = [for item in listPolicyDefinitionsAzureUSGovernment: loadTextContent(item)]

// The following vars are used to load the list of Policy Set Definitions to import
// var loadPolicySetDefinitionsAll = [for item in listPolicySetDefinitionsAll: loadTextContent(item)]
// var loadPolicySetDefinitionsAzureCloud = [for item in listPolicySetDefinitionsAzureCloud: loadTextContent(item)]
// var loadPolicySetDefinitionsAzureChinaCloud = [for item in listPolicySetDefinitionsAzureChinaCloud: loadTextContent(item)]
// var loadPolicySetDefinitionsAzureUSGovernment = [for item in listPolicySetDefinitionsAzureUSGovernment: loadTextContent(item)]

// The following var contains lists of files containing Policy Definition resources to load, grouped by compatibility with Cloud.
// To get a full list of Azure clouds, use the az cli command "az cloud list --output table"
// We use loadTextContent instead of loadJsonContent  as this allows us to perform string replacement operations against the imported templates.
var loadPolicyDefinitions = {
  All: [
    loadTextContent('../../../services/Automation/automationAccounts/Deploy-AA-TotalJob-Alert.json')
    loadTextContent('../../../services/Network/azureFirewalls/Deploy-ActivityLog-AzureFirewall-Del.json')
    loadTextContent('../../../services/KeyVault/vaults/Deploy-ActivityLog-KeyVault-Del.json')
    loadTextContent('../../../services/OperationalInsights/workspaces/Deploy-ActivityLog-LAWorkspace-Del.json')
    loadTextContent('../../../services/OperationalInsights/workspaces/Deploy-ActivityLog-LAWorkspace-KeyRegen.json')
    loadTextContent('../../../services/Network/networkSecurityGroups/Deploy-ActivityLog-NSG-Del.json')
    loadTextContent('../../../services/Network/routeTables/Deploy-ActivityLog-RouteTable-Update.json')
    loadTextContent('../../../services/Resources/subscriptions/Deploy-ServiceHealth-ActionGroups.json')
    loadTextContent('../../../services//Resources/subscriptions/Deploy-ActivityLog-ResourceHealth-UnHealthly-Alert.json')
    loadTextContent('../../../services/Resources/subscriptions/Deploy-ActivityLog-ServiceHealth-Health.json')
    loadTextContent('../../../services/Resources/subscriptions/Deploy-ActivityLog-ServiceHealth-Incident.json')
    loadTextContent('../../../services/Resources/subscriptions/Deploy-ActivityLog-ServiceHealth-Maintenance.json')
    loadTextContent('../../../services/Resources/subscriptions/Deploy-ActivityLog-ServiceHealth-Security.json')
    loadTextContent('../../../services/Network/vpnGateways/Deploy-ActivityLog-VPNG-Del.json')
    loadTextContent('../../../services/Network/azureFirewalls/Deploy-AFW-FirewallHealth-Alert.json')
    loadTextContent('../../../services/Network/azureFirewalls/Deploy-AFW-SNATPortUtilization-Alert.json')
    loadTextContent('../../../services/AlertsManagement/actionRules/Deploy-AlertProcessingRule-Deploy.json')
    loadTextContent('../../../services/AlertsManagement/actionRules/Deploy-AlertProcessingRule-Suppression.json')
    loadTextContent('../../../services/Network/expressRouteCircuits/Deploy-ERCIR-ARPAvailability-Alert.json')
    loadTextContent('../../../services/Network/expressRouteCircuits/Deploy-ERCIR-BGPAvailability-Alert.json')
    loadTextContent('../../../services/Network/expressRouteCircuits/Deploy-ERCIR-QOSDropsBitsIn-Alert.json')
    loadTextContent('../../../services/Network/expressRouteCircuits/Deploy-ERCIR-QOSDropsBitsOut-Alert.json')
    loadTextContent('../../../services/Network/expressRouteGateways/Deploy-ERG-BitsInPerSecond-Alert.json')
    loadTextContent('../../../services/Network/expressRouteGateways/Deploy-ERG-BitsOutPerSecond-Alert.json')
    loadTextContent('../../../services/Network/expressRouteGateways/Deploy-ERG-CPUUtilization-Alert.json')
    loadTextContent('../../../services/KeyVault/vaults/Deploy-KV-Availability-Alert.json')
    loadTextContent('../../../services/KeyVault/vaults/Deploy-KV-Capacity-Alert.json')
    loadTextContent('../../../services/KeyVault/vaults/Deploy-KV-Latency-Alert.json')
    loadTextContent('../../../services/KeyVault/vaults/Deploy-KV-Requests-Alert.json')
    loadTextContent('../../../services/Network/privateDnsZones/Deploy-PDNSZ-CapacityUtilization-Alert.json')
    loadTextContent('../../../services/Network/privateDnsZones/Deploy-PDNSZ-QueryVolume-Alert.json')
    loadTextContent('../../../services/Network/privateDnsZones/Deploy-PDNSZ-RecordSetCapacity-Alert.json')
    loadTextContent('../../../services/Network/privateDnsZones/Deploy-PDNSZ-RegistrationCapacityUtilization-Alert.json')
    loadTextContent('../../../services/Network/publicIPAddresses/Deploy-PIP-BytesInDDOSAttack-Alert.json')
    loadTextContent('../../../services/Network/publicIPAddresses/Deploy-PIP-DDOSAttack-Alert.json')
    loadTextContent('../../../services/Network/publicIPAddresses/Deploy-PIP-PacketsInDDOS-Alert.json')
    loadTextContent('../../../services/Network/publicIPAddresses/Deploy-PIP-VIPAvailability-Alert.json')
    loadTextContent('../../../services/storage/storageAccounts/Deploy-SA-Availability-Alert.json')
    loadTextContent('../../../services/storage/storageAccounts/Deploy-ActivityLog-SA-Delete-Alert.json')
    loadTextContent('../../../services/Compute/virtualMachines/Deploy-VM-AvailableMemory-Alert.json')
    loadTextContent('../../../services/Compute/virtualMachines/Deploy-VM-DataDiskReadLatency-Alert.json')
    loadTextContent('../../../services/Compute/virtualMachines/Deploy-VM-DataDiskSpace-Alert.json')
    loadTextContent('../../../services/Compute/virtualMachines/Deploy-VM-DataDiskWriteLatency-Alert.json')
    loadTextContent('../../../services/Compute/virtualMachines/Deploy-VM-HeartBeat-Alert.json')
    loadTextContent('../../../services/Compute/virtualMachines/Deploy-VM-HeartBeatAlertRG.json')
    loadTextContent('../../../services/Compute/virtualMachines/Deploy-VM-NetworkIn-Alert.json')
    loadTextContent('../../../services/Compute/virtualMachines/Deploy-VM-NetworkOut-Alert.json')
    loadTextContent('../../../services/Compute/virtualMachines/Deploy-VM-OSDiskReadLatency-Alert.json')
    loadTextContent('../../../services/Compute/virtualMachines/Deploy-VM-OSDiskSpace-Alert.json')
    loadTextContent('../../../services/Compute/virtualMachines/Deploy-VM-OSDiskWriteLatency-Alert.json')
    loadTextContent('../../../services/Compute/virtualMachines/Deploy-VM-PercentCPU-Alert.json')
    loadTextContent('../../../services/Compute/virtualMachines/Deploy-VM-PercentMemory-Alert.json')
    loadTextContent('../../../services/Network/virtualNetworks/Deploy-VNET-DDOSAttack-Alert.json')
    loadTextContent('../../../services/Network/virtualNetworkGateways/Deploy-VNETG-BandwidthUtilization-Alert.json')
    loadTextContent('../../../services/Network/virtualNetworkGateways/Deploy-VNETG-Egress-Alert.json')
    loadTextContent('../../../services/Network/virtualNetworkGateways/Deploy-VNETG-EgressPacketDropCount-Alert.json')
    loadTextContent('../../../services/Network/virtualNetworkGateways/Deploy-VNETG-EgressPacketDropMismatch-Alert.json')
    loadTextContent('../../../services/Network/virtualNetworkGateways/Deploy-VNETG-ERGBitsPerSecond-Alert.json')
    loadTextContent('../../../services/Network/virtualNetworkGateways/Deploy-VNETG-ERGCPUUtilization-Alert.json')
    loadTextContent('../../../services/Network/virtualNetworkGateways/Deploy-VNETG-Ingress-Alert.json')
    loadTextContent('../../../services/Network/virtualNetworkGateways/Deploy-VNETG-IngressPacketDropCount-Alert.json')
    loadTextContent('../../../services/Network/virtualNetworkGateways/Deploy-VNETG-IngressPacketDropMismatch-Alert.json')
    loadTextContent('../../../services/Network/vpnGateways/Deploy-VPNG-BandwidthUtilization-Alert.json')
    loadTextContent('../../../services/Network/vpnGateways/Deploy-VPNG-BGPPeerStatus-Alert.json')
    loadTextContent('../../../services/Network/vpnGateways/Deploy-VPNG-Egress-Alert.json')
    loadTextContent('../../../services/Network/vpnGateways/Deploy-VPNG-EgressPacketDropCount-Alert.json')
    loadTextContent('../../../services/Network/vpnGateways/Deploy-VPNG-EgressPacketDropMismatch-Alert.json')
    loadTextContent('../../../services/Network/vpnGateways/Deploy-VPNG-Ingress-Alert.json')
    loadTextContent('../../../services/Network/vpnGateways/Deploy-VPNG-IngressPacketDropCount-Alert.json')
    loadTextContent('../../../services/Network/vpnGateways/Deploy-VPNG-IngressPacketDropMismatch-Alert.json')
    loadTextContent('../../../services/RecoveryServices/vaults/Modify-RSV-BackupHealth-Alert.json')
    loadTextContent('../../../services/Network/applicationGateways/Deploy-AGW-ApplicationGatewayTotalTime-Alert.json')
    loadTextContent('../../../services/Network/applicationGateways/Deploy-AGW-BackendLastByteResponseTime-Alert.json')
    loadTextContent('../../../services/Network/applicationGateways/Deploy-AGW-CapacityUnits-Alert.json')
    loadTextContent('../../../services/Network/applicationGateways/Deploy-AGW-ComputeUnits-Alert.json')
    loadTextContent('../../../services/Network/applicationGateways/Deploy-AGW-CPUUtil-Alert.json')
    loadTextContent('../../../services/Network/applicationGateways/Deploy-AGW-FailedRequests-Alert.json')
    loadTextContent('../../../services/Network/applicationGateways/Deploy-AGW-ResponseStatus-Alert.json')
    loadTextContent('../../../services/Network/applicationGateways/Deploy-AGW-UnhealthyHostCount-Alert.json')
    loadTextContent('../../../services/Network/expressRoutePorts/Deploy-ERP-BitsInPerSecond-Alert.json')
    loadTextContent('../../../services/Network/expressRoutePorts/Deploy-ERP-BitsOutPerSecond-Alert.json')
    loadTextContent('../../../services/Network/expressRoutePorts/Deploy-ERP-LineProtocol-Alert.json')
    loadTextContent('../../../services/Network/expressRoutePorts/Deploy-ERP-RxLightLevelHigh-Alert.json')
    loadTextContent('../../../services/Network/expressRoutePorts/Deploy-ERP-RxLightLevelLow-Alert.json')
    loadTextContent('../../../services/Network/expressRoutePorts/Deploy-ERP-TxLightLevelHigh-Alert.json')
    loadTextContent('../../../services/Network/expressRoutePorts/Deploy-ERP-TxLightLevelLow-Alert.json')
    loadTextContent('../../../services/Network/loadBalancers/Deploy-LB-DatapathAvailability-Alert.json')
    loadTextContent('../../../services/Network/loadBalancers/Deploy-LB-GlobalBackendAvailability-Alert.json')
    loadTextContent('../../../services/Network/loadBalancers/Deploy-LB-HealthProbeStatus-Alert.json')
    loadTextContent('../../../services/Network/loadBalancers/Deploy-LB-UsedSNATPorts-Alert.json')
    loadTextContent('../../../services/Network/frontdoors/Deploy-FD-BackendHealth-Alert.json')
    loadTextContent('../../../services/Network/frontdoors/Deploy-FD-BackendRequestLatency-Alert.json')
    loadTextContent('../../../services/Cdn/profiles/Deploy-CDNP-OriginHealthPercentage-Alert.json')
    loadTextContent('../../../services/Cdn/profiles/Deploy-CDNP-OriginLatency-Alert.json')
    loadTextContent('../../../services/Cdn/profiles/Deploy-CDNP-Percentage4XX-Alert.json')
    loadTextContent('../../../services/Cdn/profiles/Deploy-CDNP-Percentage5XX-Alert.json')
    loadTextContent('../../../services/Network/trafficmanagerprofiles/Deploy-TM-EndpointHealth-Alert.json')
    loadTextContent('../../../services/Web/serverFarms/Deploy-WSF-CPUPercentage-Alert.json')
    loadTextContent('../../../services/Web/serverFarms/Deploy-WSF-DiskQueueLength-Alert.json')
    loadTextContent('../../../services/Web/serverFarms/Deploy-WSF-HttpQueueLength-Alert.json')
    loadTextContent('../../../services/Web/serverFarms/Deploy-WSF-MemoryPercentage-Alert.json')
  ]
  AzureCloud: []
  AzureChinaCloud: []
  AzureUSGovernment: []
}

// The following var contains lists of files containing Policy Set Definition (Initiative) resources to load, grouped by compatibility with Cloud.
// To get a full list of Azure clouds, use the az cli command "az cloud list --output table"
// We use loadTextContent instead of loadJsonContent as this allows us to perform string replacement operations against the imported templates.
// Use string(loadJsonContent('../file.json')) when the JSON has more than 131072 characters
var loadPolicySetDefinitions = {
  All: [
    string(loadJsonContent('../policySetDefinitions/Deploy-Connectivity-Alerts.json'))
    loadTextContent('../policySetDefinitions/Deploy-Identity-Alerts.json')
    string(loadJsonContent('../policySetDefinitions/Deploy-LandingZone-Alerts.json'))
    loadTextContent('../policySetDefinitions/Deploy-Management-Alerts.json')
    loadTextContent('../policySetDefinitions/Deploy-ServiceHealth-Alerts.json')
    loadTextContent('../policySetDefinitions/Deploy-Notification-Assets.json')
  ]
  AzureCloud: []
  AzureChinaCloud: []
  AzureUSGovernment: []
}

// The following vars are used to manipulate the imported Policy Definitions to replace deployment location values
// Needs a double replace to handle updates in both templates for All clouds, and localized templates
var processPolicyDefinitionsAll = [for content in loadPolicyDefinitions.All: replace(replace(content, templateVars.defaultDeploymentLocation, deploymentLocation), templateVars.localizedDeploymentLocation, deploymentLocation)]
var processPolicyDefinitionsAzureCloud = [for content in loadPolicyDefinitions.AzureCloud: replace(replace(content, templateVars.defaultDeploymentLocation, deploymentLocation), templateVars.localizedDeploymentLocation, deploymentLocation)]
var processPolicyDefinitionsAzureChinaCloud = [for content in loadPolicyDefinitions.AzureChinaCloud: replace(replace(content, templateVars.defaultDeploymentLocation, deploymentLocation), templateVars.localizedDeploymentLocation, deploymentLocation)]
var processPolicyDefinitionsAzureUSGovernment = [for content in loadPolicyDefinitions.AzureUSGovernment: replace(replace(content, templateVars.defaultDeploymentLocation, deploymentLocation), templateVars.localizedDeploymentLocation, deploymentLocation)]

// The following vars are used to manipulate the imported Policy Set Definitions to replace Policy Definition scope values
var processPolicySetDefinitionsAll = [for content in loadPolicySetDefinitions.All: replace(content, templateVars.scope, scope)]
var processPolicySetDefinitionsAzureCloud = [for content in loadPolicySetDefinitions.AzureCloud: replace(content, templateVars.scope, scope)]
var processPolicySetDefinitionsAzureChinaCloud = [for content in loadPolicySetDefinitions.AzureChinaCloud: replace(content, templateVars.scope, scope)]
var processPolicySetDefinitionsAzureUSGovernment = [for content in loadPolicySetDefinitions.AzureUSGovernment: replace(content, templateVars.scope, scope)]

// The following vars are used to convert the imported Policy Definitions into objects from JSON
var policyDefinitionsAll = [for content in processPolicyDefinitionsAll: json(content)]
var policyDefinitionsAzureCloud = [for content in processPolicyDefinitionsAzureCloud: json(content)]
var policyDefinitionsAzureChinaCloud = [for content in processPolicyDefinitionsAzureChinaCloud: json(content)]
var policyDefinitionsAzureUSGovernment = [for content in processPolicyDefinitionsAzureUSGovernment: json(content)]

// The following vars are used to convert the imported Policy Set Definitions into objects from JSON
var policySetDefinitionsAll = [for content in processPolicySetDefinitionsAll: json(content)]
var policySetDefinitionsAzureCloud = [for content in processPolicySetDefinitionsAzureCloud: json(content)]
var policySetDefinitionsAzureChinaCloud = [for content in processPolicySetDefinitionsAzureChinaCloud: json(content)]
var policySetDefinitionsAzureUSGovernment = [for content in processPolicySetDefinitionsAzureUSGovernment: json(content)]

// The following var is used to compile the required Policy Definitions into a single object
var policyDefinitionsByCloudType = {
  All: policyDefinitionsAll
  AzureCloud: policyDefinitionsAzureCloud
  AzureChinaCloud: policyDefinitionsAzureChinaCloud
  AzureUSGovernment: policyDefinitionsAzureUSGovernment
}

// The following var is used to compile the required Policy Definitions into a single object
var policySetDefinitionsByCloudType = {
  All: policySetDefinitionsAll
  AzureCloud: policySetDefinitionsAzureCloud
  AzureChinaCloud: policySetDefinitionsAzureChinaCloud
  AzureUSGovernment: policySetDefinitionsAzureUSGovernment
}

// The following var is used to extract the Policy Definitions into a single list for deployment
// This will contain all policy definitions classified as available for All cloud environments, and those for the current cloud environment
var policyDefinitions = concat(policyDefinitionsByCloudType.All, policyDefinitionsByCloudType[cloudEnv])

// The following var is used to extract the Policy Set Definitions into a single list for deployment
// This will contain all policy set definitions classified as available for All cloud environments, and those for the current cloud environment
var policySetDefinitions = concat(policySetDefinitionsByCloudType.All, policySetDefinitionsByCloudType[cloudEnv])

// Create the Policy Definitions as needed for the target cloud environment
resource PolicyDefinitions 'Microsoft.Authorization/policyDefinitions@2020-09-01' = [for policy in policyDefinitions: {
  name: policy.name
  properties: {
    description: policy.properties.description
    displayName: policy.properties.displayName
    metadata: policy.properties.metadata
    mode: policy.properties.mode
    parameters: policy.properties.parameters
    policyType: policy.properties.policyType
    policyRule: policy.properties.policyRule
  }
}]

// Create the Policy Definitions as needed for the target cloud environment
// Depends on Policy Definitons to ensure they exist before creating dependent Policy Set Definitions (Initiatives)
resource PolicySetDefinitions 'Microsoft.Authorization/policySetDefinitions@2020-09-01' = [for policy in policySetDefinitions: {
  dependsOn: [
    PolicyDefinitions
  ]
  name: policy.name
  properties: {
    description: policy.properties.description
    displayName: policy.properties.displayName
    metadata: policy.properties.metadata
    parameters: policy.properties.parameters
    policyType: policy.properties.policyType
    policyDefinitions: policy.properties.policyDefinitions
    policyDefinitionGroups: policy.properties.policyDefinitionGroups
  }
}]

output policyDefinitionNames array = [for policy in policyDefinitions: policy.name]
output policySetDefinitionNames array = [for policy in policySetDefinitions: policy.name]
