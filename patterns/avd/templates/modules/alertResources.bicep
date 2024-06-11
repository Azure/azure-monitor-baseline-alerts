param ActionGroupName string
param AlertDescriptionHeader string
param AlertNamePrefix string
param AMBAalertsHostPool array
param AMBAalertsStorage array
param AMBAalertsANF array
param AMBAalertsVM array
param AMBAalertsSvcHealth array
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
    name: 'lnk_VMMtrcAlrts'
    params: {
      AlertDescriptionHeader: AlertDescriptionHeader
      AlertNamePrefix: AlertNamePrefix
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

module storAccountMetric 'createAlerts.bicep' = [for i in range(0, length(StorageAccountResourceIds)): if (length(StorageAccountResourceIds) > 0) {
    name: 'lnk_StrAcctMtrcAlrts_${split(StorageAccountResourceIds[i], '/')[8]}'
    params: {
      AMBAalerts: AMBAalertsStorage
      AlertDescriptionHeader: AlertDescriptionHeader
      AlertNamePrefix: AlertNamePrefix
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

module azureNetAppFilesMetric 'createAlerts.bicep' = [for i in range(0, length(ANFVolumeResourceIds)): if (length(ANFVolumeResourceIds) > 0) {
    name: 'lnk_ANFMtrcAlrts_${split(ANFVolumeResourceIds[i], '/')[12]}'
    params: {
      AlertDescriptionHeader: AlertDescriptionHeader
      AlertNamePrefix: AlertNamePrefix
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

// If Metric Namespace contains file services ; change scopes to append default
// module to loop through each scope time as it MUST be a single Resource ID
module fileServicesMetric 'createAlerts.bicep' = [for i in range(0, length(StorageAccountResourceIds)): if (length(StorageAccountResourceIds) > 0) {
    name: 'lnk_FlSvcsMtrcAlrts_${i}'
    params: {
      AutoMitigate: AutoResolveAlert
      AlertDescriptionHeader: AlertDescriptionHeader
      AlertNamePrefix: AlertNamePrefix
      SetEnabled: SetEnabled
      Environment: Environment
      Location: Location
      MetricScope: StorageAccountResourceIds[i]
      ActionGroupId: actionGroup.id
      Tags: Tags
      AMBAalerts: AMBAalertsStorage
      LogAnalyticsWorkspaceResourceId: LogAnalyticsWorkspaceResourceId
    }
  }
]

module logAlertHostPoolQueriesSub 'createAlerts.bicep' =  {
    name: 'lnk_HPAlrts'
    params: {
      AlertDescriptionHeader: AlertDescriptionHeader
      AlertNamePrefix: AlertNamePrefix
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

module logAlertSvcHealth 'createAlerts.bicep' = {
    name: 'lnk_SvcHlthAlrts'
    params: {
      AlertDescriptionHeader: AlertDescriptionHeader
      AlertNamePrefix: AlertNamePrefix
      AMBAalerts: AMBAalertsSvcHealth
      AutoMitigate: AutoResolveAlert
      ActionGroupId: actionGroup.id
      Environment: Environment
      Location: Location
      LogAnalyticsWorkspaceResourceId: LogAnalyticsWorkspaceResourceId
      SetEnabled: SetEnabled
      Tags: Tags
      MetricScope: SubscriptionId
    }
  }



