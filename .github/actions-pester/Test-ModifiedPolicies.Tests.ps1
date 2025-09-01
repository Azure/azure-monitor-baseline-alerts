Describe 'UnitTest-ModifiedPolicies' {
  BeforeAll {
    Import-Module -Name $PSScriptRoot\PolicyPesterTestHelper.psm1 -Force # -Verbose

    $ModifiedFiles = @(Get-PolicyFiles -DiffFilter "M") | Where-Object { ($_ -notlike '*/templates/*') -or ($_ -like '*/policy/*') -and ($_ -like "*.json") }
    if ($ModifiedFiles -ne $null) {
      Write-Warning "These are the modified policies:"
      $ModifiedFiles | ForEach-Object {
        Write-Host "`t$_" -ForegroundColor DarkYellow
      }
    }
    else {
      Write-Information "There are no modified policies"
    }

    $AddedFiles = @(Get-PolicyFiles -DiffFilter "A") | Where-Object { ($_ -notlike '*/templates/*') -or ($_ -like '*/policy/*') -and ($_ -like "*.json") }
    if ($AddedFiles -ne $null) {
      Write-Warning "These are the added policies:"
      $AddedFiles | ForEach-Object {
        Write-Host "`t$_" -ForegroundColor DarkYellow
      }
    }
    else {
      Write-Information "There are no added policies"
    }

    $ModifiedAddedFiles = $ModifiedFiles + $AddedFiles

  }

  Context "Validate policy metadata" {

    It "Check policy metadata version exists" -Skip:($ModifiedAddedFiles -ne $null) {
      $ModifiedAddedFiles | ForEach-Object {

        $PolicyJson = Get-Content -Path $_ -Raw | ConvertFrom-Json
        $PolicyFile = Split-Path $_ -Leaf
        $PolicyMetadataVersion = $PolicyJson.properties.metadata.version
        # Write-Warning "$($PolicyFile) - The current metadata version for the policy in the PR branch is : $($PolicyMetadataVersion)"
        $PolicyMetadataVersion | Should -Not -BeNullOrEmpty -Because "the [version] attribute does not exist on file [$PolicyFile]."

      }
    }

    It "Check policy metadata version is greater than its previous version" -Skip:($ModifiedFiles -ne $null) {
      $ModifiedFiles | ForEach-Object {

        $PolicyFile = Split-Path $_ -Leaf
        $PolicyJson = Get-Content -Path $_ -Raw | ConvertFrom-Json
        $PreviousPolicyDefinitionRawUrl = "https://raw.githubusercontent.com/Azure/azure-monitor-baseline-alerts/main/$_"
        $PreviousPolicyDefinitionOutputFile = "./previous-$PolicyFile"
        Invoke-WebRequest -Uri $PreviousPolicyDefinitionRawUrl -OutFile $PreviousPolicyDefinitionOutputFile
        $PreviousPolicyDefinitionsFile = Get-Content $PreviousPolicyDefinitionOutputFile -Raw | ConvertFrom-Json
        $PreviousPolicyDefinitionsFileVersion = $PreviousPolicyDefinitionsFile.properties.metadata.version
        # Write-Warning "$($PolicyFile) - The current metadata version for the policy in the main branch is : $($PreviousPolicyDefinitionsFileVersion)"
        $PolicyMetadataVersion = $PolicyJson.properties.metadata.version
        $PolicyJson = Get-Content -Path $_ -Raw | ConvertFrom-Json
        # Write-Warning "$($PolicyFile) - The current metadata version for the policy in the PR branch is : $($PolicyMetadataVersion)"
        if (!$PreviousPolicyDefinitionsFileVersion.EndsWith("deprecated")) {
          $PolicyMetadataVersion | Should -BeGreaterThan $PreviousPolicyDefinitionsFileVersion -Because "the [version] attribute value of file [$PolicyFile] needs to be incremented when modifying policies."
        }

      }
    }

    It "Check if policy version has been correctly incremented" -Skip:($ModifiedFiles -ne $null) {
      $ModifiedFiles | ForEach-Object {

        $PolicyJson = Get-Content -Path $_ -Raw | ConvertFrom-Json
        $PolicyFile = Split-Path $_ -Leaf
        $PreviousPolicyDefinitionRawUrl = "https://raw.githubusercontent.com/Azure/azure-monitor-baseline-alerts/main/$_"
        $PreviousPolicyDefinitionOutputFile = "./previous-$PolicyFile"
        Invoke-WebRequest -Uri $PreviousPolicyDefinitionRawUrl -OutFile $PreviousPolicyDefinitionOutputFile
        $PreviousPolicyDefinitionsFile = Get-Content $PreviousPolicyDefinitionOutputFile -Raw | ConvertFrom-Json

        #Assembling custom version object for previous policy
        $PreviousPolicyMetadataVersion = Convert-PolicyVersion $PreviousPolicyDefinitionsFile.properties.metadata.version

        #Assembling custom version object for current policy
        $CurrentPolicyMetadataVersion = Convert-PolicyVersion $PolicyJson.properties.metadata.version

        if (($CurrentPolicyMetadataVersion -ne $null ) -and ($PreviousPolicyMetadataVersion -ne $null)) {
          #Write-Warning "$($PolicyFile) - The current metadata version for the policy in the PR branch is : $($CurrentPolicyMetadataVersion). Previous metadata version is : $($PreviousPolicyMetadataVersion)"

          $CurrentPolicyMetadataVersion.Major | Should -Be $PreviousPolicyMetadataVersion.Major -Because "Incrementing the [Major] version of policy version is not supported. Ensure the [Major] version of [$PolicyFile] stay unchanged."

          if ($CurrentPolicyMetadataVersion.Minor -gt $PreviousPolicyMetadataVersion.Minor) {
            $CurrentPolicyMetadataVersion.Patch | Should -Be 0 -Because "Incrementing the [Minor] version of policy version requires the [Patch] version to be reset to 0. When incrementing the [Minor] version , ensure the [Patch] version of [$PolicyFile] is reset to 0."
          }
          elseif ($CurrentPolicyMetadataVersion.Minor -eq $PreviousPolicyMetadataVersion.Minor) {
            $CurrentPolicyMetadataVersion.Patch | Should -BeGreaterThan $PreviousPolicyMetadataVersion.Patch -Because "Incrementing the [Patch] version of policy version is required when [Major] and [Minor] stay unchanged. Ensure the [Patch] version of [$PolicyFile] is incremented by 1."
          }
          else {
            $CurrentPolicyMetadataVersion.Patch | Should -BeGreaterThan $PreviousPolicyMetadataVersion.Patch -Because "The [Patch] version of policy version cannot be decremented. Ensure the [Patch] version of [$PolicyFile] is set the same value it was."
          }
        }

      }
    }

    It "Check deprecated policy contains all required metadata"  -Skip:($ModifiedAddedFiles -ne $null) {
      $ModifiedAddedFiles | ForEach-Object {

        $PolicyJson = Get-Content -Path $_ -Raw | ConvertFrom-Json
        $PolicyFile = Split-Path $_ -Leaf
        $PolicyMetadataVersion = $PolicyJson.properties.metadata.version
        # Write-Warning "$($PolicyFile) - This is the policy metadata version: $($PolicyMetadataVersion)"
        if ($PolicyMetadataVersion.EndsWith("deprecated")) {
          # Write-Warning "$($PolicyFile) - Should have the deprecated metadata flag set to true"
          $PolicyMetadataDeprecated = $PolicyJson.properties.metadata.deprecated
          $PolicyMetadataDeprecated | Should -BeTrue
          # Write-Warning "$($PolicyFile) - Should have the supersededBy metadata value set"
          $PolicyMetadataSuperseded = $PolicyJson.properties.metadata.supersededBy
          $PolicyMetadataSuperseded | Should -Not -BeNullOrEmpty
          # Write-Warning "$($PolicyFile) - [Deprecated] should be in the display name"
          $PolicyPropertiesDisplayName = $PolicyJson.properties.displayName
          $PolicyPropertiesDisplayName | Should -Match "[DEPRECATED]" -Because "the [version] attribute on file [$PolicyFile] needs to end with [DEPRECATED]."
        }

      }
    }

    It "Check policy metadata category exists"  -Skip:($ModifiedAddedFiles -ne $null) {
      $ModifiedAddedFiles | ForEach-Object {

        $PolicyJson = Get-Content -Path $_ -Raw | ConvertFrom-Json
        $PolicyFile = Split-Path $_ -Leaf
        $PolicyMetadataCategories = $PolicyJson.properties.metadata.category
        # Write-Warning "$($PolicyFile) - These are the policy metadata categories: $($PolicyMetadataCategories)"
        $PolicyMetadataCategories | Should -Not -BeNullOrEmpty -Because "the [category] attribute on file [$PolicyFile] is empty."

      }
    }

    It "Check policy metadata source is set to azure-monitor-baseline-alerts repo"  -Skip:($ModifiedAddedFiles -ne $null) {
      $ModifiedAddedFiles | ForEach-Object {

        $PolicyJson = Get-Content -Path $_ -Raw | ConvertFrom-Json
        $PolicyFile = Split-Path $_ -Leaf
        $PolicyMetadataSource = $PolicyJson.properties.metadata.source
        # Write-Warning "$($PolicyFile) - This is the policy source link: $($PolicyMetadataSource)"
        $PolicyMetadataSource | Should -Be 'https://github.com/Azure/azure-monitor-baseline-alerts/' -Because "the [source] attribute on file [$PolicyFile] is not set to [https://github.com/Azure/azure-monitor-baseline-alerts/]."

      }
    }

    <# Commenting this block since ALZ env tag is not that relevant
    It "Check policy metadata ALZ Environments are specified for Public, US Gov or China Clouds"  -Skip:($ModifiedAddedFiles -ne $null) {
      $ModifiedAddedFiles | ForEach-Object {

        $PolicyJson = Get-Content -Path $_ -Raw | ConvertFrom-Json
        $PolicyFile = Split-Path $_ -Leaf
        $AlzEnvironments = @("AzureCloud", "AzureChinaCloud", "AzureUSGovernment")
        $PolicyEnvironments = $PolicyJson.properties.metadata.alzCloudEnvironments
        # Write-Warning "$($PolicyFile) - These are the environments: $($PolicyEnvironments)"
        $PolicyJson.properties.metadata.alzCloudEnvironments | Should -BeIn $AlzEnvironments -Because "the [alzCloudEnvironments] attribute value does not match [AzureCloud] or [AzureChinaCloud] or [AzureUSGovernment] for file [$PolicyFile]."

      }
    }#>

    <# Commenting this block since we use a different name for policy name and file name
    It "Check policy metadata name matches policy filename"  -Skip:($ModifiedAddedFiles -ne $null) {
      $ModifiedAddedFiles | ForEach-Object {

        $PolicyJson = Get-Content -Path $_ -Raw | ConvertFrom-Json
        $PolicyFile = Split-Path $_ -Leaf
        $PolicyMetadataName = $PolicyJson.name
        $PolicyFileNoExt = [System.IO.Path]::GetFileNameWithoutExtension($PolicyFile)
        if ($PolicyFileNoExt.Contains("AzureChinaCloud") -or $PolicyFileNoExt.ContEnterpriains("AzureUSGovernment")) {
          $PolicyFileNoExt = $PolicyFileNoExt.Substring(0, $PolicyFileNoExt.IndexOf("."))
        }
        # Write-Warning "$($PolicyFileNoExt) - This is the policy metadata name: $($PolicyMetadataName)"
        $PolicyMetadataName | Should -Be $PolicyFileNoExt

      }
    }#>
  }

  Context "Validate policy parameters" {
    It 'Check for policy parameters have default values'  -Skip:($ModifiedAddedFiles -ne $null) {
      $ModifiedAddedFiles | ForEach-Object {

        $PolicyJson = Get-Content -Path $_ -Raw | ConvertFrom-Json
        $PolicyFile = Split-Path $_ -Leaf
        $PolicyMetadataName = $PolicyJson.name
        $ExcludePolicy = @()
        $ExcludeParams = @("ALZManagementSubscriptionId", "ALZMonitorActionGroupEmail", "ALZArmRoleId", "ALZLogicappResourceId", "ALZLogicappCallbackUrl", "ALZEventHubResourceId", "ALZWebhookServiceUri", "ALZFunctionResourceId", "ALZFunctionTriggerUrl", "BYOUserAssignedManagedIdentityResourceId", "UAMIResourceId", "BYOActionGroup", "BYOAlertProcessingRule")
        if ($PolicyMetadataName -notin $ExcludePolicy) {
          $PolicyParameters = $PolicyJson.properties.parameters
          if ($PolicyParameters | Get-Member -MemberType NoteProperty) {
            $Parameters = $PolicyParameters | Get-Member -MemberType NoteProperty | Select-Object -Expand Name
            # Write-Warning "$($PolicyFile) - These are the params: $($Parameters)"
            $Parameters = $PolicyParameters | Get-Member -MemberType NoteProperty
            $Parameters | ForEach-Object {
              $key = $_.name
              if ($key -notin $ExcludeParams) {
                $defaultValue = $PolicyParameters.$key | Get-Member -MemberType NoteProperty | Where-Object Name -EQ "defaultValue"
                # Write-Warning "$($PolicyFile) - Parameter: $($key) - Default Value: $($defaultValue)"
                $PolicyParameters.$key.defaultValue | Should -Not -BeNullOrEmpty -Because "the [defaultValue] for parameter [$key] is empty in file [$PolicyFile]."
              }
            }
          }
        }

      }
    }
  }

  AfterAll {
    # These are not the droids you are looking for...
  }
}
