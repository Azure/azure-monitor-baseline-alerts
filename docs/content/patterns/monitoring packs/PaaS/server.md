---
title: server Monitoring Pack
geekdocCollapseSection: true
weight: 50
---
[Alerts](#alerts)

## Alerts

|DisplayName|Type|Description|
|---|---|---|
|[connection_failed - Microsoft.Sql/servers/databases](#connection_failed---microsoftsqlserversdatabases)|Microsoft.Insights/metricAlerts|connection_failed - servers|
|[deadlock - Microsoft.Sql/servers/databases](#deadlock---microsoftsqlserversdatabases)|Microsoft.Insights/metricAlerts|deadlock - servers|
|[blocked_by_firewall - Microsoft.Sql/servers/databases](#blocked_by_firewall---microsoftsqlserversdatabases)|Microsoft.Insights/metricAlerts|blocked_by_firewall - servers|
|[storage - Microsoft.Sql/servers/databases](#storage---microsoftsqlserversdatabases)|Microsoft.Insights/metricAlerts|storage - servers|
|[connection_successful - Microsoft.Sql/servers/databases](#connection_successful---microsoftsqlserversdatabases)|Microsoft.Insights/metricAlerts|connection_successful - servers|
|[connection_failed_user_error - Microsoft.Sql/servers/databases](#connection_failed_user_error---microsoftsqlserversdatabases)|Microsoft.Insights/metricAlerts|connection_failed_user_error - servers|
|[dtu_used - Microsoft.Sql/servers/databases](#dtu_used---microsoftsqlserversdatabases)|Microsoft.Insights/metricAlerts|dtu_used - servers|

### connection_failed - Microsoft.Sql/servers/databases

|Property | Value |
|---|---|
|Alert Type                    | Microsoft.Insights/metricAlerts |
|Alert Name                    |connection_failed - servers|
|Alert DisplayName             |connection_failed - Microsoft.Sql/servers/databases|
|Alert Description             |Failed Connections|
|Metric Namespace             |Microsoft.Sql/servers/databases|
|Severity                    |1|
|Metric Name                  |connection_failed|
|Operator                     |GreaterThan|
|Evaluation Frequency       |PT1M|
|Windows Size                |PT5M|
|Threshold                 |0|
|Auto Mitigate              |false|
|Initiative Member             |True|
|Pack Type                     |PaaS|
|Time Aggregation              |Total|

### deadlock - Microsoft.Sql/servers/databases

|Property | Value |
|---|---|
|Alert Type                    | Microsoft.Insights/metricAlerts |
|Alert Name                    |deadlock - servers|
|Alert DisplayName             |deadlock - Microsoft.Sql/servers/databases|
|Alert Description             |Deadlocks. Not applicable to data warehouses.|
|Metric Namespace             |Microsoft.Sql/servers/databases|
|Severity                    |3|
|Metric Name                  |deadlock|
|Operator                     |GreaterThan|
|Evaluation Frequency       |PT1M|
|Windows Size                |PT5M|
|Threshold                 |0|
|Auto Mitigate              |false|
|Initiative Member             |True|
|Pack Type                     |PaaS|
|Time Aggregation              |Total|

### blocked_by_firewall - Microsoft.Sql/servers/databases

|Property | Value |
|---|---|
|Alert Type                    | Microsoft.Insights/metricAlerts |
|Alert Name                    |blocked_by_firewall - servers|
|Alert DisplayName             |blocked_by_firewall - Microsoft.Sql/servers/databases|
|Alert Description             |Blocked by Firewall|
|Metric Namespace             |Microsoft.Sql/servers/databases|
|Severity                    |2|
|Metric Name                  |blocked_by_firewall|
|Operator                     |GreaterThan|
|Evaluation Frequency       |PT5M|
|Windows Size                |PT5M|
|Threshold                 |5|
|Auto Mitigate              |false|
|Initiative Member             |True|
|Pack Type                     |PaaS|
|Time Aggregation              |Total|

### storage - Microsoft.Sql/servers/databases

|Property | Value |
|---|---|
|Alert Type                    | Microsoft.Insights/metricAlerts |
|Alert Name                    |storage - servers|
|Alert DisplayName             |storage - Microsoft.Sql/servers/databases|
|Alert Description             |Data space used. Not applicable to data warehouses.|
|Metric Namespace             |Microsoft.Sql/servers/databases|
|Severity                    |3|
|Metric Name                  |storage|
|Operator                     |GreaterThan|
|Evaluation Frequency       |PT5M|
|Windows Size                |PT5M|
|Threshold                 |934584883610|
|Auto Mitigate              |false|
|Initiative Member             |True|
|Pack Type                     |PaaS|
|Time Aggregation              |Maximum|

### connection_successful - Microsoft.Sql/servers/databases

|Property | Value |
|---|---|
|Alert Type                    | Microsoft.Insights/metricAlerts |
|Alert Name                    |connection_successful - servers|
|Alert DisplayName             |connection_successful - Microsoft.Sql/servers/databases|
|Alert Description             |Successful Connections|
|Metric Namespace             |Microsoft.Sql/servers/databases|
|Severity                    |4|
|Metric Name                  |connection_successful|
|Operator                     |LessThan|
|Evaluation Frequency       |PT5M|
|Windows Size                |PT5M|
|Threshold                 ||
|Auto Mitigate              |false|
|Initiative Member             |True|
|Pack Type                     |PaaS|
|Time Aggregation              |Total|

### connection_failed_user_error - Microsoft.Sql/servers/databases

|Property | Value |
|---|---|
|Alert Type                    | Microsoft.Insights/metricAlerts |
|Alert Name                    |connection_failed_user_error - servers|
|Alert DisplayName             |connection_failed_user_error - Microsoft.Sql/servers/databases|
|Alert Description             |Failed Connections : User Errors|
|Metric Namespace             |Microsoft.Sql/servers/databases|
|Severity                    |2|
|Metric Name                  |connection_failed_user_error|
|Operator                     |GreaterThan|
|Evaluation Frequency       |PT5M|
|Windows Size                |PT5M|
|Threshold                 |10|
|Auto Mitigate              |false|
|Initiative Member             |True|
|Pack Type                     |PaaS|
|Time Aggregation              |Total|

### dtu_used - Microsoft.Sql/servers/databases

|Property | Value |
|---|---|
|Alert Type                    | Microsoft.Insights/metricAlerts |
|Alert Name                    |dtu_used - servers|
|Alert DisplayName             |dtu_used - Microsoft.Sql/servers/databases|
|Alert Description             |DTU used. Applies to DTU-based databases.|
|Metric Namespace             |Microsoft.Sql/servers/databases|
|Severity                    |3|
|Metric Name                  |dtu_used|
|Operator                     |GreaterThan|
|Evaluation Frequency       |PT5M|
|Windows Size                |PT5M|
|Threshold                 |85|
|Auto Mitigate              |false|
|Initiative Member             |True|
|Pack Type                     |PaaS|
|Time Aggregation              |Average|
