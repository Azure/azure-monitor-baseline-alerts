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
    .\generate-policies.ps1

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
            $policyDirectory = "$($policyPathName)templates\policy"
            # Check if the alert has a deployment template and has a deployment tag of "alz"
            if ((Test-Path -Path "$($policyPathName)$($alert.deployments.template)") -and $alert.deployments.tags -eq "alz") {
                if (-not (Test-Path -Path $policyDirectory)) {
                    New-Item -ItemType Directory -Path $policyDirectory -Force
                }
                if ($policyFileName -eq "") {
                    $policyFileName = $alert.name -replace "[^a-zA-Z0-9-]", ""
                }
                # Copy the deployment template to the policy directory
                Copy-Item -Path "$($policyPathName)$($alert.deployments.template)" -Destination "$($policyPathName)templates\policy\$($policyFileName)_$($alert.guid).json"
            }
            # Generate policy template based on the alert configuration
            If ($alert.type -eq "Metric") {
                if ($alert.type -eq "Metric" -and $alert.properties.criterionType -eq "StaticThresholdCriterion") {
                    $alertTemplate = Get-Content "C:\Repos\azure-monitor-baseline-alerts\tooling\generate-templates\policy\metric-static.json"
                }
                if ($alert.type -eq "Metric" -and $alert.properties.criterionType -eq "DynamicThresholdCriterion") {
                    $alertTemplate = Get-Content "C:\Repos\azure-monitor-baseline-alerts\tooling\generate-templates\policy\metric-dynamic.json"
                }
                # TODO: Add support for Log alerts, need to fix query format and dimensions
                #if ($alert.type -eq "Log") {
                #    $alertTemplate = Get-Content "C:\Repos\azure-monitor-baseline-alerts\tooling\generate-templates\policy\log.json"
                #}
                # TODO: Add support for Activity Log alerts, dependecy on resource type
                #if ($alert.type -eq "ActivityLog" -and $alert.properties.category -eq "Administrative") {
                #    $alertTemplate = Get-Content "C:\Repos\azure-monitor-baseline-alerts\tooling\generate-templates\policy\activity-administrative.json"
                #}
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
                $alertTemplate = $alertTemplate -replace "##DIMENSIONS##", $alert.properties.dimensions
                $alertTemplate = $alertTemplate -replace "##OPERATION_NAME##", $alert.properties.operationName
                if (-not (Test-Path -Path $policyDirectory)) {
                    New-Item -ItemType Directory -Path $policyDirectory -Force
                }
                if ($policyFileName -eq "") {
                    $policyFileName = $alert.name -replace "[^a-zA-Z0-9-]", ""
                }
                # Write the policy template to a file
                Out-File -FilePath "$($policyPathName)templates\policy\$($policyFileName)_$($alert.guid).json" -InputObject $alertTemplate
            }
        }
    } -ThrottleLimit 10
}
end {
    Write-Output "Policy templates generated successfully."
}
