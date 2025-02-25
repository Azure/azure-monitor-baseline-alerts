Describe "UnitTest-CompareEslzTerraform-Sync" {

  BeforeAll {
    Import-Module -Name $PSScriptRoot\PolicyPesterTestHelper.psm1 -Force

    # Setting param files to be compared
    $alzArmFile = "./patterns/alz/alzArm.param.json"
    $eslzTerraformFile = "./patterns/alz/eslzArm.terraform-sync.param.json"

    $alzArmFileName = Split-Path $alzArmFile -Leaf
    $eslzTerraformFileName = Split-Path $eslzTerraformFile -Leaf

    # Loading file content
    $alzArmJson = Get-Content -Raw -Path $alzArmFile | ConvertFrom-Json -Depth 99 -AsHashtable
    $eslzTerraformJson = Get-Content -Raw -Path $eslzTerraformFile | ConvertFrom-Json -Depth 99 -AsHashtable

    $alzArmParameters = $alzArmJson.parameters
    $eslzTerraformParameters = $eslzTerraformJson.parameters

    #$ExcludePolicy = @()
    #$ExcludeParams = @("ALZManagementSubscriptionId", "BYOUserAssignedManagedIdentityResourceId")

  }

  Context "Validate parameter names sync between [alzArm.param.json] and [eslzArm.terraform-sync.param.json]" {
    It "Check for existence of parameters defined in [alzArm.param.json] inside file [eslzArm.terraform-sync.param.json]" {

      #Comparing parameter names
      $alzArmParameters.keys | ForEach-Object {

        $alzArmParamName = $_
        Write-Warning "This is param name: [$alzArmParamName]"

        if ($alzArmParamName -notlike "policyAssignmentParameters*") {

          # Validating params from flat entries
          $eslzTerraformParamName = $eslzTerraformParameters.keys | Where-Object {$_ -like "$alzArmParamName"}
          #Write-Warning "Testing the existence of parameter name [$alzArmParamName] in both files [$alzArmFileName] and [$eslzTerraformFileName]."
          $alzArmParamName | Should -Be $eslzTerraformParamName -Because "the parameter name [$alzArmParamName] is not existing in file [$eslzTerraformFileName]. Files should be aligned."
        }
        else {

          # Validating params from nested entries
          $alzArmParamObject = $_ | Select-Object -ExpandProperty Definition
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

  <#Context "Validate parameter values sync between [alzArm.param.json] and [eslzArm.terraform-sync.param.json]" {
    It "Check for parameters default values to be the same between files [alzArm.param.json] and [eslzArm.terraform-sync.param.json]" {


    }

    It "Check for parameters default values to be the same between files [eslzArm.terraform-sync.param.json] and [alzArm.param.json]" {


    }
  }#>

  AfterAll {
    # These are not the droids you are looking for...
  }
}
