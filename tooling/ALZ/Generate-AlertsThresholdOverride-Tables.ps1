
# Defining input params
param (
  [Parameter(Mandatory = $false)]
  [string]
  $thresholdOverrideTablesRootDir
)

# Define the root directory to start searching
$policiesRootDir = ".\services"
If ([string]::IsNullOrEmpty($thresholdOverrideTablesRootDir)) {
  $thresholdOverrideTablesRootDir = ".\docs\content\patterns\alz\HowTo"
}

# Define policy definitions to be excluded from the search
$exclusionFileList = @(
  'Deploy-ActivityLog-SearchService-Del.json'
)

# Define source table file names
$activityLogAlertsThresholdOverrideTableFile = $thresholdOverrideTablesRootDir + "\ActivityLog_Alerts_OverrideTags_Table.md"
$LogSearchAlertsThresholdOverrideTableFile = $thresholdOverrideTablesRootDir + "\Log_Search_Alerts_OverrideTags_Table.md"
$metrictAlertsThresholdOverrideTableFile = $thresholdOverrideTablesRootDir + "\Metrics_Alerts_OverrideTags_Table.md"

# Define source table file heading and structure
"---" | Out-File $activityLogAlertsThresholdOverrideTableFile -Encoding UTF8
"title: Activity Log alerts override tags table" | Out-File $activityLogAlertsThresholdOverrideTableFile -Encoding UTF8 -Append
"geekdocHidden: true" | Out-File $activityLogAlertsThresholdOverrideTableFile -Encoding UTF8 -Append
"---" | Out-File $activityLogAlertsThresholdOverrideTableFile -Encoding UTF8 -Append -NoNewline
"`n" | Out-File $activityLogAlertsThresholdOverrideTableFile -Encoding UTF8 -Append
"| Resource Type | Alert Name | Override Tag name | Tag value type | Operator | Original threshold value | Sample override value |" | Out-File $activityLogAlertsThresholdOverrideTableFile -Encoding UTF8 -Append
"| ------------- | ---------- | ----------------- | -------------- | -------- | ------------------------ | --------------------- |" | Out-File $activityLogAlertsThresholdOverrideTableFile -Encoding UTF8 -Append

## Appending lines to Log Search source table files
"---" | Out-File $LogSearchAlertsThresholdOverrideTableFile -Encoding UTF8
"title: Log-search alerts override tags table" | Out-File $LogSearchAlertsThresholdOverrideTableFile -Encoding UTF8 -Append
"geekdocHidden: true" | Out-File $LogSearchAlertsThresholdOverrideTableFile -Encoding UTF8 -Append
"---" | Out-File $LogSearchAlertsThresholdOverrideTableFile -Encoding UTF8 -Append -NoNewline
"`n" | Out-File $LogSearchAlertsThresholdOverrideTableFile -Encoding UTF8 -Append
"| Resource Type | Alert Name | Override Tag name | Tag value type | Operator | Original threshold value | Sample override value |" | Out-File $LogSearchAlertsThresholdOverrideTableFile -Encoding UTF8 -Append
"| ------------- | ---------- | ----------------- | -------------- | -------- | ------------------------ | --------------------- |" | Out-File $LogSearchAlertsThresholdOverrideTableFile -Encoding UTF8 -Append

## Appending lines to Metric source table files
"---" | Out-File $metrictAlertsThresholdOverrideTableFile -Encoding UTF8
"title: Metric alerts override tags table" | Out-File $metrictAlertsThresholdOverrideTableFile -Encoding UTF8 -Append
"geekdocHidden: true" | Out-File $metrictAlertsThresholdOverrideTableFile -Encoding UTF8 -Append
"---" | Out-File $metrictAlertsThresholdOverrideTableFile -Encoding UTF8 -Append -NoNewline
"`n" | Out-File $metrictAlertsThresholdOverrideTableFile -Encoding UTF8 -Append
"| Resource Type | Alert Name | Override Tag name | Tag value type | Operator | Original threshold value | Sample override value |" | Out-File $metrictAlertsThresholdOverrideTableFile -Encoding UTF8 -Append
"| ------------- | ---------- | ----------------- | -------------- | -------- | ------------------------ | --------------------- |" | Out-File $metrictAlertsThresholdOverrideTableFile -Encoding UTF8 -Append

## Get all JSON files under the root directory and its subdirectories
$jsonFiles = Get-ChildItem -Path $policiesRootDir -Recurse -Filter *.json | Where-Object { ($_.FullName -notlike "*\templates\*") -and ($_.Name -notlike "Not_In_Use_*") -and ($_.Name -notIn $exclusionFileList) }

# Setting the regex patterns
$alertNameRegex = [regex]::New('(\b\w+\b)')
$overrideTagNameRegex = [regex]::New('(_amba-(.*?)-[o|O]verride_)')
$timespanRegex = [regex]::New('^\d+[smhd]$')

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
    $overrideTagName = $null
    $tagValueType = $null
    $thresholdOverrideSample = $null
    $maximum = $null
    $overrideStartingAt = $null
    $OutNumber = $null

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
        $overrideTagName = " <span style=""color:DarkOrange"">***Not applicable to Activity Log based alerts***</span> "
        $tagValueType = " <span style=""color:DarkOrange"">***N/A***</span> "
        $operator = " <span style=""color:DarkOrange"">***N/A***</span> "
        $threshold = " <span style=""color:DarkOrange"">***N/A***</span> "
        $thresholdOverrideSample = " <span style=""color:DarkOrange"">***N/A***</span> "

        # Appending the content to the file
        "| $targetResourceType | $alertName | $overrideTagName | $tagValueType | $operator | $threshold | $thresholdOverrideSample |" | Out-File $activityLogAlertsThresholdOverrideTableFile -Encoding UTF8 -Append

      }

      # Log-Search alerts' source file
      "Microsoft.Insights/scheduledQueryRules" {

        # Retrieving relevant alert properties from the JSON content
        if ($jsonContent.properties.policyRule.then.details.deployment.properties.template.resources.count -eq 1) {

          $alertName = $jsonContent.properties.policyRule.then.details.deployment.properties.template.resources.name
          if ([regex]::Matches($alertName, $alertNameRegex).Success) {
            if ([regex]::Matches($alertName, $alertNameRegex).Groups[3].Value -eq "subscription") {
              $alertName = "subscription().displayName-" + [regex]::Matches($alertName, $alertNameRegex).Groups[6].Value

            }
            else {
              $alertName = [regex]::Matches($alertName, $alertNameRegex).Groups[5].Value + "-" + [regex]::Matches($alertName, $alertNameRegex).Groups[6].Value

            }

          }

          $overrideTagName = $jsonContent.properties.policyRule.then.details.deployment.properties.template.resources.properties.criteria.allof.query
          if ([regex]::Matches($overrideTagName, $overrideTagNameRegex)) {
            $overrideTagName = [regex]::Matches($overrideTagName, $overrideTagNameRegex).Groups[1].Value
            $overrideTagName = $overrideTagName -replace "_", "\_"
            $overrideTagName = "***$overrideTagName***"

          }
          else {
            # Setting constants for Log-Search Alerts
            $overrideTagName = " <span style=""color:DarkOrange"">***Not applicable***</span> "
            $tagValueType = " <span style=""color:DarkOrange"">***N/A***</span> "
            $operator = " <span style=""color:DarkOrange"">***N/A***</span> "
            $threshold = " <span style=""color:DarkOrange"">***N/A***</span> "
            $thresholdOverrideSample = " <span style=""color:DarkOrange"">***N/A***</span> "

          }

        }
        else {

          $alertName = $jsonContent.properties.policyRule.then.details.deployment.properties.template.resources[1].properties.template.resources.name
          if ([regex]::Matches($alertName, $alertNameRegex).Success) {
            if ([regex]::Matches($alertName, $alertNameRegex).Groups[3].Value -eq "subscription") {
              $alertName = "subscription().displayName-" + [regex]::Matches($alertName, $alertNameRegex).Groups[6].Value

            }
            else {
              $alertName = [regex]::Matches($alertName, $alertNameRegex).Groups[3].Value + "-" + [regex]::Matches($alertName, $alertNameRegex).Groups[6].Value

            }

          }

          $overrideTagName = $jsonContent.properties.policyRule.then.details.deployment.properties.template.resources[1].properties.template.resources.properties.criteria.allof.query
          if ([regex]::Matches($overrideTagName, $overrideTagNameRegex)) {
            $overrideTagName = [regex]::Matches($overrideTagName, $overrideTagNameRegex).Groups[1].Value
            $overrideTagName = $overrideTagName -replace "_", "\_"
            $overrideTagName = "***$overrideTagName***"

          }
          else {
            # Setting constants for Activity Log Alerts
            $overrideTagName = " <span style=""color:DarkOrange"">***Not applicable***</span> "
            $tagValueType = " <span style=""color:DarkOrange"">***N/A***</span> "
            $operator = " <span style=""color:DarkOrange"">***N/A***</span> "
            $threshold = " <span style=""color:DarkOrange"">***N/A***</span> "
            $thresholdOverrideSample = " <span style=""color:DarkOrange"">***N/A***</span> "

          }

        }

        $targetResourceType = $jsonContent.properties.policyRule.if.allOf[0].equals

        $operator = $jsonContent.properties.parameters.operator.defaultValue
        $threshold = $jsonContent.properties.parameters.threshold.defaultValue

        if ([Int32]::TryParse($threshold, [ref]$OutNumber)) {
          $tagValueType = "Number"
          $overrideStartingAt = $OutNumber

        }
        elseif ([regex]::Matches($threshold, $timespanRegex)) {
          $tagValueType = "Timespan (string)"

        }
        else {
          $tagValueType = "String"

        }



        if (($operator -like "GreaterThan*") -and ($tagValueType -eq "Number") -and ($overrideTagName -notlike "*Not Applicable*")) {

          $thresholdOverrideSample = Get-Random -Minimum 0 -Maximum $overrideStartingAt
          $thresholdOverrideSample = [System.Math]::Round($thresholdOverrideSample)


        }
        elseif (($operator -eq "LessThan") -and ($tagValueType -eq "Number") -and ($overrideTagName -notlike "*Not Applicable*")) {
          $maximum = $overrideStartingAt + ([System.Math]::Round($overrideStartingAt / 5.0))
          $thresholdOverrideSample = Get-Random -Minimum $overrideStartingAt -Maximum $maximum
          $thresholdOverrideSample = [System.Math]::Round($thresholdOverrideSample)

        }
        else {
          $thresholdOverrideSample = " <span style=""color:DarkOrange"">***N/A***</span> "

        }

        # Appending the content to the file
        "| $targetResourceType | $alertName | $overrideTagName | $tagValueType | $operator | $threshold | $thresholdOverrideSample |" | Out-File $LogSearchAlertsThresholdOverrideTableFile -Encoding UTF8 -Append

      }

      # Metric alerts' source file
      "Microsoft.Insights/metricAlerts" {

        # Retrieving relevant alert properties from the JSON content
        $alertName = $jsonContent.properties.policyRule.then.details.deployment.properties.template.resources.name

        if ([regex]::Matches($alertName, $alertNameRegex).Success) {
          $alertName = [regex]::Matches($alertName, $alertNameRegex).Groups[4].Value + "-" + [regex]::Matches($alertName, $alertNameRegex).Groups[6].Value

          $overrideTagName = $jsonContent.properties.policyRule.then.details.deployment.properties.parameters.threshold.value
          if ([regex]::Matches($overrideTagName, $overrideTagNameRegex)) {
            $overrideTagName = [regex]::Matches($overrideTagName, $overrideTagNameRegex).Groups[1].Value
            $overrideTagName = $overrideTagName -replace "_", "\_"
            $overrideTagName = "***$overrideTagName***"

          }
          else {
            # Setting constants for Metrics Alerts
            $overrideTagName = " <span style=""color:DarkOrange"">***Not applicable to alerts configured with dynamic thresholds***</span> "
            $tagValueType = " <span style=""color:DarkOrange"">***N/A***</span> "
            $operator = " <span style=""color:DarkOrange"">***N/A***</span> "
            $threshold = " <span style=""color:DarkOrange"">***N/A***</span> "
            $thresholdOverrideSample = " <span style=""color:DarkOrange"">***N/A***</span> "

          }

        }

        $targetResourceType = $jsonContent.properties.policyRule.if.allOf[0].equals

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

        if ([Int32]::TryParse($threshold, [ref]$OutNumber)) {
          $tagValueType = "Number"
          $overrideStartingAt = $OutNumber
          if ($OutNumber -le 1) {
            $overrideStartingAt = 10

          }
          else {
            $overrideStartingAt = $OutNumber

          }

        }
        elseif ([Decimal]::TryParse($threshold, [ref]$OutNumber)) {
          $tagValueType = "Number"
          $overrideStartingAt = $OutNumber
          if ($OutNumber -le 1) {
            $overrideStartingAt = 10

          }
          else {
            $overrideStartingAt = $OutNumber

          }

        }
        else {
          $tagValueType = "String"

        }

        if (($operator -like "GreaterThan*") -and ($tagValueType -eq "Number") -and ($overrideTagName -notlike "*Not Applicable*")) {

          $thresholdOverrideSample = Get-Random -Minimum 0 -Maximum $overrideStartingAt
          $thresholdOverrideSample = [System.Math]::Round($thresholdOverrideSample)


        }
        elseif (($operator -eq "LessThan") -and ($tagValueType -eq "Number") -and ($overrideTagName -notlike "*Not Applicable*")) {
          $maximum = $overrideStartingAt + ([System.Math]::Round($overrideStartingAt / 5.0))
          $thresholdOverrideSample = Get-Random -Minimum $overrideStartingAt -Maximum $maximum
          $thresholdOverrideSample = [System.Math]::Round($thresholdOverrideSample)

        }
        else {
          $thresholdOverrideSample = " <span style=""color:DarkOrange"">***N/A***</span> "

        }



        # Appending the content to the file
        "| $targetResourceType | $alertName | $overrideTagName | $tagValueType | $operator | $threshold | $thresholdOverrideSample |" | Out-File $metrictAlertsThresholdOverrideTableFile -Encoding UTF8 -Append

      }
    }
  }

  catch {
    Write-Error "Failed to process file: $($file.FullName). Error: $_"

  }

}
