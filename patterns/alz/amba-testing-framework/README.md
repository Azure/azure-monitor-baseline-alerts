# AMBA Testing Framework

This module provides an automated test harness to validate Azure Monitor Baseline Alerts (AMBA).

## Purpose

To simulate real-world incidents (high CPU, memory, HTTP 500, log injections) and verify that AMBA alerts:
- Are correctly deployed
- Trigger under the right conditions
- Notify the appropriate action groups

## Components

- `tests/amba-test-plan.yaml`: Declarative list of alert scenarios to test
- `tests/run-all.ps1`: PowerShell script that simulates issues and checks alert responses
- `chaos-studio-experiments/`: Bicep templates for Chaos Studio fault injection
- `templates/amba-workbook.json`: Workbook template to visualize alert trigger status
- `pipelines/amba-validation-pipeline.yml`: DevOps pipeline to automate execution

## Usage

```bash
pwsh ./tests/run-all.ps1
