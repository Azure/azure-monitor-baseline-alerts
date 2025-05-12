
# Define the root directory to start searching
$policiesRootDir = ".\services"
$thresholdOverrideTablesRoorDir = ".\docs\content\patterns\alz\HowTo"
$exclusionFileList = 'Deploy-ActivityLog-SearchService-Del.json'

# Define source table file heading and structure
$activityLogAlertsThresholdOverrideTableFile = $thresholdOverrideTablesRoorDir + "\ActivityLog_Alerts_OverrideTags_Table.md"
$LogSearchAlertsThresholdOverrideTableFile = $thresholdOverrideTablesRoorDir + "\Log_Search_Alerts_OverrideTags_Table.md"
$metrictAlertsThresholdOverrideTableFile = $thresholdOverrideTablesRoorDir + "\Metrics_Alerts_OverrideTags_Table.md"

# Appending lines to Activity Log source table files
"---" | Out-File $activityLogAlertsThresholdOverrideTableFile -Encoding UTF8
"title: Activity Log alerts override tags table" | Out-File $activityLogAlertsThresholdOverrideTableFile -Encoding UTF8 -Append
"geekdocHidden: true" | Out-File $activityLogAlertsThresholdOverrideTableFile -Encoding UTF8 -Append
"---" | Out-File $activityLogAlertsThresholdOverrideTableFile -Encoding UTF8 -Append -NoNewline
"`n" | Out-File $activityLogAlertsThresholdOverrideTableFile -Encoding UTF8 -Append
"| Resource Type | Alert Name | Override Tag name | Tag value type | Operator | Original threshold value | Overriden threshold value example |" | Out-File $activityLogAlertsThresholdOverrideTableFile -Encoding UTF8 -Append
"| ------------- | ---------- | ----------------- | -------------- | -------- | ------------------------ | --------------------------------- |" | Out-File $activityLogAlertsThresholdOverrideTableFile -Encoding UTF8 -Append

# Appending lines to Log Search source table files
"---" | Out-File $LogSearchAlertsThresholdOverrideTableFile -Encoding UTF8
"title: Log-search alerts override tags table" | Out-File $LogSearchAlertsThresholdOverrideTableFile -Encoding UTF8 -Append
"geekdocHidden: true" | Out-File $LogSearchAlertsThresholdOverrideTableFile -Encoding UTF8 -Append
"---" | Out-File $LogSearchAlertsThresholdOverrideTableFile -Encoding UTF8 -Append -NoNewline
"`n" | Out-File $LogSearchAlertsThresholdOverrideTableFile -Encoding UTF8 -Append
"| Resource Type | Alert Name | Override Tag name | Tag value type | Operator | Original threshold value | Overriden threshold value example |" | Out-File $activityLogAlertsThresholdOverrideTableFile -Encoding UTF8 -Append
"| ------------- | ---------- | ----------------- | -------------- | -------- | ------------------------ | --------------------------------- |" | Out-File $activityLogAlertsThresholdOverrideTableFile -Encoding UTF8 -Append

# Appending lines to Metric source table files
"---" | Out-File $metrictAlertsThresholdOverrideTableFile -Encoding UTF8
"title: Metric alerts override tags table" | Out-File $metrictAlertsThresholdOverrideTableFile -Encoding UTF8 -Append
"geekdocHidden: true" | Out-File $metrictAlertsThresholdOverrideTableFile -Encoding UTF8 -Append
"---" | Out-File $metrictAlertsThresholdOverrideTableFile -Encoding UTF8 -Append -NoNewline
"`n" | Out-File $metrictAlertsThresholdOverrideTableFile -Encoding UTF8 -Append
"| Resource Type | Alert Name | Override Tag name | Tag value type | Operator | Original threshold value | Overriden threshold value example |" | Out-File $activityLogAlertsThresholdOverrideTableFile -Encoding UTF8 -Append
"| ------------- | ---------- | ----------------- | -------------- | -------- | ------------------------ | --------------------------------- |" | Out-File $activityLogAlertsThresholdOverrideTableFile -Encoding UTF8 -Append

# Get all JSON files under the root directory and its subdirectories
$jsonFiles = Get-ChildItem -Path $policiesRootDir -Recurse -Filter *.json | Where-Object { ($_.FullName -notlike "*\templates\*") -and ($_.Name -notlike "Not_In_Use_*") -and ($_.Name -notIn $exclusionFileList) }

# Loop through each JSON file
foreach ($file in $jsonFiles) {
  try {

    # Cleaning-up variables
    $jsonContent = $null
    $alertType = $null
    $alertName = $null
    $targetResourceType = $null
    $operator = $null
    $threshold = $null

    # Read the JSON file content
    $jsonContent = Get-Content -Path $file.FullName -Raw | ConvertFrom-Json

    # Get alert type
    $alertType = $jsonContent.properties.policyRule.then.details.type

    switch ($alertType) {

      # Activitiy Log alerts' source file
      "Microsoft.Insights/activityLogAlerts" {

        # Retrieving relevant alert properties from the JSON content
        if ($jsonContent.properties.policyRule.then.details.deployment.properties.template.resources.count -eq 1) {
          $alertName = $jsonContent.properties.policyRule.then.details.deployment.properties.template.resources.name

        }
        else {
          $alertName = $jsonContent.properties.policyRule.then.details.deployment.properties.template.resources[1].properties.template.resources.name
        }


        $targetResourceType = $jsonContent.properties.policyRule.if.allOf[0].equals

        # Setting constants for Activity Log Alerts
        $overrideTagName = " <span style=""color:DarkOrange"">***Not applicable***</span> "
        $tagValueType = " <span style=""color:DarkOrange"">***N/A***</span> "
        $operator = " <span style=""color:DarkOrange"">***N/A***</span> "
        $threshold = " <span style=""color:DarkOrange"">***N/A***</span> "
        $thresholdOverrideSample = " <span style=""color:DarkOrange"">***N/A***</span> "

        # Appending the content to the file
        "| $targetResourceType | $alertName | $overrideTagName | $tagValueType | $operator | $threshold | $thresholdOverrideSample |" | Out-File $activityLogAlertTableFile -Encoding UTF8 -Append

      }

      # Log-Search alerts' source file
      "Microsoft.Insights/scheduledQueryRules" {

        # Retrieving relevant alert properties from the JSON content
        if ($jsonContent.properties.policyRule.then.details.deployment.properties.template.resources.count -eq 1) {
          $alertName = $jsonContent.properties.policyRule.then.details.deployment.properties.template.resources.name

          if ([regex]::Matches($alertName, '(\b\w+\b)').Success) {
            $alertName = [regex]::Matches($alertName, '(\b\w+\b)').Groups[5].Value + "-" + [regex]::Matches($alertName, '(\b\w+\b)').Groups[6].Value

          }

          $overrideTagName = $jsonContent.properties.policyRule.then.details.deployment.properties.template.resources.properties.criteria.allof.query
          if ([regex]::Matches($overrideTagName, '(_amba-(.*?)-Override_)')) {
            $overrideTagName = [regex]::Matches($overrideTagName, '(_amba-(.*?)-Override_)').Groups[1].Value

          }

        }
        else {
          $alertName = $jsonContent.properties.policyRule.then.details.deployment.properties.template.resources[1].properties.template.resources.name

          if ([regex]::Matches($alertName, '(\b\w+\b)').Success) {
            $alertName = [regex]::Matches($alertName, '(\b\w+\b)').Groups[3].Value + "-" + [regex]::Matches($alertName, '(\b\w+\b)').Groups[6].Value

          }

          $overrideTagName = $jsonContent.properties.policyRule.then.details.deployment.properties.template.resources[1].properties.template.resources.properties.criteria.allof.query
          if ([regex]::Matches($overrideTagName, '(_amba-(.*?)-Override_)')) {
            $overrideTagName = [regex]::Matches($overrideTagName, '(_amba-(.*?)-Override_)').Groups[1].Value

          }

        }

        $targetResourceType = $jsonContent.properties.policyRule.if.allOf[0].equals

        $operator = $jsonContent.properties.parameters.operator.defaultValue
        $threshold = $jsonContent.properties.parameters.threshold.defaultValue

        [Int32]$OutNumber = $null

        if ([Int32]::TryParse($threshold,[ref]$OutNumber)){
          $tagValueType = "Number"
          $overrideStartingAt = $OutNumber
        }
        else {
          $tagValueType = "String"

        }

        if ($operator -eq "GreaterThan") {
          $thresholdOverrideSample = Get-Random -Minimum $overrideStartingAt -Maximum 100
        }
        elseif ($operator -eq "lessThan") {
          $thresholdOverrideSample = Get-Random -Minimum 0 -Maximum $overrideStartingAt
        }
        else {
          $thresholdOverrideSample = " ***Not applicable*** "
        }

        # Appending the content to the file
        "| $targetResourceType | $alertName | $overrideTagName | $tagValueType | $operator | $threshold | $thresholdOverrideSample |" | Out-File $LogSearchAlertsThresholdOverrideTableFile -Encoding UTF8 -Append

      }

      # Metric alerts' source file
      "Microsoft.Insights/metricAlerts" {

        # Retrieving relevant alert properties from the JSON content
        $alertName = $jsonContent.properties.policyRule.then.details.deployment.properties.template.resources.name

        if ([regex]::Matches($alertName, '(\b\w+\b)').Success) {
          $alertName = [regex]::Matches($alertName, '(\b\w+\b)').Groups[4].Value + "-" + [regex]::Matches($alertName, '(\b\w+\b)').Groups[6].Value

        }

        $targetResourceType = $jsonContent.properties.policyRule.if.allOf[0].equals
        $alertScope = $jsonContent.properties.policyRule.then.details.deployment.properties.template.resources.properties.scopes

        if ([regex]::Matches($alertScope, '(\b\w+\b)').Success) {
          $alertScope = [regex]::Matches($alertScope, '(\b\w+\b)').Groups[2].Value

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

        $overrideTagName =
        $tagValueType =
        $thresholdOverrideSample =

        # Appending the content to the file
        "| $targetResourceType | $alertName | $overrideTagName | $tagValueType | $operator | $threshold | $thresholdOverrideSample |" | Out-File $metrictAlertsThresholdOverrideTableFile -Encoding UTF8 -Append

      }
    }
  }

  catch {
    Write-Error "Failed to process file: $($file.FullName). Error: $_"

  }

}
