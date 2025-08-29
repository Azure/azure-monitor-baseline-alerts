Describe 'UnitTest-AlertsThresholdOverride-Tables-Update' {
  BeforeAll {

    New-Item -Name "buildoutAlertsThresholdOverride" -Type Directory

    & "./tooling/alz/Generate-AlertsThresholdOverride-Tables.ps1" -thresholdOverrideTablesRootDir "buildoutAlertsThresholdOverride"

  }

  Context "Check Alerts Threshold Override tables update" {

    It "Check Alerts Threshold Override table for ActivityLog alerts update done" {

      # Setting files location
      $prFile = "./docs/content/patterns/alz/HowTo/ActivityLog_Alerts_OverrideTags_Table.md"
      $buildFile = "./buildoutAlertsThresholdOverride/ActivityLog_Alerts_OverrideTags_Table.md"

      # Calculating files hash
      $prFileHash = Get-FileHash -Path $prFile -Algorithm SHA256
      $buildFileHash = Get-FileHash -Path $buildFile -Algorithm SHA256

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
      $prFileHash = Get-FileHash -Path $prFile -Algorithm SHA256
      $buildFileHash = Get-FileHash -Path $buildFile -Algorithm SHA256

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
      $prFileHash = Get-FileHash -Path $prFile -Algorithm SHA256
      $buildFileHash = Get-FileHash -Path $buildFile -Algorithm SHA256

      Write-Output "Hash of PR file: $($prFileHash.Hash)"
      Write-Output "Hash of Build file: $($buildFileHash.Hash)"

      # Comparing PR files with build files
      ($buildFileHash.Hash) | Should -Be ($prFileHash.Hash) -Because "The [$prFile] should be updated based on the latest policy files. Please run [` /tooling/alz/Generate-AlertsDetails-Table.ps1 `] to update the file."

    }

  }

  AfterAll {
    # These are not the droids you are looking for...
  }

}
