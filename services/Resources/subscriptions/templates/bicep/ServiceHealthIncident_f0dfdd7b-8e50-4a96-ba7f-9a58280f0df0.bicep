@description('Unique name (within the Resource Group) for the Activity log alert.')
@minLength(1)
param alertName string

@description('Description of alert')
param alertDescription string = 'Service Health Incident Alert'

@description('Indicates whether or not the alert is enabled.')
param isEnabled bool = true

@description('"The current date and time using the utcNow function. Used for deployment name uniqueness')
param currentDateTimeUtcNow string = utcNow()

@description('The customer usage identifier used for telemetry purposes. The default value of False enables telemetry. The value of True disables telemetry.')
@allowed([
  'Yes'
  'No'
])
param telemetryOptOut string = 'No'

@description('Tags to apply to the alert')
param tags object = {
  _deployed_by_amba: 'true'
}

resource symbolicname 'Microsoft.Insights/activityLogAlerts@2023-01-01-preview' = {
  name: alertName
  location: 'Global'
  tags: tags
  properties: {
    description: alertDescription
    scopes: [
      subscription().id
    ]
    enabled: isEnabled
    condition: {
      allOf: [
        {
          field: 'category'
          equals: 'ServiceHealth'
        }
        {
          field: 'properties.incidentType'
          equals: 'Incident'
        }
      ]
    }
  }
}

var ambaTelemetryPidName = 'pid-8bb7cf8a-bcf7-4264-abcb-703ace2fc84d-${uniqueString(resourceGroup().id, alertName, currentDateTimeUtcNow)}'
resource ambaTelemetryPid 'Microsoft.Resources/deployments@2023-07-01' =  if (telemetryOptOut == 'No') {
  name: ambaTelemetryPidName
  tags: tags
  properties: {
    mode: 'Incremental'
    template: {
      '$schema': 'https://schema.management.azure.com/schemas/2015-01-01/deploymentTemplate.json#'
      contentVersion: '1.0.0.0'
      resources: []
    }
  }
}
