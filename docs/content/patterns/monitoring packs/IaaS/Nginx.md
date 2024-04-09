---
title: Nginx
geekdocCollapseSection: true
weight: 50
---
[Alerts](#alerts)

[File Patterns](#file-patterns)

## Alerts

|DisplayName|Type|Description|
|---|---|---|
|[AlertRule-Nginx-1](#nginx-service-stopped)|Log| Nginx stopped.|

### Nginx service stopped

|Property | Value |
|---|---|
|Severity|1|
|Enabled|True|
|AutoMitigate|True|
|EvaluationFrequency|PT15M|
|WindowSize|PT15M|
|Type|rows|
|Query|Syslog \| where SyslogMessage == "Stopped A high performance web server and a reverse proxy server."|
|Threshold|N/A|

## File Patterns

|File Pattern|
|---|
|/var/log/nginx/access.log|
|/var/log/nginx/error.log|
