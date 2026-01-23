Describe 'UnitTest-PolicyInitiatives-Tables-Update' {
  BeforeAll {

    $script:GetNormalizedFileHash = {
      param(
        [Parameter(Mandatory = $true)]
        [string]$Path
      )

      $content = Get-Content -Raw -Path $Path -Encoding utf8
      $normalized = $content -replace "`r`n", "`n" -replace "`r", "`n"
      $bytes = [System.Text.UTF8Encoding]::new($false).GetBytes($normalized)
      $sha256 = [System.Security.Cryptography.SHA256]::Create()
      $hashBytes = $sha256.ComputeHash($bytes)
      $hash = ($hashBytes | ForEach-Object { $_.ToString('x2') }) -join ''

      return [pscustomobject]@{ Hash = $hash.ToUpper() }
    }

    If ([string]::IsNullOrEmpty($(get-item "buildoutPolicyInitiatives" -ErrorAction SilentlyContinue).name)) {
      New-Item -Name "buildoutPolicyInitiatives" -Type Directory
    }

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
        $prFileHash = & $script:GetNormalizedFileHash -Path "$prFilePath$fileName"
        $buildFileHash = & $script:GetNormalizedFileHash -Path "$buildFilePath$fileName"

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
