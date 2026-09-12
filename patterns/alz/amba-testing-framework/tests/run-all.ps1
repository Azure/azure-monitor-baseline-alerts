<#
.SYNOPSIS
  AMBA-ALZ Test Runner Script - Simulates failures to validate AMBA-ALZ alerts.

.DESCRIPTION
  This script reads a test plan YAML file and triggers synthetic failure conditions
  (CPU pressure, memory pressure, app errors, log injection, etc.) on Azure resources
  to verify that Azure Monitor Baseline Alerts - ALZ (AMBA-ALZ) are functioning correctly.

.PARAMETER resourceGroup
  Name of the resource group containing the test targets.

.PARAMETER vmName
  Name of the target virtual machine.

.PARAMETER appServiceName
  Name of the target Azure App Service.

.PARAMETER appInsightsKey
  Instrumentation key for Application Insights (for log injection).

.PARAMETER sqlSecret
  (Optional) Name of the Key Vault secret containing SQL connection string.

.EXAMPLE
  pwsh run-all.ps1 -resourceGroup "my-rg" -vmName "vm01" -appServiceName "web01" -appInsightsKey "xxxx"
#>

param(
  [Parameter(Mandatory=$true)][string]$resourceGroup,
  [Parameter(Mandatory=$true)][string]$vmName,
  [Parameter(Mandatory=$true)][string]$appServiceName,
  [Parameter(Mandatory=$true)][string]$appInsightsKey,
  [Parameter(Mandatory=$false)][string]$sqlSecret
)

function Invoke-CpuPressure {
  Write-Host " Simulating high CPU pressure on VM..."
  az vm run-command invoke --resource-group $resourceGroup --name $vmName `
    --command-id RunShellScript `
    --scripts "sudo apt install -y stress && stress --cpu 4 --timeout 120"
}

function Invoke-MemoryPressure {
  Write-Host " Simulating memory pressure on VM..."
  az vm run-command invoke --resource-group $resourceGroup --name $vmName `
    --command-id RunShellScript `
    --scripts "stress --vm 1 --vm-bytes 90% --timeout 120s"
}

function Invoke-DiskFill {
  Write-Host " Filling up disk space on VM..."
  az vm run-command invoke --resource-group $resourceGroup --name $vmName `
    --command-id RunShellScript `
    --scripts "fallocate -l 4G /tmp/fillme.img && df -h"
}

function Invoke-NetworkLoss {
  Write-Host " Simulating network loss via Chaos Studio — must be deployed separately"
  Write-Warning "Deploy 'vm-network-loss.bicep' manually before running this test."
}

function Invoke-AppForce500 {
  Write-Host " Triggering HTTP 500 errors on App Service..."
  for ($i = 0; $i -lt 10; $i++) {
    try {
      Invoke-WebRequest -Uri "https://$appServiceName.azurewebsites.net/api/force500" -UseBasicParsing
    } catch {
      Write-Host "500 received (expected)"
    }
  }
}

function Invoke-AppSlowResponse {
  Write-Host " Simulating slow response via /slow endpoint..."
  for ($i = 0; $i -lt 5; $i++) {
    Invoke-WebRequest -Uri "https://$appServiceName.azurewebsites.net/api/slow" -UseBasicParsing
    Start-Sleep -Seconds 2
  }
}

function Invoke-AppDown {
  Write-Host " Stopping App Service for downtime simulation..."
  Stop-AzWebApp -ResourceGroupName $resourceGroup -Name $appServiceName
  Start-Sleep -Seconds 60
  Start-AzWebApp -ResourceGroupName $resourceGroup -Name $appServiceName
  Write-Host " App restarted."
}

function Send-CustomLog {
  param (
    [string]$severity = "Warning",
    [string]$message = "Synthetic log from AMBA Test",
    [string]$testId = "default-test-id"
  )

  Write-Host " Injecting custom log into App Insights..."
  $payload = @{
    name = "TestEvent"
    time = (Get-Date).ToUniversalTime().ToString("o")
    iKey = $appInsightsKey
    data = @{
      baseType = "EventData"
      baseData = @{
        ver = 2
        name = "AMBA-Test"
        properties = @{
          testId = $testId
          severity = $severity
          message = $message
          source = "amba-test-runner"
        }
      }
    }
  }

  Invoke-RestMethod -Uri "https://dc.services.visualstudio.com/v2/track" `
    -Method POST `
    -Body ($payload | ConvertTo-Json -Depth 10) `
    -ContentType "application/json"
}

function Invoke-SqlLoad {
  Write-Host " Executing SQL load test..."

  if (-not $sqlSecret) {
    Write-Warning "No SQL secret provided. Skipping SQL load test."
    return
  }

  $connStr = (Get-AzKeyVaultSecret -VaultName "kv-my-vault" -Name $sqlSecret).SecretValueText

  for ($i = 0; $i -lt 20; $i++) {
    Invoke-Sqlcmd -ConnectionString $connStr -Query "SELECT TOP 1000 * FROM sys.objects CROSS JOIN sys.objects"
    Start-Sleep -Seconds 1
  }
}


Import-Module Az.Accounts -ErrorAction Stop
Import-Module Az.Resources -ErrorAction Stop
Import-Module Az.Websites -ErrorAction Stop
Import-Module Az.KeyVault -ErrorAction Stop

function Get-TestPlan {
  Write-Host " Loading test plan..."
  $yamlContent = Get-Content "./tests/amba-test-plan.yaml" -Raw
  $parsed = ConvertFrom-Yaml $yamlContent
  return $parsed.tests
}

function Invoke-CPUPressure {
  Write-Host " Simulating CPU pressure on VM: $vmName"
  az vm run-command invoke --resource-group $resourceGroup --name $vmName `
    --command-id RunShellScript --scripts "sudo apt install -y stress && stress --cpu 4 --timeout 120"
}

function Invoke-MemoryPressureTest {
  Write-Host " Simulating Memory pressure on VM: $vmName"
  az vm run-command invoke --resource-group $resourceGroup --name $vmName `
    --command-id RunShellScript --scripts "sudo fallocate -l 512M /tmp/mem.test && tail /dev/zero > /dev/null &"
}

function Invoke-DiskFillTest {
  Write-Host " Simulating disk fill on VM: $vmName"
  $sizeGB = 5
  $script = "fallocate -l ${sizeGB}G /tmp/filltest.img"
  az vm run-command invoke --resource-group $resourceGroup --name $vmName `
    --command-id RunShellScript --scripts "$script"
}

function Invoke-NetworkLoss {
  Write-Host " Simulating network fault (packet loss)..."
  # Requires Chaos Studio integration via Bicep - not handled here directly
  Write-Warning "Chaos Studio experiment for NetworkLoss must be triggered separately"
}

function Invoke-AppForce500 {
  Write-Host " Hitting /api/force500 on $appServiceName"
  for ($i = 1; $i -le 10; $i++) {
    try {
      Invoke-WebRequest -Uri "https://$appServiceName.azurewebsites.net/api/force500" -UseBasicParsing
    } catch {
      Write-Host "Expected 500 received - Iteration $i"
    }
  }
}

function Invoke-AppLatency {
  Write-Host " Invoking slow endpoint on $appServiceName"
  for ($i = 1; $i -le 5; $i++) {
    Invoke-WebRequest -Uri "https://$appServiceName.azurewebsites.net/api/slow" -UseBasicParsing
    Start-Sleep -Seconds 2
  }
}

function Invoke-AppDown {
  Write-Host " Stopping App Service: $appServiceName"
  Stop-AzWebApp -ResourceGroupName $resourceGroup -Name $appServiceName
  Start-Sleep -Seconds 60
  Start-AzWebApp -ResourceGroupName $resourceGroup -Name $appServiceName
  Write-Host " App restarted."
}

function Send-CustomLog {
  param([string]$severity, [string]$message, [string]$testId)
  Write-Host " Injecting custom telemetry to App Insights..."
  $payload = @{
    name = "TestEvent"
    time = (Get-Date).ToUniversalTime().ToString("o")
    iKey = $appInsightsKey
    data = @{
      baseType = "EventData"
      baseData = @{
        ver = 2
        name = "AMBA-Test"
        properties = @{
          severityLevel = $severity
          message = $message
          testId = $testId
          source = "AMBA-Test-Framework"
        }
      }
    }
  }
  Invoke-RestMethod -Uri "https://dc.services.visualstudio.com/v2/track" `
    -Method POST -Body ($payload | ConvertTo-Json -Depth 10) -ContentType "application/json"
}

function Invoke-SQLLoad {
  Write-Host " Simulating SQL load (requires pre-configured secret)"
  if (-not $sqlSecret) {
    Write-Warning " SQL secret not provided — skipping SQL load test"
    return
  }
  $connStr = (Get-AzKeyVaultSecret -VaultName "kv-secure" -Name $sqlSecret).SecretValueText
  for ($i = 0; $i -lt 20; $i++) {
    Invoke-Sqlcmd -ConnectionString $connStr -Query "SELECT TOP 1000 * FROM sys.objects CROSS JOIN sys.objects"
  }
}

function Invoke-Test {
  param([object]$test)

  Write-Host "`n=============================="
  Write-Host " Running test: $($test.name)"
  Write-Host " ID: $($test.id)"
  Write-Host " Type: $($test.testType) on $($test.resourceType)"
  Write-Host "=============================="

  switch ($test.id) {
    "cpu-vm"          { Invoke-CPUPressure }
    "memory-vm"       { Invoke-MemoryPressureTest }
    "disk-vm"         { Invoke-DiskFillTest }
    "net-vm"          { Invoke-NetworkLoss }
    "app-5xx"         { Invoke-AppForce500 }
    "app-slow"        { Invoke-AppLatency }
    "app-down"        { Invoke-AppDown }
    "appinsights-log" {
      Send-CustomLog `
        -severity $test.parameters.severity `
        -message $test.parameters.message `
        -testId $test.parameters.testId
    }
    "sql-dtu"         { Invoke-SQLLoad }
    default {
      Write-Warning " No handler for test ID: $($test.id)"
    }
  }

  Write-Host " Completed test: $($test.name)"
  Start-Sleep -Seconds 10
}

### Main execution block
$tests = Load-TestPlan

foreach ($test in $tests) {
  Invoke-Test -test $test
}

Write-Host "`n All tests executed. Check Azure Monitor for alerts fired."
