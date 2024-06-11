using './deploy.bicep'

param SetEnabled = false
param optoutTelemetry = false
param AlertNamePrefix = 'AVD'
param AutoResolveAlert = true
param DistributionGroup = 'jcore@microsoft.com'
param Environment = 't'
param LogAnalyticsWorkspaceResourceId = '/subscriptions/8a0ecebc-0e1d-4e8f-8cb8-8a92f49455b9/resourcegroups/rg-eastus2-avdlab-manage/providers/microsoft.operationalinsights/workspaces/law-eastus2-avdlab'
param ResourceGroupName = 'rg-test-alerts'
param ResourceGroupStatus = 'New'
param StorageAccountResourceIds = [
  '/subscriptions/8a0ecebc-0e1d-4e8f-8cb8-8a92f49455b9/resourceGroups/rg-eus2-AVDLab-Storage/providers/Microsoft.Storage/storageAccounts/stfslcfpet5'
  '/subscriptions/8a0ecebc-0e1d-4e8f-8cb8-8a92f49455b9/resourceGroups/rg-eus2-AVDLab-Storage/providers/Microsoft.Storage/storageAccounts/stgcorefamily06'
]
param ANFVolumeResourceIds = [
  '/subscriptions/8a0ecebc-0e1d-4e8f-8cb8-8a92f49455b9/resourceGroups/rg-eastus2-AVDLab-Servers/providers/Microsoft.NetApp/netAppAccounts/anf-eastus2-avdlab/capacityPools/avd-profiles-std/volumes/avdeus2'
]
param Tags = {}

