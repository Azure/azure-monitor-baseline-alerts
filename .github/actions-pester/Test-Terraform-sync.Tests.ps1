Describe "UnitTest-CompareEslzTerraform-Sync" {

  BeforeAll {
    Import-Module -Name $PSScriptRoot\PolicyPesterTestHelper.psm1 -Force

    # Setting param files to be compared
    $alzArmParam = "./patterns/alz/alzarm.param.json"
    $eslzTerraform = "./patterns/alz/eslzArm.terraform-sync.param.json"

    # Loading file content
    $alzArmParamJson = Get-Content -Raw -Path $alzArmParam | ConvertFrom-Json
    $eslzTerraformJson = Get-Content -Raw -Path $eslzTerraform | ConvertFrom-Json

    $alzArmParamJsonParams = $alzArmParamJson.parameters | Get-Member -MemberType NoteProperty
    $eslzTerraformJsonParams = $eslzTerraformJson.parameters | Get-Member -MemberType NoteProperty

    #$ExcludePolicy = @()
    #$ExcludeParams = @("ALZManagementSubscriptionId", "BYOUserAssignedManagedIdentityResourceId")

  }

  Context "Validate parameter names" {
    It "Check param files have the same parameters" {

      #Comparing parameter names
      foreach ($key in $alzArmParamJsonParams) {
        $paramName = $_.Name
        $_.Name | Should -Be $eslzTerraformJsonParams.$paramName -Because "the parameter name [$paramName] is not existing in file [eslzArm.terraform-sync.param.json] and must be added."
      }
    }
  }

  <#Context "Validate parameter values" {
    It "Check params have the default values" {

      # Comparing parameter values
      foreach ($key in $alzArmParamJson.parameters) {
        $Key | Should -Be $eslzTerraformJson.parameter.$key -Because "The key parameter [$key] is not present on file [eslzArm.terraform-sync.param.json] and must be added."
      }
  }#>

  AfterAll {
    # These are not the droids you are looking for...
  }
}
