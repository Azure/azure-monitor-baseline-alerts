targetScope = 'subscription'


@description('Determine if you would like to enable all the alerts after deployment.')
param SetEnabled bool = false

@description('Telemetry Opt-Out') // Change this to true to opt out of Microsoft Telemetry
param optoutTelemetry bool = false

@description('Alert Name Prefix (Dash will be added after prefix for you.)')
param AlertNamePrefix string = 'AVD'

@description('Determine if you would like to set all deployed alerts to auto-resolve.')
param AutoResolveAlert bool = true

@description('The Distribution Group that will receive email alerts for AVD.')
param DistributionGroup string

@allowed([
  'd'
  'p'
  't'
])
@description('The environment is which these resources will be deployed, i.e. Test, Production, Development.')
param Environment string = 't'

@description('Azure Region for Resources.')
param Location string = deployment().location

@description('The Resource ID for the Log Analytics Workspace.')
param LogAnalyticsWorkspaceResourceId string

@description('Resource Group to deploy the Alerts Solution in.')
param ResourceGroupName string

@description('Flag to determine if a new resource group needs to be created for Alert resources.')
@allowed([
  'New'
  'Existing'
])
param ResourceGroupStatus string

@description('The Resource IDs for the Azure Files Storage Accounts used for FSLogix profile storage.')
param StorageAccountResourceIds array = []

@description('ISO 8601 timestamp used for the deployment names and the Automation runbook schedule.')
param time string = utcNow()

@description('The Resource IDs for the Azure NetApp Volumes used for FSLogix profile storage.')
param ANFVolumeResourceIds array = []

param Tags object = {}

// Load all AMBA alerts (Array of Objects)
var AMBAalertsHostPool = loadYamlContent('../../../services/DesktopVirtualization/hostPools/alerts.yaml')
var AMBAalertsStorage = loadYamlContent('../../../services/Storage/storageAccounts/alerts.yaml')
var AMBAalertsANF = loadYamlContent('../../../services/NetApp/netAppAccounts/alerts.yaml')
var AMBAalertsVM = loadYamlContent('../../../services/Compute/virtualMachines/alerts.yaml')
var AMBAalertsSvcHealth = loadYamlContent('../../../services/Resources/subscriptions/alerts.yaml')

var AlertsStorage = [for alert in AMBAalertsStorage: contains(alert.tags, 'avd') ? alert : null]

var ActionGroupName = 'ag-avdmetrics-${Environment}-${Location}'
var AlertDescriptionHeader = 'Automated AVD Alert Deployment Solution (v3.0.0)\n' // DESCRIPTION HEADER AND VERSION <-----------------------------
var ResourceGroupCreate = ResourceGroupStatus == 'New' ? true : false

// Filter out VM Alerts that can only be scoped to the VM object (Deployment scope is to Subscription)
var VMScopeOnly = ['Network In Total', 'Network Out Total', 'Inbound Flows', 'Outbound Flows']
var VMMetricAlerts = filter(AMBAalertsVM, (x) => !contains(VMScopeOnly, x.name))
var VMScopeAlerts = filter(AMBAalertsVM, (x) => contains(VMScopeOnly, x.name))  //placeholder for future use (scope to VM)


// var UsrManagedIdentityName = 'id-ds-avdAlerts-Deployment'

var cuaid = 'b8b4a533-1bb2-402f-bbd9-3055d00d885a'
var PidcuaAvdPatternDeploymentName = take(
  'pid-${cuaid}-${uniqueString(Location, subscription().displayName, time)}',
  64
)

// =========== //
// Deployments //
// =========== //
module deploymentNames_pidCuaDeployment 'modules/pid_cuaid.bicep' =
  if (!optoutTelemetry) {
    name: PidcuaAvdPatternDeploymentName
    params: {}
  }

// AVD Shared Services Resource Group
module resourceGroupAVDAlerts 'modules/resourceGroup.bicep' = {
  name: 'linked_RG_AVDMetrics'
  params: {
    Location: Location
    Name: ResourceGroupName
    ResourceGroupCreate: ResourceGroupCreate
    Tags: contains(Tags, 'Microsoft.Resources/resourceGroups') ? Tags['Microsoft.Resources/resourceGroups'] : {}
  }
}

module metricsResources 'modules/alertResources.bicep' = {
  name: 'linked_MonitoringResourcesDeployment'
  scope: resourceGroup(ResourceGroupName)
  params: {
    AlertNamePrefix: AlertNamePrefix
    AlertDescriptionHeader: AlertDescriptionHeader
    AMBAalertsHostPool: AMBAalertsHostPool
    AMBAalertsStorage: AlertsStorage
    AMBAalertsANF: AMBAalertsANF
    AMBAalertsVM: VMMetricAlerts
    AMBAalertsSvcHealth: AMBAalertsSvcHealth
    AutoResolveAlert: AutoResolveAlert
    DistributionGroup: DistributionGroup
    Environment: Environment
    Location: Location
    LogAnalyticsWorkspaceResourceId: LogAnalyticsWorkspaceResourceId
    SetEnabled: SetEnabled
    StorageAccountResourceIds: StorageAccountResourceIds
    ActionGroupName: ActionGroupName
    ANFVolumeResourceIds: ANFVolumeResourceIds
    Tags: Tags
  }
  dependsOn: [
    resourceGroupAVDAlerts
  ]
}
