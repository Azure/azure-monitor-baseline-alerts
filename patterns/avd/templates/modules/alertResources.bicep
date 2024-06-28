param ActionGroupName string
param AlertDescriptionHeader string
param AlertNamePrefix string
param AMBAalertsHostPool array
param AMBAalertsStorage array
param AMBAalertsANF array
param AMBAalertsVM array
//param AMBAalertsSvcHealth array
param AutoResolveAlert bool
param ANFVolumeResourceIds array
param DistributionGroup string
param Environment string
param Location string
param LogAnalyticsWorkspaceResourceId string
param SetEnabled bool
param StorageAccountResourceIds array
param Tags object

var SubscriptionId = subscription().subscriptionId

resource actionGroup 'Microsoft.Insights/actionGroups@2023-01-01' = {
  name: ActionGroupName
  location: Location
  tags: contains(Tags, 'Microsoft.Insights/actionGroups') ? Tags['Microsoft.Insights/actionGroups'] : {}
  properties: {
    groupShortName: 'AVDMetrics'
    enabled: true
    emailReceivers: [
      {
        emailAddress: DistributionGroup
        name: 'AVD Operations Admin(s)'
        useCommonAlertSchema: true
      }
    ]
  }
}

// If all resources in same RG, loop through Host Pools
module metricAlertsVmsSub 'createAlerts.bicep' = {
    name: 'lnk_AlertsMetricVM'
    params: {
      AlertDescriptionHeader: AlertDescriptionHeader
      AlertNamePrefix: '${AlertNamePrefix}-VM'
      AMBAalerts: AMBAalertsVM
      LogAnalyticsWorkspaceResourceId: LogAnalyticsWorkspaceResourceId
      Environment: Environment
      MetricScope: subscription().id
      SetEnabled: SetEnabled
      AutoMitigate: AutoResolveAlert
      Location: Location
      ActionGroupId: actionGroup.id
      Tags: Tags
    }
  }

module azureNetAppFilesMetric 'createAlerts.bicep' = [for i in range(0, length(ANFVolumeResourceIds)): if (length(ANFVolumeResourceIds) > 0) {
    name: 'lnk_AlertsMetricANF_${split(ANFVolumeResourceIds[i], '/')[12]}'
    params: {
      AlertDescriptionHeader: AlertDescriptionHeader
      AlertNamePrefix: '${AlertNamePrefix}-ANF'
      AutoMitigate: AutoResolveAlert
      SetEnabled: SetEnabled
      Environment: Environment
      Location: Location
      MetricScope: ANFVolumeResourceIds[i]
      ActionGroupId: actionGroup.id
      Tags: Tags
      AMBAalerts: AMBAalertsANF
      LogAnalyticsWorkspaceResourceId: LogAnalyticsWorkspaceResourceId
    }
  }
]

module storAccountMetric 'createAlerts.bicep' = [for i in range(0, length(StorageAccountResourceIds)): if (length(StorageAccountResourceIds) > 0) {
  name: 'lnk_AlertsMetricStrAcct_${split(StorageAccountResourceIds[i], '/')[8]}'
  params: {
    AMBAalerts: AMBAalertsStorage
    AlertDescriptionHeader: AlertDescriptionHeader
    AlertNamePrefix: '${AlertNamePrefix}-storage-${split(StorageAccountResourceIds[i], '/')[8]}'
    LogAnalyticsWorkspaceResourceId: LogAnalyticsWorkspaceResourceId
    Environment: Environment
    MetricScope: StorageAccountResourceIds[i]
    AutoMitigate: AutoResolveAlert
    SetEnabled: SetEnabled
    Location: Location
    ActionGroupId: actionGroup.id
    Tags: Tags
  }
}
]

module logAlertHostPoolQueriesSub 'createAlerts.bicep' =  {
    name: 'lnk_AlertsLogHostPool'
    params: {
      AlertDescriptionHeader: AlertDescriptionHeader
      AlertNamePrefix: '${AlertNamePrefix}-HostPool'
      AMBAalerts: AMBAalertsHostPool
      AutoMitigate: AutoResolveAlert
      ActionGroupId: actionGroup.id
      Environment: Environment
      Location: Location
      LogAnalyticsWorkspaceResourceId: LogAnalyticsWorkspaceResourceId
      Tags: Tags
      SetEnabled: SetEnabled
      MetricScope: subscription().id
    }
  }

/* module logAlertSvcHealth 'createAlerts.bicep' = {
    name: 'lnk_AlertsSvcHlth'
    params: {
      AlertDescriptionHeader: AlertDescriptionHeader
      AlertNamePrefix: '${AlertNamePrefix}-SvcHealth'
      AMBAalerts: AMBAalertsSvcHealth
      AutoMitigate: AutoResolveAlert
      ActionGroupId: actionGroup.id
      Environment: Environment
      Location: Location
      LogAlertType: 'Service'
      LogAnalyticsWorkspaceResourceId: LogAnalyticsWorkspaceResourceId
      SetEnabled: SetEnabled
      Tags: Tags
      MetricScope: SubscriptionId
    }
  } */



