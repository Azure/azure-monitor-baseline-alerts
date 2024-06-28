param AutoMitigate bool
param Alert object
param AlertNamePrefix string
param AlertDescriptionHeader string
param ActionGroupId string
param SetEnabled bool
param Environment string
param Location string
param Tags object
param LogAnalyticsWorkspaceResourceId string

// Combine Alert References into Description (May have multiple references or even none)
var AlertReferences = [for ref in Alert.references: '${ref.name} - ${ref.url}']
var AlertReferencesNew = AlertReferences != null ? join(AlertReferences, '\n') : null
var Description = AlertReferencesNew != null ?'${AlertDescriptionHeader}${Alert.description}\nResources: \n${AlertReferencesNew}' : '${AlertDescriptionHeader}${Alert.description}'

// replace % with percent, and / with per or name is invalid
var Name = contains(Alert.name, '/') ? '${AlertNamePrefix}-${replace(Alert.name, '/', ' per ')}-${Environment}' : contains(Alert.name, '%') ? '${AlertNamePrefix}-${replace(Alert.name, '%', ' percent ')}-${Environment}': '${AlertNamePrefix}-${Alert.name}-${Environment}'

resource logqueryAlerts2 'Microsoft.Insights/scheduledQueryRules@2022-08-01-preview' = {
  name: Name
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
    description: Description
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
}
