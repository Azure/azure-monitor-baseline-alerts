@description('Name of the alert')
@minLength(1)
param alertName string

@description('Description of alert')
param alertDescription string = 'User Profile Service Disabled. Determine why service was disabled and re-enable / start the FSLogix service. Regarding xHostPoolNamex.'

@description('Specifies whether the alert is enabled')
param isEnabled bool = true

@description('Specifies whether to check linked storage and fail creation if the storage was not found')
param checkWorkspaceAlertsStorageConfigured bool = false

@description('Full Resource ID of the resource emitting the metric that will be used for the comparison. For example /subscriptions/00000000-0000-0000-0000-0000-00000000/resourceGroups/ResourceGroupName/providers/Microsoft.compute/virtualMachines/VM_xyz')
@minLength(1)
param resourceId string

@description('Mute actions for the chosen period of time (in ISO 8601 duration format) after the alert is fired.')
@allowed([
  'PT1M'
  'PT5M'
  'PT15M'
  'PT30M'
  'PT1H'
  'PT6H'
  'PT12H'
  'PT24H'
])
param muteActionsDuration string

@description('Severity of alert {0,1,2,3,4}')
@allowed([
  0
  1
  2
  3
  4
])
param alertSeverity int = 1

@description('Specifies whether the alert will automatically resolve')
param autoMitigate bool = true

@description('Name of the metric used in the comparison to activate the alert.')
@minLength(1)
param query string = 'Event | where EventLog == "Microsoft-FSLogix-Apps/Admin" | where EventLevelName == "Warning" | where EventID == 60 | parse _ResourceId with "/subscriptions/" subscription "/resourcegroups/" ResourceGroup "/providers/microsoft.compute/virtualmachines/" ComputerName | extend ComputerName=tolower(ComputerName) | project ComputerName, RenderedDescription, subscription, ResourceGroup, TimeGenerated | join kind = leftouter (WVDAgentHealthStatus | where _ResourceId contains "xHostPoolNamex" | parse _ResourceId with "/subscriptions/" subscriptionAgentHealth "/resourcegroups/" ResourceGroupAgentHealth "/providers/microsoft.desktopvirtualization/hostpools/" HostPool | parse SessionHostResourceId with "/subscriptions/" VMsubscription "/resourceGroups/" VMresourceGroup "/providers/Microsoft.Compute/virtualMachines/" ComputerName | extend ComputerName=tolower(ComputerName) | summarize arg_max(TimeGenerated,*) by ComputerName | project VMresourceGroup, ComputerName, HostPool ) on ComputerName'

@description('Name of the measure column used in the alert evaluation.')
param metricMeasureColumn string = ''

@description('Name of the resource ID column used in the alert targeting the alerts.')
param resourceIdColumn string = ''

@description('Operator comparing the current value with the threshold value.')
@allowed([
  'Equals'
  'GreaterThan'
  'GreaterThanOrEqual'
  'LessThan'
  'LessThanOrEqual'
])
param operator string = 'GreaterThanOrEqual'

@description('The threshold value at which the alert is activated.')
param threshold int = 1

@description('The number of periods to check in the alert evaluation.')
param numberOfEvaluationPeriods int = 1

@description('The number of unhealthy periods to alert on (must be lower or equal to numberOfEvaluationPeriods).')
param minFailingPeriodsToAlert int = 1

@description('How the data that is collected should be combined over time.')
@allowed([
  'Average'
  'Minimum'
  'Maximum'
  'Total'
  'Count'
])
param timeAggregation string = 'Count'

@description('Period of time used to monitor alert activity based on the threshold. Must be between one minute and one day. ISO 8601 duration format.')
@allowed([
  'PT1M'
  'PT5M'
  'PT10M'
  'PT15M'
  'PT30M'
  'PT45M'
  'PT1H'
  'PT2H'
  'PT3H'
  'PT4H'
  'PT5H'
  'PT6H'
  'P1D'
  'P2D'
])
param windowSize string = 'P1D'

@description('how often the metric alert is evaluated represented in ISO 8601 duration format')
@allowed([
  'PT1M'
  'PT5M'
  'PT10M'
  'PT15M'
  'PT30M'
  'PT45M'
  'PT1H'
  'PT2H'
  'PT3H'
  'PT4H'
  'PT5H'
  'PT6H'
  'P1D'
])
param evaluationFrequency string = 'PT5M'

@description('"The current date and time using the utcNow function. Used for deployment name uniqueness')
param currentDateTimeUtcNow string = utcNow()

@description('The customer usage identifier used for telemetry purposes. The default value of False enables telemetry. The value of True disables telemetry.')
@allowed([
  'Yes'
  'No'
])
param telemetryOptOut string = 'No'

resource alert 'Microsoft.Insights/scheduledQueryRules@2021-08-01' = {
  name: alertName
  location: resourceGroup().location
  tags: {
    _deployed_by_amba: 'true'
  }
  properties: {
    description: alertDescription
    severity: alertSeverity
    enabled: isEnabled
    scopes: [
      resourceId
    ]
    evaluationFrequency: evaluationFrequency
    windowSize: windowSize
    criteria: {
      allOf: [
        {
          query: query
          metricMeasureColumn: metricMeasureColumn
          resourceIdColumn: resourceIdColumn
          dimensions: [
            {
              name: 'ComputerName'
              operator: 'Include'
              values: ['*']
            }
            {
              name: 'RenderedDescription'
              operator: 'Include'
              values: ['*']
            }
            {
              name: 'VMresourceGroup'
              operator: 'Include'
              values: ['*']
            }
            {
              name: 'HostPool'
              operator: 'Include'
              values: ['*']
            }]
          operator: operator
          threshold: threshold
          timeAggregation: timeAggregation
          failingPeriods: {
            numberOfEvaluationPeriods: numberOfEvaluationPeriods
            minFailingPeriodsToAlert: minFailingPeriodsToAlert
          }
        }
      ]
    }
    muteActionsDuration: muteActionsDuration
    autoMitigate: autoMitigate
    checkWorkspaceAlertsStorageConfigured: checkWorkspaceAlertsStorageConfigured
  }
}

var ambaTelemetryPidName = 'pid-8bb7cf8a-bcf7-4264-abcb-703ace2fc84d-${uniqueString(resourceGroup().id, alertName, currentDateTimeUtcNow)}'
resource ambaTelemetryPid 'Microsoft.Resources/deployments@2023-07-01' =  if (telemetryOptOut == 'No') {
  name: ambaTelemetryPidName
  tags: {
    _deployed_by_amba: 'true'
  }
  properties: {
    mode: 'Incremental'
    template: {
      '$schema': 'https://schema.management.azure.com/schemas/2015-01-01/deploymentTemplate.json#'
      contentVersion: '1.0.0.0'
      resources: []
    }
  }
}
