@description('Name of the Chaos Experiment')
param experimentName string = 'memory-pressure-experiment'

@description('Location of the experiment')
param location string = resourceGroup().location

@description('Target Virtual Machine Resource ID')
param targetVmResourceId string

resource experiment 'Microsoft.Chaos/experiments@2021-09-15-preview' = {
  name: experimentName
  location: location
  properties: {
    selectors: [
      {
        type: 'List'
        id: 'selector-1'
        targets: [
          {
            type: 'ChaosTarget'
            id: targetVmResourceId
          }
        ]
      }
    ]
    steps: [
      {
        name: 'step-memory-pressure'
        branches: [
          {
            name: 'branch-memory'
            actions: [
              {
                name: 'memory-pressure-action'
                type: 'continuous'
                duration: 'PT3M'
                selectorId: 'selector-1'
                parameters: [
                  {
                    key: 'pressureLevel'
                    value: '90'
                  }
                  {
                    key: 'pressureDuration'
                    value: 'PT3M'
                  }
                ]
              }
            ]
          }
        ]
      }
    ]
  }
}
