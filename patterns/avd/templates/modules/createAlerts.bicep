param AutoMitigate bool
param AMBAalerts array
param AlertNamePrefix string
param AlertDescriptionHeader string
param ActionGroupId string
param SetEnabled bool
param Environment string
param Location string
param LogAnalyticsWorkspaceResourceId string
param Tags object
param MetricScope string


// create object, loop through each and output singular params for each alert
module metricAlerts 'createAlertsMetric.bicep' = [for Alert in AMBAalerts : if((Alert.type == 'Metric') && contains(Alert.tags, 'avd')) {
  name: 'linked_alertsMetric-${guid(Alert.name)}'
  params: {
    AutoMitigate: AutoMitigate
    Alert: Alert
    AlertNamePrefix: AlertNamePrefix
    AlertDescriptionHeader: AlertDescriptionHeader
    ActionGroupId: ActionGroupId
    SetEnabled: SetEnabled
    Environment: Environment
    Location: Location
    Tags: Tags
    MetricScope: MetricScope
  }
}]

module logqueryAlerts 'createAlertsLogQuery.bicep' = [for Alert in AMBAalerts : if((Alert.type == 'Log') && contains(Alert.tags, 'avd')) {
  name: 'linked_alertsLogQuery-${guid(Alert.name)}'
  params: {
    AutoMitigate: AutoMitigate
    Alert: Alert
    AlertNamePrefix: AlertNamePrefix
    AlertDescriptionHeader: AlertDescriptionHeader
    ActionGroupId: ActionGroupId
    SetEnabled: SetEnabled
    Environment: Environment
    Location: Location
    LogAnalyticsWorkspaceResourceId: LogAnalyticsWorkspaceResourceId
    Tags: Tags
  }
}]


