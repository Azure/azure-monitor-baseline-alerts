function Get-NormalizedFileHash {
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

Describe 'UnitTest-AlertsDetails-Tables-Update' {
  BeforeAll {

    if ([string]::IsNullOrEmpty($(Get-Item "buildoutAlertsDetails" -ErrorAction SilentlyContinue).name)) {
      New-Item -Name "buildoutAlertsDetails" -Type Directory
    }

    & "./tooling/alz/Generate-AlertsDetails-Tables.ps1" -alertTablesRootDir "buildoutAlertsDetails"
  }

  Context "Check Alerts Details tables update" {

    It "Check Alerts Details table for ActivityLog alerts update done" {

      # Setting files location
      $prFile = "./docs/content/patterns/alz/getting-started/Activity-Log-Alerts-Table.md"
      $buildFile = "./buildoutAlertsDetails/Activity-Log-Alerts-Table.md"

      # Calculating files hash
      $prFileHash = Get-NormalizedFileHash -Path $prFile
      $buildFileHash = Get-NormalizedFileHash -Path $buildFile

      Write-Output "Hash of PR file: $($prFileHash.Hash)"
      Write-Output "Hash of Build file: $($buildFileHash.Hash)"

      # Comparing PR files with build files
      ($buildFileHash.Hash) | Should -Be ($prFileHash.Hash) -Because "The [$prFile] should be updated based on the latest policy files. Please run [` /tooling/alz/Generate-AlertsDetails-Tables.ps1 `] to update the file."

    }

    It "Check Alerts Details table for Log-Search alerts update done" {

      # Setting files location
      $prFile = "./docs/content/patterns/alz/getting-started/Log-Search-Alerts-Table.md"
      $buildFile = "./buildoutAlertsDetails/Log-Search-Alerts-Table.md"

      # Calculating files hash
      $prFileHash = Get-NormalizedFileHash -Path $prFile
      $buildFileHash = Get-NormalizedFileHash -Path $buildFile

      Write-Output "Hash of PR file: $($prFileHash.Hash)"
      Write-Output "Hash of Build file: $($buildFileHash.Hash)"

      # Comparing PR files with build files
      ($buildFileHash.Hash) | Should -Be ($prFileHash.Hash) -Because "The [$prFile] should be updated based on the latest policy files. Please run [` /tooling/alz/Generate-AlertsDetails-Tables.ps1 `] to update the file."

    }

    It "Check Alerts Details table for Metric alerts update done" {

      # Setting files location
      $prFile = "./docs/content/patterns/alz/getting-started/Metric-Alerts-Table.md"
      $buildFile = "./buildoutAlertsDetails/Metric-Alerts-Table.md"

      # Calculating files hash
      $prFileHash = Get-NormalizedFileHash -Path $prFile
      $buildFileHash = Get-NormalizedFileHash -Path $buildFile

      Write-Output "Hash of PR file: $($prFileHash.Hash)"
      Write-Output "Hash of Build file: $($buildFileHash.Hash)"

      # Comparing PR files with build files
      ($buildFileHash.Hash) | Should -Be ($prFileHash.Hash) -Because "The [$prFile] should be updated based on the latest policy files. Please run [` /tooling/alz/Generate-AlertsDetails-Tables.ps1 `] to update the file."

    }

  }

  AfterAll {
    # These are not the droids you are looking for...
  }

}
