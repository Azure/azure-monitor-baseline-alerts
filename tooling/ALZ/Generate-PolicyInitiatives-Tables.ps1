# Defining input params
param (
  [Parameter(Mandatory = $false)]
  [string]
  $policyInitiativesTablesRootDir
)

# Define the root directory to start searching
$policiesRootDir = ".\services"
$policyInitiativesRootDir = ".\patterns\alz\policySetDefinitions"
If ([string]::IsNullOrEmpty($policyInitiativesTablesRootDir)) {
  $policyInitiativesTablesRootDir = ".\docs\content\patterns\alz\getting-started"
}

# Define policy definitions to be excluded from the search
$exclusionFileList = @(
  'Deploy-ActivityLog-SearchService-Del.json'
)

# Define an array of processed policy definition files
$processedPolicyDefinitionFiles = New-Object System.Collections.ArrayList

# Define source table files' suffix
$policyInitiativeTableFileNameSuffix = "-PolicyInitiative-Table.md"

# Get all JSON files under the root directory and its subdirectories
$policyDefinitionJsonFiles = Get-ChildItem -Path $policiesRootDir -Recurse -Filter *.json | Where-Object { ($_.FullName -notlike "*\templates\*") -and ($_.Name -notlike "Not_In_Use_*") -and ($_.Name -notIn $exclusionFileList) }

# Get all policy initiative JSON files under the policyInitiativesTablesRootDir directory
$policyInitiativeJsonFiles = Get-ChildItem -Path $policyInitiativesRootDir -Recurse -Filter *.json

ForEach ($policyInitiativeJsonFile in $policyInitiativeJsonFiles) {
  try {

    # Cleaning-up variables
    $jsonContent = $null
    $policyInitiativeName = $null
    $policyInitiativeTableFileName = $null
    $policyReferences = $null

    # Reading policyInitiative JSON file content
    $jsonContent = Get-Content -Path $policyInitiativeJsonFile.FullName -Raw | ConvertFrom-Json

    # Extract the policy initiative name
    $policyInitiativeName = $jsonContent.name

    # Assembling the policy initiative table file name
    $policyInitiativeTableFileName = $policyInitiativesTablesRootDir + "\" + $policyInitiativeName + $policyInitiativeTableFileNameSuffix

    # Define source table file heading and structure
    "---" | Out-File $policyInitiativeTableFileName -Encoding UTF8
    "title: $policyInitiativeName Policy Initiative table" | Out-File $policyInitiativeTableFileName -Encoding UTF8 -Append
    "geekdocHidden: true" | Out-File $policyInitiativeTableFileName -Encoding UTF8 -Append
    "---" | Out-File $policyInitiativeTableFileName -Encoding UTF8 -Append -NoNewline
    "`n" | Out-File $policyInitiativeTableFileName -Encoding UTF8 -Append
    "| Policy Display Name | Policy Internal Name | Policy Reference ID | Policy code (JSON) | Default policy effect |" | Out-File $policyInitiativeTableFileName -Encoding UTF8 -Append
    "| ------------------- | -------------------- |-------------------- | ------------------ | --------------------- |" | Out-File $policyInitiativeTableFileName -Encoding UTF8 -Append

    # Getting policy reference IDs and
    $policyReferences = $jsonContent.properties.policyDefinitions

    ForEach ($policyReference in $policyReferences) {
      # Cleaning-up variables
      $policyReferenceID = $null
      $policyDefinitionID = $null

      # Extracting policy reference ID
      $policyReferenceID = $policyReference.policyDefinitionReferenceId
      $policyDefinitionID = $policyReference.policyDefinitionId -replace '/providers/Microsoft.Management/managementGroups/contoso/providers/Microsoft.Authorization/policyDefinitions/', ''

      # Read the JSON file content
      ForEach ($policyDefinitionJsonFile in $policyDefinitionJsonFiles) {
        # Cleaning-up variables
        $policyDefinitionJsonContent = $null
        $policyInternalName = $null
        $policyDisplayName = $null
        $policyDefaultEffect = $null
        $policyCodeURL = $null
        $policyCodeFileName = $null

        # Reading policy definition file
        if ( ($policyDefinitionJsonFile.FullName -notin $exclusionFileList) -and ($policyDefinitionJsonFile.FullName -notIn $processedPolicyDefinitionFiles) ) {
          $policyDefinitionJsonContent = Get-Content -Path $policyDefinitionJsonFile.FullName -Raw | ConvertFrom-Json

          if ( $policyDefinitionJsonContent.name -eq $policyDefinitionID) {
            # Adding the policy definition file to the processed list
            #$processedPolicyDefinitionFiles.Add($policyDefinitionJsonFile.FullName) | Out-Null

            # Extracting policy name
            $policyInternalName = $policyDefinitionJsonContent.name
            $policyDisplayName = $policyDefinitionJsonContent.properties.displayName
            $policyDefaultEffect = $policyDefinitionJsonContent.properties.parameters.effect.defaultValue
            if ( [string]::IsNullOrEmpty($policyDefaultEffect) ) {
              $policyDefaultEffect = $policyDefinitionJsonContent.properties.policyRule.then.effect
            }

            # Extracting policy code file name
            $policyCodeFileName = $policyDefinitionJsonFile.Name

            # Assembling the policy definition code URL
            $policyCodeURL = $($policyDefinitionJsonFile.FullName -split ('azure-monitor-baseline-alerts'))[1]
            $policyCodeURL = '../../../..' + $policyCodeURL -replace '\\', '/'

            # Appending the content to the file
            "| $policyDisplayName | $policyInternalName | $policyReferenceID | [$policyCodeFileName]($policyCodeURL) | $policyDefaultEffect |" | Out-File $policyInitiativeTableFileName -Encoding UTF8 -Append

            # Exiting loop
            break

          }

        }

      }

    }

  }
  catch {
    Write-Error "Failed to process file: $($policyInitiativeJsonFile.FullName). Error: $_"

  }

}

# End of script
