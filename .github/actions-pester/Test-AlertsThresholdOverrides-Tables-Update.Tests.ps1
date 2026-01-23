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

Describe 'UnitTest-AlertsThresholdOverride-Tables-Update' {
  BeforeAll {

    If ([string]::IsNullOrEmpty($(get-item "buildoutAlertsThresholdOverride" -ErrorAction SilentlyContinue).name)) {
      New-Item -Name "buildoutAlertsThresholdOverride" -Type Directory
    }

    & "./tooling/alz/Generate-AlertsThresholdOverride-Tables.ps1" -thresholdOverrideTablesRootDir "buildoutAlertsThresholdOverride"

  }

  Context "Check Alerts Threshold Override tables update" {

    It "Check Alerts Threshold Override table for ActivityLog alerts update done" {

      # Setting files location
      $prFile = "./docs/content/patterns/alz/HowTo/ActivityLog_Alerts_OverrideTags_Table.md"
      $buildFile = "./buildoutAlertsThresholdOverride/ActivityLog_Alerts_OverrideTags_Table.md"

      # Calculating files hash
      $prFileHash = Get-NormalizedFileHash -Path $prFile
      $buildFileHash = Get-NormalizedFileHash -Path $buildFile

      Write-Output "Hash of PR file: $($prFileHash.Hash)"
      Write-Output "Hash of Build file: $($buildFileHash.Hash)"

      # Comparing PR files with build files
      ($buildFileHash.Hash) | Should -Be ($prFileHash.Hash) -Because "The [$prFile] should be updated based on the latest policy files. Please run [` /tooling/alz/Generate-AlertsThresholdOverrides-Tables.ps1 `] to update the file."

    }

    It "Check Alerts Threshold Override table for Log-Search alerts update done" {

      # Setting files location
      $prFile = "./docs/content/patterns/alz/HowTo/Log_Search_Alerts_OverrideTags_Table.md"
      $buildFile = "./buildoutAlertsThresholdOverride/Log_Search_Alerts_OverrideTags_Table.md"

      # Calculating files hash
      $prFileHash = Get-NormalizedFileHash -Path $prFile
      $buildFileHash = Get-NormalizedFileHash -Path $buildFile

      Write-Output "Hash of PR file: $($prFileHash.Hash)"
      Write-Output "Hash of Build file: $($buildFileHash.Hash)"

      # Comparing PR files with build files
      ($buildFileHash.Hash) | Should -Be ($prFileHash.Hash) -Because "The [$prFile] should be updated based on the latest policy files. Please run [` /tooling/alz/Generate-AlertsThresholdOverrides-Tables.ps1 `] to update the file."

    }

    It "Check Alerts Threshold Override table for Metric alerts update done" {

      # Setting files location
      $prFile = "./docs/content/patterns/alz/HowTo/Metrics_Alerts_OverrideTags_Table.md"
      $buildFile = "./buildoutAlertsThresholdOverride/Metrics_Alerts_OverrideTags_Table.md"

      # Calculating files hash
      $prFileHash = Get-NormalizedFileHash -Path $prFile
      $buildFileHash = Get-NormalizedFileHash -Path $buildFile

      Write-Output "Hash of PR file: $($prFileHash.Hash)"
      Write-Output "Hash of Build file: $($buildFileHash.Hash)"

      # Comparing PR files with build files
      ($buildFileHash.Hash) | Should -Be ($prFileHash.Hash) -Because "The [$prFile] should be updated based on the latest policy files. Please run [` /tooling/alz/Generate-AlertsThresholdOverrides-Tables.ps1 `] to update the file."

    }

  }

  AfterAll {
    # These are not the droids you are looking for...
  }

}
