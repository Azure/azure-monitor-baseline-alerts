param AutoMitigate bool
param Alert object
param AlertNamePrefix string
param AlertDescriptionHeader string
param ActionGroupId string
param SetEnabled bool
param Environment string
param Location string
param Tags object
param MetricScope string

// Combine Alert References into Description (May have multiple references or even none)
var AlertReferences = [for ref in Alert.references: '${ref.name} - ${ref.url}']
var AlertReferencesNew = join(AlertReferences, '\n')
var Description = '${AlertDescriptionHeader}${Alert.description}\nResources:\n${AlertReferencesNew}'

// replace % with percent, and / with per or name is invalid
var Name = contains(Alert.name, '/') ? '${AlertNamePrefix}-${replace(Alert.name, '/', ' per ')}-${Environment}' : contains(Alert.name, '%') ? '${AlertNamePrefix}-${replace(Alert.name, '%', ' percent ')}-${Environment}': '${AlertNamePrefix}-${Alert.name}-${Environment}'

resource metricAlerts 'Microsoft.Insights/metricAlerts@2018-03-01' = {
  name: Name
  tags: contains(Tags, 'Microsoft.Insights/metricAlerts') ? Tags['Microsoft.Insights/metricAlerts'] : {}
  location: 'global'
  properties: {
    description: Description
    severity: Alert.properties.severity
    enabled: SetEnabled
    scopes: Alert.properties.metricNamespace == 'Microsoft.Storage/storageAccounts/fileServices' ? ['${MetricScope}/fileServices/default'] : [MetricScope]
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
}
