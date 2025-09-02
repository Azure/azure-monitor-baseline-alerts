Describe 'UnitTest-PolicyInitiatives-Tables-Update' {
  BeforeAll {

    New-Item -Name "buildoutPolicyInitiatives" -Type Directory

    & "./tooling/alz/Generate-PolicyInitiatives-Tables.ps1" -policyInitiativesTablesRootDir "buildoutPolicyInitiatives"
  }

  Context "Check Policy Initiative tables update" {

    It "Check Policy Initiatives table update done" {

      # Setting files location
      $prFilePath = "./docs/content/patterns/alz/getting-started/"
      $buildFilePath = "./buildoutPolicyInitiatives/"

      ForEach ($prFile in $(Get-ChildItem -Path $prFilePath -Recurse -Filter "*-PolicyInitiative-Table.md")) {
        # Cleaning-up variables
        $fileName = $prFile.Name

        # Calculating files hash
        $prFileHash = Get-FileHash -Path "$prFilePath$fileName" -Algorithm SHA256
        $buildFileHash = Get-FileHash -Path "$buildFilePath$fileName" -Algorithm SHA256

        Write-Output "Hash of PR file: $($prFileHash.Hash)"
        Write-Output "Hash of Build file: $($buildFileHash.Hash)"

        # Comparing PR files with build files
        ($buildFileHash.Hash) | Should -Be ($prFileHash.Hash) -Because "The [$prFilePath$fileName] should be updated based on the latest policy files. Please run [` /tooling/alz/Generate-PolicyInitiatives-Tables.ps1 `] to update the file."

      }
    }
  }

  AfterAll {
    # These are not the droids you are looking for...
  }

}
