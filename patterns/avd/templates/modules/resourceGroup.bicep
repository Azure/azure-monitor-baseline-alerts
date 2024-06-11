targetScope = 'subscription'

param Location string
param Name string
param ResourceGroupCreate bool
param Tags object

resource resourceGroupCreate 'Microsoft.Resources/resourceGroups@2019-05-01' = if (ResourceGroupCreate) {
  name: Name
  location: Location
  tags: Tags
}


resource resourceGroupAVDMetricsExisting 'Microsoft.Resources/resourceGroups@2022-09-01' existing = if(!ResourceGroupCreate) {
  name: Name
}

output resourceGroupIdAlerts string = ResourceGroupCreate ? resourceGroupCreate.id : resourceGroupAVDMetricsExisting.id
output resourceGroupNameAlerts string = ResourceGroupCreate ? resourceGroupCreate.name : resourceGroupAVDMetricsExisting.name
