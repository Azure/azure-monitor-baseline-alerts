---
title: AA Monitoring Pack
geekdocCollapseSection: true
weight: 50
---
[Alerts](#alerts)

## Alerts

|DisplayName|Type|Description|
|---|---|---|
|[TotalJob - Microsoft.Automation-AA](#totaljob---microsoftautomation-aa)|Microsoft.Insights/metricAlerts|TotalJob - Microsoft.Automation-AA|
|[TotalUpdateDeploymentMachineRuns - Microsoft.Automation-AA](#totalupdatedeploymentmachineruns---microsoftautomation-aa)|Microsoft.Insights/metricAlerts|TotalUpdateDeploymentMachineRuns - Automation-Accounts|
|[TotalUpdateDeploymentRuns - Microsoft.Automation-AA](#totalupdatedeploymentruns---microsoftautomation-aa)|Microsoft.Insights/metricAlerts|TotalUpdateDeploymentRuns - Microsoft.Automation-AA|

### TotalJob - Microsoft.Automation-AA

|Property | Value |
|---|---|
|Alert Type                    | Microsoft.Insights/metricAlerts |
|Alert Name                    |TotalJob - Microsoft.Automation-AA|
|Alert DisplayName             |TotalJob - Microsoft.Automation-AA|
|Alert Description             |The total number of jobs|
|Metric Namespace             |Microsoft.Automation-AA|
|Severity                    |2|
|Metric Name                  |TotalJob|
|Operator                     |GreaterThan|
|Evaluation Frequency       |PT1M|
|Windows Size                |PT5M|
|Threshold                 |0|
|Auto Mitigate              |false|
|Initiative Member             |True|
|Pack Type                     |PaaS|
|Time Aggregation              |Average|

### TotalUpdateDeploymentMachineRuns - Microsoft.Automation-AA

|Property | Value |
|---|---|
|Alert Type                    | Microsoft.Insights/metricAlerts |
|Alert Name                    |TotalUpdateDeploymentMachineRuns - Automation-Accounts|
|Alert DisplayName             |TotalUpdateDeploymentMachineRuns - Microsoft.Automation-AA|
|Alert Description             |Total software update deployment machine runs in a software update deployment run|
|Metric Namespace             |Microsoft.Automation-AA|
|Severity                    |2|
|Metric Name                  |TotalUpdateDeploymentMachineRuns|
|Operator                     |GreaterThan|
|Evaluation Frequency       |PT1M|
|Windows Size                |PT5M|
|Threshold                 |0|
|Auto Mitigate              |false|
|Initiative Member             |True|
|Pack Type                     |PaaS|
|Time Aggregation              |Total|

### TotalUpdateDeploymentRuns - Microsoft.Automation-AA

|Property | Value |
|---|---|
|Alert Type                    | Microsoft.Insights/metricAlerts |
|Alert Name                    |TotalUpdateDeploymentRuns - Microsoft.Automation-AA|
|Alert DisplayName             |TotalUpdateDeploymentRuns - Microsoft.Automation-AA|
|Alert Description             |Total software update deployment runs|
|Metric Namespace             |Microsoft.Automation-AA|
|Severity                    |3|
|Metric Name                  |TotalUpdateDeploymentRuns|
|Operator                     |GreaterThan|
|Evaluation Frequency       |PT1M|
|Windows Size                |PT5M|
|Threshold                 |0|
|Auto Mitigate              |false|
|Initiative Member             |True|
|Pack Type                     |PaaS|
|Time Aggregation              |Total|
