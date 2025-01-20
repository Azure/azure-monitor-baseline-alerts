Describe 'UnitTest-BuildPolicies' {

  BeforeAll {
    Import-Module -Name $PSScriptRoot\PolicyPesterTestHelper.psm1 -Force -Verbose

    New-Item -Name "buildout" -Type Directory

    # Build the PR policies, and initiatives to a temp folder
    bicep build ./patterns/alz/templates/policies-Automation.bicep --outfile ./buildout/policies-Automation.json
    bicep build ./patterns/alz/templates/policies-Compute.bicep --outfile ./buildout/policies-Compute.json
    bicep build ./patterns/alz/templates/policies-Hybrid.bicep --outfile ./buildout/policies-Hybrid.json
    bicep build ./patterns/alz/templates/policies-KeyManagement.bicep --outfile ./buildout/policies-KeyManagement.json
    bicep build ./patterns/alz/templates/policies-Monitoring.bicep --outfile ./buildout/policies-Monitoring.json
    bicep build ./patterns/alz/templates/policies-Network.bicep --outfile ./buildout/policies-Network.json
    bicep build ./patterns/alz/templates/policies-NotificationAssets.bicep --outfile ./buildout/policies-NotificationAssets.json
    bicep build ./patterns/alz/templates/policies-RecoveryServices.bicep --outfile ./buildout/policies-RecoveryServices.json
    bicep build ./patterns/alz/templates/policies-ServiceHealth.bicep --outfile ./buildout/policies-ServiceHealth.json
    bicep build ./patterns/alz/templates/policies-Storage.bicep --outfile ./buildout/policies-Storage.json
    bicep build ./patterns/alz/templates/policies-Web.bicep --outfile ./buildout/policies-Web.json
    bicep build ./patterns/alz/templates/policySets.bicep --outfile ./buildout/policySets.json
  }

  Context "Check Policy Builds" {

    It "Check Automation policies build done" {
      $prFile = "./patterns/alz/policyDefinitions/policies-Automation.json"
      $buildFile = "./buildout/policies-Automation.json"

      $buildJson = Remove-JSONMetadata -TemplateObject (Get-Content $buildFile -Raw | ConvertFrom-Json -Depth 99 -AsHashtable)
      $buildJson = ConvertTo-OrderedHashtable -JSONInputObject (ConvertTo-Json $buildJson -Depth 99)

      $prJson = Remove-JSONMetadata -TemplateObject (Get-Content $prFile -Raw | ConvertFrom-Json -Depth 99 -AsHashtable)
      $prJson = ConvertTo-OrderedHashtable -JSONInputObject (ConvertTo-Json $prJson -Depth 99)

      # Compare files we built to the PR files
            (ConvertTo-Json $buildJson -Depth 99) | Should -Be (ConvertTo-Json $prJson -Depth 99) -Because "the [policies-Automation.json] should be based on the latest [policies-Automation.bicep] file. Please run [` bicep build ./patterns/alz/templates/policies-Automation.bicep --outfile ./patterns/alz/policyDefinitions/policies-Automation.json `] using the latest Bicep CLI version."
    }

    It "Check Compute policies build done" {
      $prFile = "./patterns/alz/policyDefinitions/policies-Compute.json"
      $buildFile = "./buildout/policies-Compute.json"

      $buildJson = Remove-JSONMetadata -TemplateObject (Get-Content $buildFile -Raw | ConvertFrom-Json -Depth 99 -AsHashtable)
      $buildJson = ConvertTo-OrderedHashtable -JSONInputObject (ConvertTo-Json $buildJson -Depth 99)

      $prJson = Remove-JSONMetadata -TemplateObject (Get-Content $prFile -Raw | ConvertFrom-Json -Depth 99 -AsHashtable)
      $prJson = ConvertTo-OrderedHashtable -JSONInputObject (ConvertTo-Json $prJson -Depth 99)

      # Compare files we built to the PR files
            (ConvertTo-Json $buildJson -Depth 99) | Should -Be (ConvertTo-Json $prJson -Depth 99) -Because "the [policies-Compute.json] should be based on the latest [policies-Compute.bicep] file. Please run [` bicep build ./patterns/alz/templates/policies-Compute.bicep --outfile ./patterns/alz/policyDefinitions/policies-Compute.json `] using the latest Bicep CLI version."
    }

    It "Check Hybrid policies build done" {
      $prFile = "./patterns/alz/policyDefinitions/policies-Hybrid.json"
      $buildFile = "./buildout/policies-Hybrid.json"

      $buildJson = Remove-JSONMetadata -TemplateObject (Get-Content $buildFile -Raw | ConvertFrom-Json -Depth 99 -AsHashtable)
      $buildJson = ConvertTo-OrderedHashtable -JSONInputObject (ConvertTo-Json $buildJson -Depth 99)

      $prJson = Remove-JSONMetadata -TemplateObject (Get-Content $prFile -Raw | ConvertFrom-Json -Depth 99 -AsHashtable)
      $prJson = ConvertTo-OrderedHashtable -JSONInputObject (ConvertTo-Json $prJson -Depth 99)

      # Compare files we built to the PR files
            (ConvertTo-Json $buildJson -Depth 99) | Should -Be (ConvertTo-Json $prJson -Depth 99) -Because "the [policies-Hybrid.json] should be based on the latest [policies-Hybrid.bicep] file. Please run [` bicep build ./patterns/alz/templates/policies-Hybrid.bicep --outfile ./patterns/alz/policyDefinitions/policies-Hybrid.json `] using the latest Bicep CLI version."
    }

    It "Check KeyManagement policies build done" {
      $prFile = "./patterns/alz/policyDefinitions/policies-KeyManagement.json"
      $buildFile = "./buildout/policies-KeyManagement.json"

      $buildJson = Remove-JSONMetadata -TemplateObject (Get-Content $buildFile -Raw | ConvertFrom-Json -Depth 99 -AsHashtable)
      $buildJson = ConvertTo-OrderedHashtable -JSONInputObject (ConvertTo-Json $buildJson -Depth 99)

      $prJson = Remove-JSONMetadata -TemplateObject (Get-Content $prFile -Raw | ConvertFrom-Json -Depth 99 -AsHashtable)
      $prJson = ConvertTo-OrderedHashtable -JSONInputObject (ConvertTo-Json $prJson -Depth 99)

      # Compare files we built to the PR files
            (ConvertTo-Json $buildJson -Depth 99) | Should -Be (ConvertTo-Json $prJson -Depth 99) -Because "the [policies-KeyManagement.json] should be based on the latest [policies-KeyManagement.bicep] file. Please run [` bicep build ./patterns/alz/templates/policies-KeyManagement.bicep --outfile ./patterns/alz/policyDefinitions/policies-KeyManagement.json `] using the latest Bicep CLI version."
    }

    It "Check Monitoring policies build done" {
      $prFile = "./patterns/alz/policyDefinitions/policies-Monitoring.json"
      $buildFile = "./buildout/policies-Monitoring.json"

      $buildJson = Remove-JSONMetadata -TemplateObject (Get-Content $buildFile -Raw | ConvertFrom-Json -Depth 99 -AsHashtable)
      $buildJson = ConvertTo-OrderedHashtable -JSONInputObject (ConvertTo-Json $buildJson -Depth 99)

      $prJson = Remove-JSONMetadata -TemplateObject (Get-Content $prFile -Raw | ConvertFrom-Json -Depth 99 -AsHashtable)
      $prJson = ConvertTo-OrderedHashtable -JSONInputObject (ConvertTo-Json $prJson -Depth 99)

      # Compare files we built to the PR files
            (ConvertTo-Json $buildJson -Depth 99) | Should -Be (ConvertTo-Json $prJson -Depth 99) -Because "the [policies-Monitoring.json] should be based on the latest [policies-Monitoring.bicep] file. Please run [` bicep build ./patterns/alz/templates/policies-Monitoring.bicep --outfile ./patterns/alz/policyDefinitions/policies-Monitoring.json `] using the latest Bicep CLI version."
    }

    It "Check Network policies build done" {
      $prFile = "./patterns/alz/policyDefinitions/policies-Network.json"
      $buildFile = "./buildout/policies-Network.json"

      $buildJson = Remove-JSONMetadata -TemplateObject (Get-Content $buildFile -Raw | ConvertFrom-Json -Depth 99 -AsHashtable)
      $buildJson = ConvertTo-OrderedHashtable -JSONInputObject (ConvertTo-Json $buildJson -Depth 99)

      $prJson = Remove-JSONMetadata -TemplateObject (Get-Content $prFile -Raw | ConvertFrom-Json -Depth 99 -AsHashtable)
      $prJson = ConvertTo-OrderedHashtable -JSONInputObject (ConvertTo-Json $prJson -Depth 99)

      # Compare files we built to the PR files
            (ConvertTo-Json $buildJson -Depth 99) | Should -Be (ConvertTo-Json $prJson -Depth 99) -Because "the [policies-Network.json] should be based on the latest [policies-Network.bicep] file. Please run [` bicep build ./patterns/alz/templates/policies-Network.bicep --outfile ./patterns/alz/policyDefinitions/policies-Network.json `] using the latest Bicep CLI version."
    }

    It "Check NotificationAssets policies build done" {
      $prFile = "./patterns/alz/policyDefinitions/policies-NotificationAssets.json"
      $buildFile = "./buildout/policies-NotificationAssets.json"

      $buildJson = Remove-JSONMetadata -TemplateObject (Get-Content $buildFile -Raw | ConvertFrom-Json -Depth 99 -AsHashtable)
      $buildJson = ConvertTo-OrderedHashtable -JSONInputObject (ConvertTo-Json $buildJson -Depth 99)

      $prJson = Remove-JSONMetadata -TemplateObject (Get-Content $prFile -Raw | ConvertFrom-Json -Depth 99 -AsHashtable)
      $prJson = ConvertTo-OrderedHashtable -JSONInputObject (ConvertTo-Json $prJson -Depth 99)

      # Compare files we built to the PR files
            (ConvertTo-Json $buildJson -Depth 99) | Should -Be (ConvertTo-Json $prJson -Depth 99) -Because "the [policies-NotificationAssets.json] should be based on the latest [policies-NotificationAssets.bicep] file. Please run [` bicep build ./patterns/alz/templates/policies-NotificationAssets.bicep --outfile ./patterns/alz/policyDefinitions/policies-NotificationAssets.json `] using the latest Bicep CLI version."
    }

    It "Check RecoveryServices policies build done" {
      $prFile = "./patterns/alz/policyDefinitions/policies-RecoveryServices.json"
      $buildFile = "./buildout/policies-RecoveryServices.json"

      $buildJson = Remove-JSONMetadata -TemplateObject (Get-Content $buildFile -Raw | ConvertFrom-Json -Depth 99 -AsHashtable)
      $buildJson = ConvertTo-OrderedHashtable -JSONInputObject (ConvertTo-Json $buildJson -Depth 99)

      $prJson = Remove-JSONMetadata -TemplateObject (Get-Content $prFile -Raw | ConvertFrom-Json -Depth 99 -AsHashtable)
      $prJson = ConvertTo-OrderedHashtable -JSONInputObject (ConvertTo-Json $prJson -Depth 99)

      # Compare files we built to the PR files
            (ConvertTo-Json $buildJson -Depth 99) | Should -Be (ConvertTo-Json $prJson -Depth 99) -Because "the [policies-RecoveryServices.json] should be based on the latest [policies-RecoveryServices.bicep] file. Please run [` bicep build ./patterns/alz/templates/policies-RecoveryServices.bicep --outfile ./patterns/alz/policyDefinitions/policies-RecoveryServices.json `] using the latest Bicep CLI version."
    }

    It "Check ServiceHealth policies build done" {
      $prFile = "./patterns/alz/policyDefinitions/policies-ServiceHealth.json"
      $buildFile = "./buildout/policies-ServiceHealth.json"

      $buildJson = Remove-JSONMetadata -TemplateObject (Get-Content $buildFile -Raw | ConvertFrom-Json -Depth 99 -AsHashtable)
      $buildJson = ConvertTo-OrderedHashtable -JSONInputObject (ConvertTo-Json $buildJson -Depth 99)

      $prJson = Remove-JSONMetadata -TemplateObject (Get-Content $prFile -Raw | ConvertFrom-Json -Depth 99 -AsHashtable)
      $prJson = ConvertTo-OrderedHashtable -JSONInputObject (ConvertTo-Json $prJson -Depth 99)

      # Compare files we built to the PR files
            (ConvertTo-Json $buildJson -Depth 99) | Should -Be (ConvertTo-Json $prJson -Depth 99) -Because "the [policies-ServiceHealth.json] should be based on the latest [policies-ServiceHealth.bicep] file. Please run [` bicep build ./patterns/alz/templates/policies-ServiceHealth.bicep --outfile ./patterns/alz/policyDefinitions/policies-ServiceHealth.json `] using the latest Bicep CLI version."
    }

    It "Check Storage policies build done" {
      $prFile = "./patterns/alz/policyDefinitions/policies-Storage.json"
      $buildFile = "./buildout/policies-Storage.json"

      $buildJson = Remove-JSONMetadata -TemplateObject (Get-Content $buildFile -Raw | ConvertFrom-Json -Depth 99 -AsHashtable)
      $buildJson = ConvertTo-OrderedHashtable -JSONInputObject (ConvertTo-Json $buildJson -Depth 99)

      $prJson = Remove-JSONMetadata -TemplateObject (Get-Content $prFile -Raw | ConvertFrom-Json -Depth 99 -AsHashtable)
      $prJson = ConvertTo-OrderedHashtable -JSONInputObject (ConvertTo-Json $prJson -Depth 99)

      # Compare files we built to the PR files
            (ConvertTo-Json $buildJson -Depth 99) | Should -Be (ConvertTo-Json $prJson -Depth 99) -Because "the [policies-Storage.json] should be based on the latest [policies-Storage.bicep] file. Please run [` bicep build ./patterns/alz/templates/policies-Storage.bicep --outfile ./patterns/alz/policyDefinitions/policies-Storage.json `] using the latest Bicep CLI version."
    }

    It "Check Web policies build done" {
      $prFile = "./patterns/alz/policyDefinitions/policies-Web.json"
      $buildFile = "./buildout/policies-Web.json"

      $buildJson = Remove-JSONMetadata -TemplateObject (Get-Content $buildFile -Raw | ConvertFrom-Json -Depth 99 -AsHashtable)
      $buildJson = ConvertTo-OrderedHashtable -JSONInputObject (ConvertTo-Json $buildJson -Depth 99)

      $prJson = Remove-JSONMetadata -TemplateObject (Get-Content $prFile -Raw | ConvertFrom-Json -Depth 99 -AsHashtable)
      $prJson = ConvertTo-OrderedHashtable -JSONInputObject (ConvertTo-Json $prJson -Depth 99)

      # Compare files we built to the PR files
            (ConvertTo-Json $buildJson -Depth 99) | Should -Be (ConvertTo-Json $prJson -Depth 99) -Because "the [policies-Web.json] should be based on the latest [policies-Web.bicep] file. Please run [` bicep build ./patterns/alz/templates/policies-Web.bicep --outfile ./patterns/alz/policyDefinitions/policies-Web.json `] using the latest Bicep CLI version."
    }

    It "Check PolicySets build done" {
      $prFile = "./patterns/alz/policyDefinitions/policySets.json"
      $buildFile = "./buildout/policySets.json"

      $buildJson = Remove-JSONMetadata -TemplateObject (Get-Content $buildFile -Raw | ConvertFrom-Json -Depth 99 -AsHashtable)
      $buildJson = ConvertTo-OrderedHashtable -JSONInputObject (ConvertTo-Json $buildJson -Depth 99)

      $prJson = Remove-JSONMetadata -TemplateObject (Get-Content $prFile -Raw | ConvertFrom-Json -Depth 99 -AsHashtable)
      $prJson = ConvertTo-OrderedHashtable -JSONInputObject (ConvertTo-Json $prJson -Depth 99)

      # Compare files we built to the PR files
            (ConvertTo-Json $buildJson -Depth 99) | Should -Be (ConvertTo-Json $prJson -Depth 99) -Because "the [policySets.json] should be based on the latest [policySets.bicep] file. Please run [` bicep build ./patterns/alz/templates/policySets.bicep --outfile ./patterns/alz/policyDefinitions/policySets.json `] using the latest Bicep CLI version."
    }

  }

  AfterAll {
    # These are not the droids you are looking for...
  }
}
