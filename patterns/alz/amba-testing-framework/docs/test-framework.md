#  How to Validate Your Alerts with the AMBA Test Framework

This guide explains how to use the **AMBA Test Framework** to simulate real-world failure scenarios in Azure and verify that baseline monitoring alerts are correctly deployed and configured using the **Azure Monitor Baseline Alerts (AMBA)** standards.

This document is part of the Azure Monitor Baseline Alerts (AMBA) initiative and supports validation for **Landing Zone (ALZ)** patterns.

---

##  Overview

The **AMBA Test Framework** is a modular test suite built to validate that monitoring alerts are not only deployed but also functional — by simulating workloads or failures such as:

- High CPU or memory pressure
- App Service failures or slowdowns
- SQL database saturation
- Custom log injection into Application Insights

It ensures your AMBA implementation works in real life, across various Azure services.

---

##  When Should I Use It?

- After deploying AMBA to a new Azure environment
- After deploying a new workload or architecture pattern (e.g. ALZ)
- As part of your CI/CD pipeline to validate telemetry readiness
- Before go-live in production

---

##  What's Included

| Path | Description |
|------|-------------|
| `tests/amba-test-plan.yaml` | The list of tests to execute, structured in YAML |
| `tests/run-all.ps1` | Main PowerShell runner that reads and executes the tests |
| `chaos-studio-experiments/*.bicep` | Bicep files to simulate faults via Azure Chaos Studio |
| `workbooks/amba-workbook.json` | Azure Monitor Workbook to visualize alerts and test coverage |
| `pipelines/amba-validation-pipeline.yml` | *(Optional)* Azure DevOps pipeline to run tests automatically |

---

##  Prerequisites

###  Core Infrastructure

| Component | Requirement |
|-----------|-------------|
| Azure VM (Linux) | With Azure Monitor Agent installed and Chaos Studio target enabled |
| App Service | Deployed with special test endpoints (`/api/force500`, `/api/slow`) |
| Application Insights | Connected to the App Service and instrumentation key available |
| Azure SQL Database | Connected and provisioned with a sample database |
| Azure Key Vault | Contains a secret holding the SQL connection string |

###  Access & Permissions

- Contributor access to the test resource group
- Ability to run PowerShell scripts and deploy Bicep templates
- Permissions to assign capabilities to Chaos Studio targets

---

##  Step-by-Step Usage

### 1. Clone or Download the Test Framework

```bash
git clone https://github.com/your-org/amba-test-framework.git
cd amba-test-framework/tests
```

### 2. Define Your Test Plan in YAML

Open `amba-test-plan.yaml` and specify the tests you want to simulate.

```yaml
- id: cpu-vm
  name: Simulate high CPU usage
  resourceType: vm
  testType: chaos
  parameters:
    duration: PT3M

- id: app-5xx
  name: Trigger HTTP 500 errors
  resourceType: appService
  testType: script
  action: invokeForce500
  parameters:
    count: 10
```

### 3. Execute the Framework

Use the PowerShell runner to execute all tests:

```powershell
pwsh ./run-all.ps1 `
  -resourceGroup "rg-observability" `
  -vmName "vm-linux-01" `
  -appServiceName "app-monitor-test" `
  -appInsightsKey "<Instrumentation-Key>" `
  -sqlSecret "sql-monitor-secret"
```

The script will:

- Launch Chaos Studio faults
- Simulate HTTP 500 or delays
- Inject synthetic logs
- Trigger resource stress (CPU, disk, etc.)

### 4. Validate Alerts in Azure Monitor

After execution:

- Go to **Azure Portal > Monitor > Alerts**
- Filter by time and resource group
- You should see alert rules that correspond to each test ID, with `MonitorCondition = Fired`

You can also:

- Check alerts in the AMBA Workbook
- Use Kusto queries to search injected logs or metrics
- Export alerts to CSV for documentation

### 5. Optional: Deploy Chaos Studio Faults

For VM CPU or memory pressure simulation, deploy experiments using Bicep:

```bash
az deployment group create \
  --resource-group rg-observability \
  --template-file ./chaos-studio-experiments/vm-cpu-pressure.bicep \
  --parameters targetVmResourceId="/subscriptions/xxx/resourceGroups/xxx/providers/Microsoft.Compute/virtualMachines/vm-linux-01"
```

Ensure the VM is correctly registered as a Chaos Studio target.

### 6. Optional: Automate via Azure DevOps

Integrate the `amba-validation-pipeline.yml` file in your release pipeline:

- Schedule periodic runs (e.g. nightly)
- Include in environment validation gates
- Generate artifacts with alerts summary

---

##  Test Coverage Overview

| Test ID         | Alert Simulated                    | AMBA Rule Type             | Service         |
|------------------|------------------------------------|-----------------------------|------------------|
| `cpu-vm`         | CPU pressure > 90% for 3 mins      | Metric alert (VM)           | Virtual Machine  |
| `memory-vm`      | Memory saturation simulated        | Metric alert (VM)           | Virtual Machine  |
| `disk-vm`        | Disk usage > threshold             | Metric alert (VM)           | Virtual Machine  |
| `app-5xx`        | Repeated HTTP 500 errors           | App Service rule            | App Service      |
| `app-slow`       | Long request duration              | App Service performance     | App Service      |
| `app-down`       | App becomes unavailable            | Availability alert          | App Service      |
| `appinsights-log`| Custom error message logged        | Log-based alert (AI)        | App Insights     |
| `sql-dtu`        | High DTU usage                     | SQL utilization alert       | Azure SQL        |

Additional tests (Key Vault, Storage, NSG) are possible with customization.

---

##  Troubleshooting

| Symptom | Likely Cause | Suggested Fix |
|---------|---------------|----------------|
| Alerts don’t fire | Alert rules not deployed or thresholds too high | Check AMBA deployment & rule conditions |
| `run-all.ps1` throws errors | Missing parameters or invalid YAML | Validate `amba-test-plan.yaml` format |
| Chaos Studio fails | VM not registered as Chaos target | Register and assign capabilities again |
| No logs appear in AI | Instrumentation key not injected or misused | Check `appInsightsKey` and test app settings |

---

##  Advanced Use Cases

- Extend YAML with new `testType` values (e.g. `logInjection`)
- Customize alert thresholds temporarily for testing
- Tag test alerts for easier filtering in Monitor

---

##  Frequently Asked Questions (FAQ)

**Q: Will this disrupt production environments?**
A: No. The framework is designed to simulate faults safely in non-prod or test subscriptions.

**Q: Can I add my own alerts to test?**
A: Yes. Extend the YAML and create matching functions or scripts.

**Q: Does this require re-deploying AMBA?**
A: No. It only triggers conditions expected to activate existing AMBA rules.

---

##  Folder Structure

```bash
/tests
  ├── run-all.ps1
  ├── amba-test-plan.yaml
  ├── chaos-studio-experiments/
  │    └── vm-cpu-pressure.bicep
  └── pipelines/
       └── amba-validation-pipeline.yml
/workbooks
  └── amba-workbook.json
/docs
  └── test-your-alerts.md
```

---

##  Next Steps

Download or clone the framework repo
Update your test plan YAML
Run the test suite in PowerShell or Azure DevOps
Validate alerts in the Monitor Portal or Workbook

If you encounter issues or wish to contribute additional test scenarios, feel free to submit a pull request or open an issue on the AMBA GitHub repo.
