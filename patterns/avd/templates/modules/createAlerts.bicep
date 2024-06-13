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

// var AlertDescription = [for Alert in AMBAalerts : (Alert.references != null) ? '${Alert.description}\nResources:\n${join(Alert.references, '\n')}' : '${Alert.description}']

resource metricAlerts 'Microsoft.Insights/metricAlerts@2018-03-01' = [for Alert in AMBAalerts : if(Alert.type == 'Metric' && !contains(Alert.name, 'Blob') && !contains(Alert.name, 'Queue')){
  name: contains(Alert.name, '/') ? '${AlertNamePrefix}-${replace(Alert.name, '/', ' per ')}-${Environment}' : contains(Alert.name, '%') ? '${AlertNamePrefix}-${replace(Alert.name, '%', ' percent ')}-${Environment}': '${AlertNamePrefix}-${Alert.name}-${Environment}'
  tags: contains(Tags, 'Microsoft.Insights/metricAlerts') ? Tags['Microsoft.Insights/metricAlerts'] : {}
  location: 'global'
  properties: {
    description: '${AlertDescriptionHeader}${Alert.description}'
    severity: Alert.properties.severity
    enabled: SetEnabled
    scopes: [MetricScope]
    evaluationFrequency: Alert.properties.evaluationFrequency
    windowSize: Alert.properties.windowSize
    criteria: {
      allOf: [
        {
          threshold: Alert.properties.threshold
          name: 'Metric1'
          metricNamespace: Alert.properties.metricNamespace
          metricName: Alert.properties.metricName
          operator: Alert.properties.operator
          timeAggregation: Alert.properties.timeAggregation
          criterionType: Alert.properties.criterionType
        }
      ]
      'odata.type': 'Microsoft.Azure.Monitor.MultipleResourceMultipleMetricCriteria'
    }
    autoMitigate: AutoMitigate
    targetResourceType: Alert.properties.metricNamespace
    targetResourceRegion: Location
    actions: [
      {
        actionGroupId: ActionGroupId
        webHookProperties: {}
      }
    ]
  }
}]


resource logqueryAlerts 'Microsoft.Insights/scheduledQueryRules@2022-08-01-preview' = [for Alert in AMBAalerts : if(Alert.type == 'Log') {
  name: contains(Alert.name, '/') ? '${AlertNamePrefix}-${replace(Alert.name, '/', ' per ')}-${Environment}' : '${AlertNamePrefix}-${Alert.name}-${Environment}'
  location: Location
  tags: contains(Tags, 'Microsoft.Insights/scheduledQueryRules') ? Tags['Microsoft.Insights/scheduledQueryRules'] : {}
  properties: {
    actions: {
      actionGroups: [
        ActionGroupId
      ]
    }
    autoMitigate: AutoMitigate
    criteria: {
      allOf: [
        {
          dimensions: Alert.properties.dimensions
          failingPeriods: Alert.properties.failingPeriods
          metricName: Alert.name
          metricMeasureColumn: contains(Alert.properties, 'metricMeasureColumn') ? Alert.properties.metricMeasureColumn : null
          resourceIdColumn: contains(Alert.properties, 'resourceIdColumn') ? Alert.properties.resourceIdColumn : null
          operator: Alert.properties.operator
          query: Alert.properties.query
          threshold: Alert.properties.threshold
          timeAggregation: Alert.properties.timeAggregation
        }
      ]
    }
    description: '${AlertDescriptionHeader}${Alert.description}' //   \n${join(Alert.references.url, '\n')}'
    enabled: SetEnabled
    evaluationFrequency: Alert.properties.evaluationFrequency
    ruleResolveConfiguration: {
      autoResolved: Alert.properties.autoResolve
      timeToResolve: Alert.properties.autoResolveTime
    }
    scopes: [LogAnalyticsWorkspaceResourceId]
    severity: Alert.properties.severity
    targetResourceTypes: [
      'microsoft.operationalinsights/workspaces'
    ]
    windowSize: Alert.properties.windowSize
  }
}]
