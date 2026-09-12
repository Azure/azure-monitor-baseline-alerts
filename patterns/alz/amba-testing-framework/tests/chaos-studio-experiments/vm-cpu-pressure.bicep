@description('Name of Chaos Experiment')
param experimentName string

@description('Location of deployement (identical to VM target and Chaos Studio)')
param location string


@description('Name of Chaos Studio Target registered (should be already onboarded)')
param chaosTargetName string

@description('Duration of the experiment (ex: PT3M = 3 minutes)')
param experimentDuration string = 'PT3M'

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
            id: chaosTargetName
          }
        ]
      }
    ]
    steps: [
      {
        name: 'cpu-stress-step'
        branches: [
          {
            name: 'cpu-stress-branch'
            actions: [
              {
                name: 'cpu-pressure-action'
                type: 'continuous'
                duration: experimentDuration
                selectorId: 'selector-1'
                parameters: [
                  {
                    key: 'pressureLevel'
                    value: '95'
                  }
                  {
                    key: 'pressureDuration'
                    value: experimentDuration
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
