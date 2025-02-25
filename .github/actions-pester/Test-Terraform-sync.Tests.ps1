Describe "UnitTest-CompareEslzTerraform-Sync" {

  BeforeAll {
    Import-Module -Name $PSScriptRoot\PolicyPesterTestHelper.psm1 -Force

    # Setting param files to be compared
    $alzArmFile = "./patterns/alz/alzArm.param.json"
    $eslzTerraformFile = "./patterns/alz/eslzArm.terraform-sync.param.json"

    $alzArmFileName = Split-Path $alzArmFile -Leaf
    $eslzTerraformFileName = Split-Path $eslzTerraformFile -Leaf

    # Loading file content
    $alzArmJson = Get-Content -Raw -Path $alzArmFile | ConvertFrom-Json
    $eslzTerraformJson = Get-Content -Raw -Path $eslzTerraformFile | ConvertFrom-Json

    $alzArmParameters = $alzArmJson.parameters | Get-Member -MemberType NoteProperty
    $eslzTerraformParameters = $eslzTerraformJson.parameters | Get-Member -MemberType NoteProperty

    #$ExcludePolicy = @()
    #$ExcludeParams = @("ALZManagementSubscriptionId", "BYOUserAssignedManagedIdentityResourceId")

  }

  Context "Validate parameter names sync between [alzArm.param.json] and [eslzArm.terraform-sync.param.json]" {
    It "Check for existence of parameters defined in [alzArm.param.json] inside file [eslzArm.terraform-sync.param.json]" {

      #Comparing parameter names
      $alzArmParameters | ForEach-Object {

        $alzArmParamName = $_.Name

        # Validating params from flat entries
        if ($alzArmParamName -notlike "policyAssignmentParameters*") {
          $eslzTerraformParamName = $eslzTerraformParameters | Where-Object Name -EQ $alzArmParamName | Select-Object -ExpandProperty Name
          #Write-Warning "Testing the existence of parameter name [$alzArmParamName] in both files [$alzArmFileName] and [$eslzTerraformFileName]."
          $alzArmParamName | Should -Be $eslzTerraformParamName -Because "the parameter name [$alzArmParamName] is not existing in file [$eslzTerraformFileName]. Files should be aligned."
        }
        else {
          # Validating params from nested entries
          Write-Warning "These are not the droids you are looking for..."
          #$alzArmParamName = $_.Name
          #$eslzTerraformParam = $eslzTerraformParameters | Where-Object Name -EQ $alzArmParamName
          #Write-Warning "Testing parameter name [$alzArmParamName] to be present in both files [$alzArmFileName] and [$eslzTerraformFileName]."
          #$alzArmParamName | Should -Be $eslzTerraformParam -Because "the parameter name [$alzArmParamName] is not existing in file [$eslzTerraformFileName]. Files should be aligned."
        }
      }
    }

    It "Check for existence of parameters defined in [eslzArm.terraform-sync.param.json] inside file [alzArm.param.json]" {

      #Comparing parameter names
      $eslzTerraformParameters | ForEach-Object {

        $eslzTerraformParamName = $_.Name

        # Validating params from flat entries
        if ($eslzTerraformParamName -notlike "policyAssignmentParameters*") {
          $alzArmParamName = $alzArmParameters | Where-Object Name -EQ $eslzTerraformParamName | Select-Object -ExpandProperty Name
          #Write-Warning "Testing the existence of parameter name [$eslzTerraformParamName] in both files [$eslzTerraformFileName] and [$alzArmFileName]."
          $eslzTerraformParamName | Should -Be $alzArmParamName -Because "the parameter name [$eslzTerraformParamName] is not existing in file [$alzArmFileName]. Files should be aligned."
        }
        else {
          # Validating params from nested entries
          Write-Warning "These are not the droids you are looking for..."
          #$alzArmParamName = $_.Name
          #$eslzTerraformParam = $BR1 | Where-Object Name -EQ $alzArmParamName
          #Write-Warning "Testing parameter name [$alzArmParamName] to be present in both files [$alzArmFileName] and [$eslzTerraformFileName]."
          #$alzArmParamName | Should -Be $eslzTerraformParam -Because "the parameter name [$alzArmParamName] is not existing in file [$eslzTerraformFileName]. Files should be aligned."
        }
      }
    }
  }

  <#Context "Validate parameter values" {
    It "Check params have the default values" {

      # Comparing parameter values
      foreach ($key in $alzArmJson.parameters) {
        $Key | Should -Be $eslzTerraformJson.parameter.$key -Because "The key parameter [$key] is not present on file [eslzArm.terraform-sync.param.json] and must be added."
      }
    }
  }#>

  AfterAll {
    # These are not the droids you are looking for...
  }
}
