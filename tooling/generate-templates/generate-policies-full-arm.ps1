<#
    .SYNOPSIS
    This script generates policy templates based on YAML files containing alert configurations.

    .DESCRIPTION
    The script processes each YAML file in the specified directory and generates policy templates based on the alert configurations defined in the YAML files. It creates policy templates in the specified output directory.

    .PARAMETER None
    This script does not take any parameters.

    .NOTES
    Requires yq to be installed. yq is a lightweight and portable command-line YAML processor. It can be downloaded from https://github.com/mikefarah/yq

    .EXAMPLE
    .\generate-policies-full-arm.ps1

    .LINK
    https://github.com/Azure/azure-monitor-baseline-alerts
#>

begin {
    # Get all yaml files in services directory
    $alertsYaml = Get-ChildItem -Path ../../services/*.yaml -Recurse | Select-Object FullName
}
process {
    # Process each yaml file in parallel
    $alertsYaml | ForEach-Object -Parallel {
        Write-Output "Processing $($_.FullName)"
        # Convert yaml to json
        $alertJson = yq e -o=json $_.FullName
        $alertJsonObject = $alertJson | ConvertFrom-Json

        # Process each alert in the yaml file
        foreach ($alert in $alertJsonObject) {
            $policyPathName = $_.FullName -replace "alerts.yaml", ""
            $policyFileName = $alert.name -replace "[^a-zA-Z0-9-]", ""
            $policyDirectory = "$($policyPathName)templates\policy-arm"
            # Generate policy template based on the alert configuration
            If ($alert.type -eq "Metric") {
                if ($alert.type -eq "Metric" -and $alert.properties.criterionType -eq "StaticThresholdCriterion") {
                    $alertTemplate = Get-Content ".\policy\metric-static-full-arm.json"
                }
                if ($alert.type -eq "Metric" -and $alert.properties.criterionType -eq "DynamicThresholdCriterion") {
                    $alertTemplate = Get-Content ".\policy\metric-dynamic-full-arm.json"
                }
                $alertTemplate = $alertTemplate -replace "##TELEMETRY_PID##", 'pid-8bb7cf8a-bcf7-4264-abcb-703ace2fc84d'
                $alertTemplate = $alertTemplate -replace "##POLICY_NAME##", $alert.guid
                if ($alert.deployments.name -ne $null) {
                    $alertTemplate = $alertTemplate -replace "##POLICY_DISPLAY_NAME##", $alert.deployments.name
                    $alertTemplate = $alertTemplate -replace "##POLICY_DESCRIPTION##", "Policy to Audit/$($alert.deployments.name)"
                }
                if ($alert.deployments.name -eq $null) {
                    $serviceName = $alert.properties.metricNamespace -replace "Microsoft.", ""
                    $serviceName = $serviceName -replace "[/]", " "
                    $alertTemplate = $alertTemplate -replace "##POLICY_DISPLAY_NAME##", "Deploy $($serviceName) $($alert.properties.metricName) Alert"
                    $alertTemplate = $alertTemplate -replace "##POLICY_DESCRIPTION##", "Policy to Audit/Deploy $($serviceName) $($alert.properties.metricName) Alert"
                }
                if ($alert.PSObject.Properties.Name -contains "kind") {
                    $kindString = [Environment]::NewLine + '              ' + '{' +
                                  [Environment]::NewLine + '              ' + '  "field": "kind",' +
                                  [Environment]::NewLine + '              ' + '  "in": ['
                    foreach ($kind in $alert.kind) {
                        $kindString += '"' + $kind + '",'
                    }
                    $kindString = $kindString.TrimEnd(',') + ']' + [Environment]::NewLine+ '              },'
                    $alertTemplate = $alertTemplate -replace "##POLICY_KIND##", $kindString
                } else {
                    $alertTemplate = $alertTemplate -replace "##POLICY_KIND##", ""
                }
                if ($alert.PSObject.Properties.Name -contains "unsupportedSKU") {
                    $unsupportedSKUString = [Environment]::NewLine + '              ' + '{' +
                                  [Environment]::NewLine + '              ' + '  "field": "' + $alert.properties.metricNamespace + '/sku",' +
                                  [Environment]::NewLine + '              ' + '  "notIn": ['
                    foreach ($unsupportedSKU in $alert.unsupportedSKU) {
                        $unsupportedSKUString += '"' + $unsupportedSKU + '",'
                    }
                    $unsupportedSKUString = $unsupportedSKUString.TrimEnd(',') + ']' + [Environment]::NewLine+ '              },'
                    $alertTemplate = $alertTemplate -replace "##POLICY_UNSUPPORTEDSKU##", $unsupportedSKUString
                } else {
                    $alertTemplate = $alertTemplate -replace "##POLICY_UNSUPPORTEDSKU##", ""
                }
                if ($alert.PSObject.Properties.Name -contains "tier") {
                    $tierString = [Environment]::NewLine + '              ' + '{' +
                                  [Environment]::NewLine + '              ' + '  "field": "' + $alert.properties.metricNamespace + '/sku.tier",' +
                                  [Environment]::NewLine + '              ' + '  "in": ['
                    foreach ($tier in $alert.tier) {
                        $tierString += '"' + $tier + '",'
                    }
                    $tierString = $tierString.TrimEnd(',') + ']' + [Environment]::NewLine+ '              },'
                    $alertTemplate = $alertTemplate -replace "##POLICY_TIER##", $tierString
                } else {
                    $alertTemplate = $alertTemplate -replace "##POLICY_TIER##", ""
                }
                if ($alert.PSObject.Properties.Name -contains "gatewayType") {
                    $gatewayTypeString = [Environment]::NewLine + '              ' + '{' +
                                  [Environment]::NewLine + '              ' + '  "field": "' + $alert.properties.metricNamespace + '/gatewayType",' +
                                  [Environment]::NewLine + '              ' + '  "in": ['
                    foreach ($gatewayType in $alert.gatewayType) {
                        $gatewayTypeString += '"' + $gatewayType + '",'
                    }
                    $gatewayTypeString = $gatewayTypeString.TrimEnd(',') + ']' + [Environment]::NewLine+ '              },'
                    $alertTemplate = $alertTemplate -replace "##POLICY_GWTYPE##", $gatewayTypeString
                } else {
                    $alertTemplate = $alertTemplate -replace "##POLICY_GWTYPE##", ""
                }
                if ($alert.properties.dimensions -ne $null) {
                  $dimensionRuleString = $dimensionRuleString + [Environment]::NewLine + '                  ' + '{' +
                       [Environment]::NewLine + '                  ' + '  "field": "Microsoft.Insights/metricAlerts/criteria.Microsoft.Azure.Monitor.MultipleResourceMultipleMetricCriteria.allOf[*].dimensions[*].name",' +
                       [Environment]::NewLine + '                  ' + '  "in": ['
                  foreach ($dimension in $alert.properties.dimensions) {
                      $dimensionRuleString += '"' + $dimension.name + '",'
                  }
                  $dimensionRuleString = $dimensionRuleString.TrimEnd(',') + ']' + [Environment]::NewLine + '                  },'
                  $alertTemplate = $alertTemplate -replace "##DIMENSIONS_RULE##", $dimensionRuleString
                  $dimensionRuleString = ""
                } else {
                    $alertTemplate = $alertTemplate -replace "##DIMENSIONS_RULE##", ""
                }
                $category = $alert.properties.metricNamespace -replace "Microsoft.", ""
                $category = $category -replace "/.+", ""
                $alertTemplate = $alertTemplate -replace "##POLICY_CATEGORY##", $category
                $serviceName = $alert.properties.metricNamespace -replace "Microsoft.", ""
                $serviceName = $serviceName -replace "[/]", " "
                $alertTemplate = $alertTemplate -replace "##SERVICE##", $serviceName
                $alertTemplate = $alertTemplate -replace "##SEVERITY##", $alert.properties.severity
                $alertTemplate = $alertTemplate -replace "##WINDOW_SIZE##", $alert.properties.windowSize
                $alertTemplate = $alertTemplate -replace "##EVALUATION_FREQUENCY##", $alert.properties.evaluationFrequency
                $alertTemplate = $alertTemplate -replace "##THRESHOLD##", $alert.properties.threshold
                $alertTemplate = $alertTemplate -replace "##METRIC_NAMESPACE##", $alert.properties.metricNamespace
                $alertTemplate = $alertTemplate -replace "##METRIC_NAME##", $alert.properties.metricName
                $alertTemplate = $alertTemplate -replace "##TIME_AGGREGATION##", $alert.properties.timeAggregation
                $alertTemplate = $alertTemplate -replace "##OPERATOR##", $alert.properties.operator
                $alertTemplate = $alertTemplate -replace "##CRITERION_TYPE##", $alert.properties.criterionType
                $alertTemplate = $alertTemplate -replace "##ALERT_SENSITIVITY##", $alert.properties.alertSensitivity
                $alertTemplate = $alertTemplate -replace "##MIN_FAILING_PERIODS##", $alert.properties.failingPeriods.minFailingPeriodsToAlert
                $alertTemplate = $alertTemplate -replace "##NUMBER_OF_EVALUATION_PERIODS##", $alert.properties.failingPeriods.numberOfEvaluationPeriods
                $alertTemplate = $alertTemplate -replace "##RESOURCE_TYPE##"
                $alertName = $alert.name -replace "[^a-zA-Z_]", ""
                $alertTemplate = $alertTemplate -replace "##ALERT_NAME##", $alertName
                $alertTemplate = $alertTemplate -replace "##ALERT_DESCRIPTION##", $alert.description
                $alertTemplate = $alertTemplate -replace "##QUERY##", $alert.properties.query

                if ($alert.properties.dimensions -ne $null) {
                  if ($alert.properties.dimensions.Count -eq 1) {
                    $alertTemplate = $alertTemplate -replace "##DIMENSIONS_RES##", ([Environment]::NewLine + '                              ' +
                      '  "dimensions": ' + "[" + ($alert.properties.dimensions | ConvertTo-Json -Compress) + "],")
                  } else {
                    $alertTemplate = $alertTemplate -replace "##DIMENSIONS_RES##", ([Environment]::NewLine + '                              ' +
                      '  "dimensions": ' + ($alert.properties.dimensions | ConvertTo-Json -Compress) + ",")
                  }
                }
                else {
                  $alertTemplate = $alertTemplate -replace "##DIMENSIONS_RES##", ""
                }

                $alertTemplate = $alertTemplate -replace "##OPERATION_NAME##", $alert.properties.operationName
                $policyEffectName = $alert.properties.metricName -replace "[^a-zA-Z0-9 _]", ""
                $alertTemplate = $alertTemplate -replace "##POLICY_EFFECT_NAME##", $policyEffectName
                if (-not (Test-Path -Path $policyDirectory)) {
                    New-Item -ItemType Directory -Path $policyDirectory -Force
                }
                if ($policyFileName -eq "") {
                    $policyFileName = $alert.name -replace "[^a-zA-Z0-9-]", ""
                }
                # Write the policy template to a file
                Out-File -FilePath "$($policyPathName)templates\policy-arm\$($policyFileName)_$($alert.guid).json" -InputObject $alertTemplate
            }
            elseif ($alert.type -eq "Log") {
              $alertTemplate = Get-Content ".\policy\log-full-arm.json"
              $alertTemplate = $alertTemplate -replace "##TELEMETRY_PID##", 'pid-8bb7cf8a-bcf7-4264-abcb-703ace2fc84d'
              $alertTemplate = $alertTemplate -replace "##POLICY_NAME##", $alert.guid
              if ($alert.deployments.name -ne $null) {
                $alertTemplate = $alertTemplate -replace "##POLICY_DISPLAY_NAME##", $alert.deployments.name
                $alertTemplate = $alertTemplate -replace "##POLICY_DESCRIPTION##", "Policy to Audit/$($alert.deployments.name)"
              }
              if ($alert.deployments.name -eq $null) {
                $alertTemplate = $alertTemplate -replace "##POLICY_DISPLAY_NAME##", "Deploy $($alert.name) Alert"
                $alertTemplate = $alertTemplate -replace "##POLICY_DESCRIPTION##", "Policy to Audit/Deploy $($alert.name) Alert"
              }

              $parts = $policyPathName -split '\\'
              $secondToLastIndex = $parts.Length - 2
              $thirdToLastIndex = $parts.Length - 3
              $category = $parts[$thirdToLastIndex]
              $resourceType = 'Microsoft.' + $parts[$thirdToLastIndex] + '/' + $parts[$secondToLastIndex]

              $alertTemplate = $alertTemplate -replace "##POLICY_CATEGORY##", $category
              $alertTemplate = $alertTemplate -replace "##RESOURCE_TYPE##", $resourceType
              $alertTemplate = $alertTemplate -replace "##SEVERITY##", $alert.properties.severity
              $alertTemplate = $alertTemplate -replace "##OPERATOR##", $alert.properties.operator
              $alertTemplate = $alertTemplate -replace "##TIME_AGGREGATION##", $alert.properties.timeAggregation
              $alertTemplate = $alertTemplate -replace "##WINDOW_SIZE##", $alert.properties.windowSize
              $alertTemplate = $alertTemplate -replace "##EVALUATION_FREQUENCY##", $alert.properties.evaluationFrequency
              $alertTemplate = $alertTemplate -replace "##THRESHOLD##", $alert.properties.threshold
              $alertTemplate = $alertTemplate -replace "##MIN_FAILING_PERIODS##", $alert.properties.failingPeriods.minFailingPeriodsToAlert
              $alertTemplate = $alertTemplate -replace "##NUMBER_OF_EVALUATION_PERIODS##", $alert.properties.failingPeriods.numberOfEvaluationPeriods
              $alertName = $alert.name -replace "[^a-zA-Z_]", ""
              $alertTemplate = $alertTemplate -replace "##ALERT_NAME##", $alertName
              $alertTemplate = $alertTemplate -replace "##ALERT_DESCRIPTION##", $alert.description
              $alertTemplate = $alertTemplate -replace "##QUERY##", (($alert.properties.query -replace "`n", "") -replace '"', '\"')

              if($alert.properties.dimensions.Count -eq 0) {
                $alertTemplate = $alertTemplate -replace "##DIMENSIONS##", "[]"
              } elseif($alert.properties.dimensions.Count -eq 1) {
                $alertTemplate = $alertTemplate -replace "##DIMENSIONS##", ("[" + ($alert.properties.dimensions | ConvertTo-Json -Compress) + "]")
              }
              else {
                $alertTemplate = $alertTemplate -replace "##DIMENSIONS##", ($alert.properties.dimensions | ConvertTo-Json -Compress)
              }

              if (-not (Test-Path -Path $policyDirectory)) {
                New-Item -ItemType Directory -Path $policyDirectory -Force
              }
              if ($policyFileName -eq "") {
                  $policyFileName = $alert.name -replace "[^a-zA-Z0-9-]", ""
              }
              # Write the policy template to a file
              Out-File -FilePath "$($policyPathName)templates\policy-arm\$($policyFileName)_$($alert.guid).json" -InputObject $alertTemplate
            }

            # Generate policy templates for activity log alerts
            elseif ($alert.type -eq "ActivityLog") {
              if ($alert.properties.category -eq "Administrative") {
                $alertTemplate = Get-Content ".\policy\activity-administrative-full-arm.json"

              } elseif ($alert.properties.category -eq "ResourceHealth") {
                $alertTemplate = Get-Content ".\policy\activity-resourcehealth-full-arm.json"
              } elseif ($alert.properties.category -eq "ServiceHealth") {
                $alertTemplate = Get-Content ".\policy\activity-servicehealth-full-arm.json"
              }

                $alertTemplate = $alertTemplate -replace "##TELEMETRY_PID##", 'pid-8bb7cf8a-bcf7-4264-abcb-703ace2fc84d'
                $alertTemplate = $alertTemplate -replace "##POLICY_NAME##", (('Deploy_' + $alert.name) -replace ' ', '_')
                if ($alert.deployments.name -ne $null) {
                    $alertTemplate = $alertTemplate -replace "##POLICY_DISPLAY_NAME##", $alert.deployments.name
                    $alertTemplate = $alertTemplate -replace "##POLICY_DESCRIPTION##", "Policy to Audit/$($alert.deployments.name)"
                }
                if ($alert.deployments.name -eq $null) {
                    $alertTemplate = $alertTemplate -replace "##POLICY_DISPLAY_NAME##", "Deploy $($alert.name) Alert"
                    $alertTemplate = $alertTemplate -replace "##POLICY_DESCRIPTION##", "Policy to Audit/Deploy $($alert.name) Alert"
                }

                $parts = $policyPathName -split '\\'
                $secondToLastIndex = $parts.Length - 2
                $thirdToLastIndex = $parts.Length - 3
                $category = $parts[$thirdToLastIndex]
                $resourceType = 'Microsoft.' + $parts[$thirdToLastIndex] + '/' + $parts[$secondToLastIndex]

                $alertTemplate = $alertTemplate -replace "##POLICY_CATEGORY##", $category
                $alertTemplate = $alertTemplate -replace "##RESOURCE_TYPE##", $resourceType
                $alertName = $alert.name -replace "[^a-zA-Z_]", ""
                $alertTemplate = $alertTemplate -replace "##ALERT_NAME##", $alertName
                $alertTemplate = $alertTemplate -replace "##ALERT_DESCRIPTION##", $alert.description
                $alertTemplate = $alertTemplate -replace "##OPERATION_NAME##", $alert.properties.operationName
                $alertTemplate = $alertTemplate -replace "##INCIDENT_TYPE##", $alert.properties.incidentType

                if ($alert.properties.category -eq "ResourceHealth") {
                  if ($alert.properties.causes -ne $null) {
                    $causesString = $causesString + ',' + [Environment]::NewLine + '                                      ' + '{' +
                        [Environment]::NewLine + '                                        ' + '"anyOf": ['
                    foreach ($cause in $alert.properties.causes) {
                        $causesString += [Environment]::NewLine + '                                          {'
                        $causesString += [Environment]::NewLine + '                                            ' + '"field": "properties.cause",'
                        $causesString += [Environment]::NewLine + '                                            "equals": "' + $cause + '"'
                        $causesString += [Environment]::NewLine + '                                          },'
                    }
                    $causesString = $causesString.TrimEnd(',') + [Environment]::NewLine + '                                        ' + ']' +
                                    [Environment]::NewLine + '                                      }'
                    $alertTemplate = $alertTemplate -replace "##CAUSES##", $causesString
                    $causesString = ""
                  } else {
                      $alertTemplate = $alertTemplate -replace "##CAUSES##", ""
                  }

                  if ($alert.properties.currentHealthStatus -ne $null) {
                    $currentHealthStatusString = $currentHealthStatusString + ',' + [Environment]::NewLine + '                                      ' + '{' +
                        [Environment]::NewLine + '                                        ' + '"anyOf": ['
                    foreach ($status in $alert.properties.currentHealthStatus) {
                        $currentHealthStatusString += [Environment]::NewLine + '                                          {'
                        $currentHealthStatusString += [Environment]::NewLine + '                                            ' + '"field": "properties.currentHealthStatus",'
                        $currentHealthStatusString += [Environment]::NewLine + '                                            "equals": "' + $status + '"'
                        $currentHealthStatusString += [Environment]::NewLine + '                                          },'
                    }
                    $currentHealthStatusString = $currentHealthStatusString.TrimEnd(',') + [Environment]::NewLine + '                                        ' + ']' +
                                    [Environment]::NewLine + '                                      }'
                    $alertTemplate = $alertTemplate -replace "##CUR_HEALTH_STATUS##", $currentHealthStatusString
                    $currentHealthStatusString = ""
                  } else {
                      $alertTemplate = $alertTemplate -replace "##CUR_HEALTH_STATUS##", ""
                  }

                  if ($alert.properties.status -ne $null) {
                    $statusString = $statusString + ',' + [Environment]::NewLine + '                                      ' + '{' +
                        [Environment]::NewLine + '                                        ' + '"anyOf": ['
                    foreach ($status in $alert.properties.status) {
                        $statusString += [Environment]::NewLine + '                                          {'
                        $statusString += [Environment]::NewLine + '                                            ' + '"field": "properties.status",'
                        $statusString += [Environment]::NewLine + '                                            "equals": "' + $status + '"'
                        $statusString += [Environment]::NewLine + '                                          },'
                    }
                    $statusString = $statusString.TrimEnd(',') + [Environment]::NewLine + '                                        ' + ']' +
                                    [Environment]::NewLine + '                                      }'
                    $alertTemplate = $alertTemplate -replace "##STATUS##", $statusString
                    $statusString = ""
                  } else {
                      $alertTemplate = $alertTemplate -replace "##STATUS##", ""
                  }

                  if ($alert.properties.previousHealthStatus -ne $null) {
                    $previousHealthStatusString = $previousHealthStatusString + ',' + [Environment]::NewLine + '                                      ' + '{' +
                        [Environment]::NewLine + '                                        ' + '"anyOf": ['
                    foreach ($status in $alert.properties.previousHealthStatus) {
                        $previousHealthStatusString += [Environment]::NewLine + '                                          {'
                        $previousHealthStatusString += [Environment]::NewLine + '                                            ' + '"field": "properties.previousHealthStatus",'
                        $previousHealthStatusString += [Environment]::NewLine + '                                            "equals": "' + $status + '"'
                        $previousHealthStatusString += [Environment]::NewLine + '                                          },'
                    }
                    $previousHealthStatusString = $previousHealthStatusString.TrimEnd(',') + [Environment]::NewLine + '                                        ' + ']' +
                                    [Environment]::NewLine + '                                      }'
                    $alertTemplate = $alertTemplate -replace "##PREV_HEALTH_STATUS##", $previousHealthStatusString
                    $previousHealthStatusString = ""
                  } else {
                      $alertTemplate = $alertTemplate -replace "##PREV_HEALTH_STATUS##", ""
                  }

                }

                if (-not (Test-Path -Path $policyDirectory)) {
                  New-Item -ItemType Directory -Path $policyDirectory -Force
                }
                if ($policyFileName -eq "") {
                    $policyFileName = $alert.name -replace "[^a-zA-Z0-9-]", ""
                }
                # Write the policy template to a file
                Out-File -FilePath "$($policyPathName)templates\policy-arm\$($policyFileName)_$($alert.guid).json" -InputObject $alertTemplate
            }
        }
    } -ThrottleLimit 10
}
end {
    Write-Output "Policy templates generated successfully."
}
