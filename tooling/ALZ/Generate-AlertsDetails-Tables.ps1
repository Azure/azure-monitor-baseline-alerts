
# Defining input params
param (
  [Parameter(Mandatory = $false)]
  [string]
  $alertTablesRootDir
)

# Define the root directory to start searching
$policiesRootDir = ".\services"
If ([string]::IsNullOrEmpty($alertTablesRootDir)) {
  $alertTablesRootDir = ".\docs\content\patterns\alz\getting-started"
}

# Define policy definitions to be excluded from the search
$exclusionFileList = @(
  'Deploy-ActivityLog-SearchService-Del.json'
)

# Mapping severity values to their corresponding names
$severityMapping = [ordered]@{
  "0" = "Critical"
  "1" = "Error"
  "2" = "Warning"
  "3" = "Informational"
  "4" = "Verbose"
}

# Define source table file names
$activityLogAlertTableFile = $alertTablesRootDir + "\Activity-Log-Alerts-Table.md"
$LogSearchAlertTableFile = $alertTablesRootDir + "\Log-Search-Alerts-Table.md"
$metricAlertTableFile = $alertTablesRootDir + "\Metric-Alerts-Table.md"

# Define source table file heading and structure

## Appending lines to Activity Log source table files
"---" | Out-File $activityLogAlertTableFile -Encoding UTF8
"title: ActivityLog alerts table" | Out-File $activityLogAlertTableFile -Encoding UTF8 -Append
"geekdocHidden: true" | Out-File $activityLogAlertTableFile -Encoding UTF8 -Append
"---" | Out-File $activityLogAlertTableFile -Encoding UTF8 -Append -NoNewline
"`n" | Out-File $activityLogAlertTableFile -Encoding UTF8 -Append
"| Alert Policy Name | Alert Name | Alert Scope | Target Resource Type | Severity | Enabled |" | Out-File $activityLogAlertTableFile -Encoding UTF8 -Append
"| ----------------- | ---------- | ----------- | -------------------- | -------- | ------- |" | Out-File $activityLogAlertTableFile -Encoding UTF8 -Append

## Appending lines to Log Search source table files
"---" | Out-File $LogSearchAlertTableFile -Encoding UTF8
"title: Log-Search alerts table" | Out-File $LogSearchAlertTableFile -Encoding UTF8 -Append
"geekdocHidden: true" | Out-File $LogSearchAlertTableFile -Encoding UTF8 -Append
"---" | Out-File $LogSearchAlertTableFile -Encoding UTF8 -Append -NoNewline
"`n" | Out-File $LogSearchAlertTableFile -Encoding UTF8 -Append
"| Alert Policy Name | Alert Name | Alert Scope | Target Resource Type | Evaluation Period | Evaluation Frequency | Operator | Threshold | Severity | Enabled |" | Out-File $LogSearchAlertTableFile -Encoding UTF8 -Append
"| ----------------- | ---------- | ----------- | -------------------- | ----------------- | -------------------- |--------- | --------- | -------- | ------- |" | Out-File $LogSearchAlertTableFile -Encoding UTF8 -Append

## Appending lines to Metric source table files
"---" | Out-File $metricAlertTableFile -Encoding UTF8
"title: Metrics alerts table" | Out-File $metricAlertTableFile -Encoding UTF8 -Append
"geekdocHidden: true" | Out-File $metricAlertTableFile -Encoding UTF8 -Append
"---" | Out-File $metricAlertTableFile -Encoding UTF8 -Append -NoNewline
"`n" | Out-File $metricAlertTableFile -Encoding UTF8 -Append
"| Alert Policy Name | Alert Name | Alerts Scope | Target Resource Type | Evaluation Period | Evaluation Frequency | Metric | Aggregation | Operator | Threshold | Severity | Enabled |" | Out-File $metricAlertTableFile -Encoding UTF8 -Append
"| ----------------- | ---------- | ------------ | -------------------- | ----------------- | -------------------- | ------ | ----------- | -------- | --------- | -------- | ------- |" | Out-File $metricAlertTableFile -Encoding UTF8 -Append


# Get all JSON files under the root directory and its subdirectories
$jsonFiles = Get-ChildItem -Path $policiesRootDir -Recurse -Filter *.json | Where-Object { ($_.FullName -notlike "*\templates\*") -and ($_.Name -notlike "Not_In_Use_*") -and ($_.Name -notIn $exclusionFileList) }

# Loop through each JSON file
foreach ($file in $jsonFiles) {
  try {

    # Cleaning-up variables
    $jsonContent = $null
    $alertType = $null
    $policyName = $null
    $policyNameURL = $null
    $alertName = $null
    $alertScope = $null
    $targetResourceType = $null
    $evaluationPeriod = $null
    $evaluationFrequency = $null
    $metric = $null
    $aggregation = $null
    $operator = $null
    $threshold = $null
    $severity = $null
    $enabled = $null

    # Read the JSON file content
    $jsonContent = Get-Content -Path $file.FullName -Raw | ConvertFrom-Json

    # Generating the policy name URL
    #$policyNameURL = $($file.FullName -split('azure-monitor-baseline-alerts'))[1]
    #$policyNameURL = '../../../..'+$policyNameURL -replace '\\', '/'
    $policyNameURL = "https://www.azadvertizer.net/azpolicyadvertizer/" + $jsonContent.name + ".html"

    # Get alert type
    $alertType = $jsonContent.properties.policyRule.then.details.type

    switch ($alertType) {

      # Activitiy Log alerts' source file
      "Microsoft.Insights/activityLogAlerts" {

        # Process the JSON content
        $policyName = $jsonContent.properties.displayName

        if ($jsonContent.properties.policyRule.then.details.deployment.properties.template.resources.count -eq 1) {
          $alertName = $jsonContent.properties.policyRule.then.details.deployment.properties.template.resources.name
          $alertScope = $jsonContent.properties.policyRule.then.details.deployment.properties.template.resources.properties.scopes

        }
        else {
          $alertName = $jsonContent.properties.policyRule.then.details.deployment.properties.template.resources[1].properties.template.resources.name
          $alertScope = $jsonContent.properties.policyRule.then.details.deployment.properties.template.resources[1].properties.template.resources.properties.scopes
        }

        if ([regex]::Matches($alertScope, '(\b\w+\b)').Success) {
          $alertScope = [regex]::Matches($alertScope, '(\b\w+\b)').Groups[1].Value
        }

        $targetResourceType = $jsonContent.properties.policyRule.if.allOf[0].equals
        $severity = $severityMapping["4"]
        $enabled = $jsonContent.properties.parameters.enabled.defaultValue.ToString()

        # Appending the content to the file
        "| [$policyName]($policyNameURL) | $alertName | $alertScope | $targetResourceType | $severity | $enabled |" | Out-File $activityLogAlertTableFile -Encoding UTF8 -Append

      }

      # Log-Search alerts' source file
      "Microsoft.Insights/scheduledQueryRules" {

        # Process the JSON content
        $policyName = $jsonContent.properties.displayName

        if ($jsonContent.properties.policyRule.then.details.deployment.properties.template.resources.count -eq 1) {
          $alertName = $jsonContent.properties.policyRule.then.details.deployment.properties.template.resources.name

          if ([regex]::Matches($alertName, '(\b\w+\b)').Success) {
            $alertName = [regex]::Matches($alertName, '(\b\w+\b)').Groups[5].Value + "-" + [regex]::Matches($alertName, '(\b\w+\b)').Groups[6].Value

          }

          $alertScope = $jsonContent.properties.policyRule.then.details.deployment.properties.template.resources.properties.scopes

        }
        else {
          $alertName = $jsonContent.properties.policyRule.then.details.deployment.properties.template.resources[1].properties.template.resources.name

          if ([regex]::Matches($alertName, '(\b\w+\b)').Success) {
            $alertName = [regex]::Matches($alertName, '(\b\w+\b)').Groups[3].Value + "-" + [regex]::Matches($alertName, '(\b\w+\b)').Groups[6].Value

          }

          $alertScope = $jsonContent.properties.policyRule.then.details.deployment.properties.template.resources[1].properties.template.resources.properties.scopes

        }

        $targetResourceType = $jsonContent.properties.policyRule.if.allOf[0].equals

        if ([regex]::Matches($alertScope, '(\w+)').Success) {
          if ($file.Name -like "deploy-laworkspace-daily*") {
            $alertScope = [regex]::Matches($alertScope, '(\w+)').Groups[2].Value

          }
          elseif ($file.Name -like "deploy-AppInsightsThrottling*") {
            $alertScope = [regex]::Matches($alertScope, '(\w+)').Groups[4].Value + "-" + [regex]::Matches($alertScope, '(\w+)').Groups[12].Value

          }
          else {
            $alertScope = [regex]::Match($alertScope, '(\w+)').Groups[1].Value

          }
        }

        $evaluationPeriod = $jsonContent.properties.parameters.windowSize.defaultValue
        $evaluationFrequency = $jsonContent.properties.parameters.evaluationFrequency.defaultValue
        $operator = $jsonContent.properties.parameters.operator.defaultValue
        $threshold = $jsonContent.properties.parameters.threshold.defaultValue
        $severity = $severityMapping[$jsonContent.properties.parameters.severity.defaultValue]
        $enabled = $jsonContent.properties.parameters.enabled.defaultValue.ToString()

        # Appending the content to the file
        "| [$policyName]($policyNameURL) | $alertName | $alertScope | $targetResourceType | $evaluationPeriod | $evaluationFrequency | $operator | $threshold | $severity | $enabled |" | Out-File $LogSearchAlertTableFile -Encoding UTF8 -Append

      }

      # Metric alerts' source file
      "Microsoft.Insights/metricAlerts" {

        # Process the JSON content
        $policyName = $jsonContent.properties.displayName
        $alertName = $jsonContent.properties.policyRule.then.details.deployment.properties.template.resources.name

        if ([regex]::Matches($alertName, '(\b\w+\b)').Success) {
          $alertName = [regex]::Matches($alertName, '(\b\w+\b)').Groups[4].Value + "-" + [regex]::Matches($alertName, '(\b\w+\b)').Groups[6].Value

        }

        $targetResourceType = $jsonContent.properties.policyRule.if.allOf[0].equals
        $alertScope = $jsonContent.properties.policyRule.then.details.deployment.properties.template.resources.properties.scopes

        if ([regex]::Matches($alertScope, '(\b\w+\b)').Success) {
          $alertScope = [regex]::Matches($alertScope, '(\b\w+\b)').Groups[2].Value

        }

        $metric = $jsonContent.properties.policyRule.then.details.deployment.properties.template.resources.properties.criteria.allOf.metricName
        $aggregation = $jsonContent.properties.parameters.aggregation.defaultValue

        if ([string]::IsNullOrEmpty($aggregation)) {
          $aggregation = $jsonContent.properties.policyRule.then.details.deployment.properties.template.resources.properties.criteria.allOf.timeAggregation

        }

        if ([string]::IsNullOrEmpty($operator)) {
          $operator = $jsonContent.properties.policyRule.then.details.deployment.properties.template.resources.properties.criteria.allOf.operator

        }
        $threshold = $jsonContent.properties.parameters.threshold.defaultValue

        if ([string]::IsNullOrEmpty($threshold)) {
          $threshold = $jsonContent.properties.policyRule.then.details.deployment.properties.template.resources.properties.criteria.allOf.threshold

          if ([string]::IsNullOrEmpty($threshold)) {
            $threshold = $jsonContent.properties.policyRule.then.details.deployment.properties.template.resources.properties.criteria.allOf.criterionType

          }
        }

        $evaluationPeriod = $jsonContent.properties.parameters.windowSize.defaultValue
        $evaluationFrequency = $jsonContent.properties.parameters.evaluationFrequency.defaultValue
        $severity = $severityMapping[$jsonContent.properties.parameters.severity.defaultValue]
        $enabled = $jsonContent.properties.parameters.enabled.defaultValue.ToString()

        # Appending the content to the file
        "| [$policyName]($policyNameURL) | $alertName | $alertScope | $targetResourceType | $evaluationPeriod | $evaluationFrequency | $metric | $aggregation | $operator | $threshold | $severity | $enabled |" | Out-File $metricAlertTableFile -Encoding UTF8 -Append

      }
    }
  }

  catch {
    Write-Error "Failed to process file: $($file.FullName). Error: $_"

  }

}
