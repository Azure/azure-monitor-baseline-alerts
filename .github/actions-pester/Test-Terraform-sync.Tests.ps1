Describe "UnitTest-CompareEslzTerraform-Sync" {

  BeforeAll {
    #Import-Module -Name $PSScriptRoot\PolicyPesterTestHelper.psm1 -Force

    # Setting param files to be compared
    $alzArmFile = "./patterns/alz/alzArm.param.json"
    $eslzTerraformFile = "./patterns/alz/eslzArm.terraform-sync.param.json"

    # Extracting file name from path
    $alzArmFileName = Split-Path $alzArmFile -Leaf
    $eslzTerraformFileName = Split-Path $eslzTerraformFile -Leaf

    # Loading file content
    $alzArmJson = Get-Content -Raw -Path $alzArmFile | ConvertFrom-Json -Depth 99 -AsHashtable
    $eslzTerraformJson = Get-Content -Raw -Path $eslzTerraformFile | ConvertFrom-Json -Depth 99 -AsHashtable

    # Creating hashtable of parameters
    $alzArmParameters = $alzArmJson.parameters
    $eslzTerraformParameters = $eslzTerraformJson.parameters  }

  Context "Validate parameter names sync between [alzArm.param.json] and [eslzArm.terraform-sync.param.json]" {
    It "Check for existence of parameters defined in [alzArm.param.json] inside file [eslzArm.terraform-sync.param.json]" {

      #Comparing parameter names
      $alzArmParameters.keys | ForEach-Object {

        $alzArmParamName = $_

        if (($alzArmParamName -notlike "policyAssignmentParameters*") -and ($alzArmParamName -notlike "ALZMonitorResourceGroupTags")) {
          # Validating params from flat entries
          $eslzTerraformParamName = $eslzTerraformParameters.keys | Where-Object {$_ -like "$alzArmParamName"}
          #Write-Warning "Testing the existence of parameter name [$alzArmParamName] in both files [$alzArmFileName] and [$eslzTerraformFileName]."
          $alzArmParamName | Should -Be $eslzTerraformParamName -Because "the parameter name [$alzArmParamName] is not existing in file [$eslzTerraformFileName]. Files should be aligned."
        }
        else {

          # Validating params from nested entries
          $alzArmParamObj = $alzArmParameters["$alzArmParamName"].values

          $alzArmParamObj.keys | ForEach-Object {
            $alzArmParamName2 = $_
            $eslzTerraformParam2 = $eslzTerraformParameters["$alzArmParamName"].values.keys | Where-Object {$_ -like "$alzArmParamName2"}
            #Write-Warning "Testing parameter name [$alzArmParamName2] to be present in both files [$alzArmFileName] and [$eslzTerraformFileName]."
            $alzArmParamName2 | Should -Be $eslzTerraformParam2 -Because "the parameter name [$alzArmParamName2] is not existing in file [$eslzTerraformFileName]. Files should be aligned."
          }
        }
      }
    }

    It "Check for existence of parameters defined in [eslzArm.terraform-sync.param.json] inside file [alzArm.param.json]" {

      #Comparing parameter names
      $eslzTerraformParameters.keys | ForEach-Object {

        $eslzTerraformParamName = $_

        if (($eslzTerraformParamName -notlike "policyAssignmentParameters*") -and ($eslzTerraformParamName -notlike "ALZMonitorResourceGroupTags")) {

          # Validating params from flat entries
          $alzArmParamName = $alzArmParameters.keys | Where-Object {$_ -like "$eslzTerraformParamName"}
          #Write-Warning "Testing the existence of parameter name [$eslzTerraformParamName] in both files [$eslzTerraformFileName] and [$alzArmFileName]."
          $eslzTerraformParamName | Should -Be $alzArmParamName -Because "the parameter name [$eslzTerraformParamName] is not existing in file [$alzArmFileName]. Files should be aligned."
        }
        else {

          # Validating params from nested entries
          $eslzTerraformParamObj = $eslzTerraformParameters["$eslzTerraformParamName"].values

          $eslzTerraformParamObj.keys | ForEach-Object{
            $eslzTerraformParamName2 = $_
            $alzArmParam2 = $alzArmParameters["$eslzTerraformParamName"].values.keys | Where-Object {$_ -like "$eslzTerraformParamName2"}
            #Write-Warning "Testing parameter name [$eslzTerraformParamName2] to be present in both files [$eslzTerraformFileName] and [$alzArmFileName]."
            $eslzTerraformParamName2 | Should -Be $alzArmParam2 -Because "the parameter name [$eslzTerraformParamName2] is not existing in file [$alzArmFileName]. Files should be aligned."
          }
        }
      }
    }
  }

  Context "Validate parameter values sync between [alzArm.param.json] and [eslzArm.terraform-sync.param.json]" {
    It "Check for parameters default values to be the same between files [alzArm.param.json] and [eslzArm.terraform-sync.param.json]" {

      #Setting excluded params that must have different values according to TF requirements
      $ExcludeParams = @("enterpriseScaleCompanyPrefix", "platformManagementGroup", "IdentityManagementGroup", "managementManagementGroup", "connectivityManagementGroup", "LandingZoneManagementGroup", "bringYourOwnUserAssignedManagedIdentityResourceId", "managementSubscriptionId", "ALZMonitorActionGroupEmail")

      #Comparing parameter names
      $alzArmParameters.keys | ForEach-Object {

        $alzArmParamName = $_

        if (($alzArmParamName -notlike "policyAssignment*") -and ($alzArmParamName -notlike "ALZMonitorResourceGroupTags")) {

          #Executing only if param is not excluded
          if($alzArmParamName -notin $ExcludeParams) {

            # Validating params from flat entries
            $alzArmParamValue = $alzArmParameters["$alzArmParamName"].values
            $eslzTerraformParamValue = $eslzTerraformParameters["$alzArmParamName"].values
            #Write-Warning "Testing the value of parameter name [$alzArmParamName] in both files [$alzArmFileName] and [$eslzTerraformFileName]."
            $alzArmParamValue | Should -Be $eslzTerraformParamValue -Because "the value of parameter [$alzArmParamName] in file [$alzArmFileName] should be the same used for parameter [$alzArmParamName] in file [$eslzTerraformFileName]. Files should be aligned."
          }
        }
        else {

          # Validating params from nested entries
          $alzArmParamObj = $alzArmParameters["$alzArmParamName"].values

          $alzArmParamObj.keys | ForEach-Object {
            $alzArmParamName2 = $_
            if($alzArmParamObj.$alzArmParamName2.GetType().Name -eq "String") {
              $alzArmParamValue2 = $alzArmParamObj.$alzArmParamName2
            }
            else {
              $alzArmParamValue2 = $alzArmParamObj.$alzArmParamName2.value
            }

            #Executing only if param is not excluded
            if($alzArmParamName2 -notin $ExcludeParams) {
              # Getting param value from the other file
              $eslzTerraformParamObj = $eslzTerraformParameters["$alzArmParamName"].values
              $eslzTerraformParamObj.keys | ForEach-Object {
                $eslzTerraformParamName2 = $_
                if($eslzTerraformParamName2 -eq $alzArmParamName2) {
                  if($eslzTerraformParamObj.$eslzTerraformParamName2.GetType().Name -eq "String") {
                    $eslzTerraformParamValue2 = $eslzTerraformParamObj.$eslzTerraformParamName2

                  }
                  else {
                    $eslzTerraformParamValue2 = $eslzTerraformParamObj.$eslzTerraformParamName2.value
                  }
                  #Write-Warning "Testing the value of parameter name [$alzArmParamName2] in both files [$alzArmFileName] and [$eslzTerraformFileName]."
                  $alzArmParamValue2 | Should -Be $eslzTerraformParamValue2 -Because "the value of parameter [$alzArmParamName2] in file [$alzArmFileName] should be the same used for parameter [$eslzTerraformParamName2] in file [$eslzTerraformFileName]. Files should be aligned."
                }
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
