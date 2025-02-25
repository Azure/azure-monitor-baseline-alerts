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

  Context "Validate parameter names" {
    It "Check param files have the same parameters" {

    #Comparing parameter names
    foreach ($key in $alzArmParameters) {

      # Validating params from flat entries
      if ($_.Name -notlike "policyAssignmentParameters*") {
        $paramName = $_.Name
        $eslzTerraformParam = $eslzTerraformParameters | Where-Object Name -EQ $paramName
        Write-Warning "Testing parameter name [$paramName] to be present in both files [$alzArmFileName] and [$eslzTerraformFileName]."
        $paramName | Should -Be $eslzTerraformParam -Because "the parameter name [$paramName] is not existing in file [$eslzTerraformFileName] and must be added."
      }
      else {
        # Validating params from nested entries
        Write-Information "These are not the droids you are looking for..."
        <#$paramName = $_.Name
        $eslzTerraformParam = $eslzTerraformParameters | Where-Object Name -EQ $paramName
        Write-Warning "Testing parameter name [$paramName] to be present in both files [$alzArmFileName] and [$eslzTerraformFileName]."
        $paramName | Should -Be $eslzTerraformParam -Because "the parameter name [$paramName] is not existing in file [$eslzTerraformFileName] and must be added."
      }#>
    }
  }

  <#Context "Validate parameter values" {
    It "Check params have the default values" {

      # Comparing parameter values
      foreach ($key in $alzArmJson.parameters) {
        $Key | Should -Be $eslzTerraformJson.parameter.$key -Because "The key parameter [$key] is not present on file [eslzArm.terraform-sync.param.json] and must be added."
      }
  }#>

  AfterAll {
    # These are not the droids you are looking for...
  }
}
