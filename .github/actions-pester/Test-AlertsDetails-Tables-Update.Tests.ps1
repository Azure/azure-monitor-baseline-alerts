Describe 'UnitTest-AlertsDetails-Tables-Update' {
  BeforeAll {

    New-Item -Name "buildoutAlertsDetails" -Type Directory

    & "./tooling/alz/Generate-AlertsDetails-Tables.ps1" -alertTablesRootDir "buildoutAlertsDetails"
  }

  Context "Check Alerts Details tables update" {

    It "Check Alerts Details table for ActivityLog alerts update done" {

      # Setting files location
      $prFile = "./docs/content/patterns/alz/getting-started/Activity-Log-Alerts-Table.md"
      $buildFile = "./buildoutAlertsDetails/Activity-Log-Alerts-Table.md"

      # Calculating files hash
      $prFileHash = Get-FileHash -Path $prFile -Algorithm SHA256
      $buildFileHash = Get-FileHash -Path $buildFile -Algorithm SHA256

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
      $prFileHash = Get-FileHash -Path $prFile -Algorithm SHA256
      $buildFileHash = Get-FileHash -Path $buildFile -Algorithm SHA256

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
      $prFileHash = Get-FileHash -Path $prFile -Algorithm SHA256
      $buildFileHash = Get-FileHash -Path $buildFile -Algorithm SHA256

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
