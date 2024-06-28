param AutoMitigate bool
param AMBAalerts array
param AlertNamePrefix string
param AlertDescriptionHeader string
param ActionGroupId string
param SetEnabled bool
param Environment string
param Location string
param LogAlertType string = ''
param LogAnalyticsWorkspaceResourceId string
param Tags object
param MetricScope string



// create object, loop through each and output singular params for each alert
module metricAlerts 'createAlertsMetric.bicep' = [for Alert in AMBAalerts : if(Alert.type == 'Metric') {
  name: 'linked_alertsMetric-${string(Alert.guid)}'
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

module logqueryAlerts 'createAlertsLogQuery.bicep' = [for Alert in AMBAalerts : if((Alert.type == 'Log') && (LogAlertType != 'Service')) {
  name: 'linked_alertsLogQuery-${string(Alert.guid)}'
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

module logqueryAlertsSvcHlth 'createAlertsLogQuery.bicep' = [for Alert in AMBAalerts : if((Alert.type == 'Log') && (LogAlertType == 'Service')) {
  name: 'linked_alertsLogQuerySvcHlth-${guid(Alert.description, subscription().id)}'
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
