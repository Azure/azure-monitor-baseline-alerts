---
title: IIS
geekdocCollapseSection: true
weight: 50
---
[Alerts](#alerts)

[Performance Counters](#performance-counters)

## Alerts

|DisplayName|Type|Description|
|---|---|---|
|[AlertRule-IIS-2012-1](#a-server-side-include-file-has-included-itself-or-the-maximum-depth-of-server-side-includes-has-been-exceeded)|Log| A server side include file has included itself or the maximum depth of server side includes has been exceeded|
|[AlertRule-IIS-2012-2](#application-pool-has-an-idletimeout-equal-to-or-greater-than-the-periodicrestart-time)|Log| Application Pool has an IdleTimeout equal to or greater than the PeriodicRestart time|
|[AlertRule-IIS-2012-3](#application-pool-worker-process-is-unresponsive)|Log| Application Pool worker process is unresponsive|
|[AlertRule-IIS-2012-4](#application-pool-worker-process-terminated-unexpectedly)|Log| Application Pool worker process terminated unexpectedly|
|[AlertRule-IIS-2012-5](#asp-application-error-occurred)|Log| ASP application error occurred|
|[AlertRule-IIS-2012-6](#http-control-channel-for-the-www-service-did-not-open)|Log| HTTP control channel for the WWW Service did not open|
|[AlertRule-IIS-2012-7](#http-server-could-not-create-a-client-connection-object-for-user)|Log| HTTP Server could not create a client connection object for user|
|[AlertRule-IIS-2012-8](#http-server-could-not-create-the-main-connection-socket)|Log| HTTP Server could not create the main connection socket|
|[AlertRule-IIS-2012-9](#http-server-could-not-initialize-its-security)|Log| HTTP Server could not initialize its security|
|[AlertRule-IIS-2012-10](#http-server-could-not-initialize-the-socket-library)|Log| HTTP Server could not initialize the socket library|
|[AlertRule-IIS-2012-11](#http-server-was-unable-to-initialize-due-to-a-shortage-of-available-memory)|Log| HTTP Server was unable to initialize due to a shortage of available memory|
|[AlertRule-IIS-2012-12](#isapi-application-error-detected)|Log| ISAPI application error detected|
|[AlertRule-IIS-2012-13](#job-object-associated-with-the-application-pool-encountered-an-error)|Log| Job object associated with the application pool encountered an error|
|[AlertRule-IIS-2012-14](#module-has-an-invalid-precondition)|Log| Module has an invalid precondition|
|[AlertRule-IIS-2012-15](#module-registration-error-detected-(failed-to-find-registermodule-entrypoint)|Log| Module registration error detected (failed to find RegisterModule entrypoint)|
|[AlertRule-IIS-2012-16](#module-registration-error-detected-(module-returned-an-error-during-registration)|Log| Module registration error detected (module returned an error during registration)|
|[AlertRule-IIS-2012-17](#only-one-type-of-logging-can-be-enabled-at-a-time)|Log| Only one type of logging can be enabled at a time|
|[AlertRule-IIS-2012-18](#sf_notify_read_raw_data-filter-notification-is-not-supported-in-iis-8)|Log| SF_NOTIFY_READ_RAW_DATA filter notification is not supported in IIS 8|
|[AlertRule-IIS-2012-19](#the-configuration-manager-for-was-did-not-initialize)|Log| The configuration manager for WAS did not initialize|
|[AlertRule-IIS-2012-20](#the-directory-specified-for-caching-compressed-content-is-invalid)|Log| The directory specified for caching compressed content is invalid|
|[AlertRule-IIS-2012-21](#the-global-modules-list-is-empty)|Log| The Global Modules list is empty|
|[AlertRule-IIS-2012-22](#the-http-server-encountered-an-error-processing-the-server-side-include-file)|Log| The HTTP server encountered an error processing the server side include file|
|[AlertRule-IIS-2012-23](#the-server-failed-to-close-client-connections-to-urls-during-shutdown)|Log| The server failed to close client connections to URLs during shutdown|
|[AlertRule-IIS-2012-24](#the-server-was-unable-to-acquire-a-license-for-a-ssl-connection)|Log| The server was unable to acquire a license for a SSL connection|
|[AlertRule-IIS-2012-25](#the-server-was-unable-to-allocate-a-buffer-to-read-a-file)|Log| The server was unable to allocate a buffer to read a file|
|[AlertRule-IIS-2012-26](#the-server-was-unable-to-read-a-file)|Log| The server was unable to read a file|
|[AlertRule-IIS-2012-27](#was-detected-invalid-configuration-data)|Log| WAS detected invalid configuration data|

### A server side include file has included itself or the maximum depth of server side includes has been exceeded

|Property | Value |
|---|---|
|Severity|1|
|Enabled|True|
|AutoMitigate|True|
|EvaluationFrequency|PT15M|
|WindowSize|PT15M|
|Type|rows|
|Query|Event \| where  EventID in (2221) and EventLog == 'Application' and Source == 'Microsoft-Windows-IIS-W3SVC-WP'|
|Threshold|N/A|
|xPathQuery|Application!*[System[Provider[@Name='Microsoft-Windows-IIS-W3SVC-WP'] and (EventID=2221)]]|

### Application Pool has an IdleTimeout equal to or greater than the PeriodicRestart time

|Property | Value |
|---|---|
|Severity|1|
|Enabled|True|
|AutoMitigate|True|
|EvaluationFrequency|PT15M|
|WindowSize|PT15M|
|Type|rows|
|Query|Event \| where  EventID in (5152) and EventLog == 'System' and Source == 'Microsoft-Windows-WAS'|
|Threshold|N/A|
|xPathQuery|System!*[System[Provider[@Name='Microsoft-Windows-WAS'] and (EventID=5152)]]|

### Application Pool worker process is unresponsive

|Property | Value |
|---|---|
|Severity|1|
|Enabled|True|
|AutoMitigate|True|
|EvaluationFrequency|PT15M|
|WindowSize|PT15M|
|Type|rows|
|Query|Event \| where  EventID in (5010,5011,5012,5013) and EventLog == 'System' and Source == 'Microsoft-Windows-WAS'|
|Threshold|N/A|
|xPathQuery|System!*[System[Provider[@Name='Microsoft-Windows-WAS'] and (EventID=5010 or EventID=5011 or EventID=5012 or EventID=5013)]]|

### Application Pool worker process terminated unexpectedly

|Property | Value |
|---|---|
|Severity|1|
|Enabled|True|
|AutoMitigate|True|
|EvaluationFrequency|PT15M|
|WindowSize|PT15M|
|Type|rows|
|Query|Event \| where  EventID in (5009) and EventLog == 'System' and Source == 'Microsoft-Windows-WAS'|
|Threshold|N/A|
|xPathQuery|System!*[System[Provider[@Name='Microsoft-Windows-WAS'] and (EventID=5009)]]|

### ASP application error occurred

|Property | Value |
|---|---|
|Severity|1|
|Enabled|True|
|AutoMitigate|True|
|EvaluationFrequency|PT15M|
|WindowSize|PT15M|
|Type|rows|
|Query|Event \| where  EventID in (500,499,23,22,21,20,19,18,17,16,9,8,7,6,5) and EventLog == 'Application' and Source == 'Active Server Pages'|
|Threshold|N/A|
|xPathQuery|Application!*[System[Provider[@Name='Active Server Pages'] and (EventID=500 or EventID=499 or EventID=23 or EventID=22 or EventID=21 or EventID=20 or EventID=19 or EventID=18 or EventID=17 or EventID=16 or EventID=9 or EventID=8 or EventID=7 or EventID=6 or EventID=5)]]|

### HTTP control channel for the WWW Service did not open

|Property | Value |
|---|---|
|Severity|1|
|Enabled|True|
|AutoMitigate|True|
|EvaluationFrequency|PT15M|
|WindowSize|PT15M|
|Type|rows|
|Query|Event \| where  EventID in (1037) and EventLog == 'System' and Source == 'Microsoft-Windows-IIS-W3SVC'|
|Threshold|N/A|
|xPathQuery|System!*[System[Provider[@Name='Microsoft-Windows-IIS-W3SVC'] and (EventID=1037)]]|

### HTTP Server could not create a client connection object for user

|Property | Value |
|---|---|
|Severity|1|
|Enabled|True|
|AutoMitigate|True|
|EvaluationFrequency|PT15M|
|WindowSize|PT15M|
|Type|rows|
|Query|Event \| where  EventID in (2208) and EventLog == 'Application' and Source == 'Microsoft-Windows-IIS-W3SVC-WP'|
|Threshold|N/A|
|xPathQuery|Application!*[System[Provider[@Name='Microsoft-Windows-IIS-W3SVC-WP'] and (EventID=2208)]]|

### HTTP Server could not create the main connection socket

|Property | Value |
|---|---|
|Severity|1|
|Enabled|True|
|AutoMitigate|True|
|EvaluationFrequency|PT15M|
|WindowSize|PT15M|
|Type|rows|
|Query|Event \| where  EventID in (2206) and EventLog == 'Application' and Source == 'Microsoft-Windows-IIS-W3SVC-WP'|
|Threshold|N/A|
|xPathQuery|Application!*[System[Provider[@Name='Microsoft-Windows-IIS-W3SVC-WP'] and (EventID=2206)]]|

### HTTP Server could not initialize its security

|Property | Value |
|---|---|
|Severity|1|
|Enabled|True|
|AutoMitigate|True|
|EvaluationFrequency|PT15M|
|WindowSize|PT15M|
|Type|rows|
|Query|Event \| where  EventID in (2201) and EventLog == 'Application' and Source == 'Microsoft-Windows-IIS-W3SVC-WP'|
|Threshold|N/A|
|xPathQuery|Application!*[System[Provider[@Name='Microsoft-Windows-IIS-W3SVC-WP'] and (EventID=2201)]]|

### HTTP Server could not initialize the socket library

|Property | Value |
|---|---|
|Severity|1|
|Enabled|True|
|AutoMitigate|True|
|EvaluationFrequency|PT15M|
|WindowSize|PT15M|
|Type|rows|
|Query|Event \| where  EventID in (2203) and EventLog == 'Application' and Source == 'Microsoft-Windows-IIS-W3SVC-WP'|
|Threshold|N/A|
|xPathQuery|Application!*[System[Provider[@Name='Microsoft-Windows-IIS-W3SVC-WP'] and (EventID=2203)]]|

### HTTP Server was unable to initialize due to a shortage of available memory

|Property | Value |
|---|---|
|Severity|1|
|Enabled|True|
|AutoMitigate|True|
|EvaluationFrequency|PT15M|
|WindowSize|PT15M|
|Type|rows|
|Query|Event \| where  EventID in (2204) and EventLog == 'Application' and Source == 'Microsoft-Windows-IIS-W3SVC-WP'|
|Threshold|N/A|
|xPathQuery|Application!*[System[Provider[@Name='Microsoft-Windows-IIS-W3SVC-WP'] and (EventID=2204)]]|

### ISAPI application error detected

|Property | Value |
|---|---|
|Severity|1|
|Enabled|True|
|AutoMitigate|True|
|EvaluationFrequency|PT15M|
|WindowSize|PT15M|
|Type|rows|
|Query|Event \| where  EventID in (2274,2268,2220,2219,2214) and EventLog == 'Application' and Source == 'Microsoft-Windows-IIS-W3SVC-WP'|
|Threshold|N/A|
|xPathQuery|Application!*[System[Provider[@Name='Microsoft-Windows-IIS-W3SVC-WP'] and (EventID=2274 or EventID=2268 or EventID=2220 or EventID=2219 or EventID=2214)]]|

### Job object associated with the application pool encountered an error

|Property | Value |
|---|---|
|Severity|1|
|Enabled|True|
|AutoMitigate|True|
|EvaluationFrequency|PT15M|
|WindowSize|PT15M|
|Type|rows|
|Query|Event \| where  EventID in (5088,5061,5060) and EventLog == 'System' and Source == 'Microsoft-Windows-WAS'|
|Threshold|N/A|
|xPathQuery|System!*[System[Provider[@Name='Microsoft-Windows-WAS'] and (EventID=5088 or EventID=5061 or EventID=5060)]]|

### Module has an invalid precondition

|Property | Value |
|---|---|
|Severity|1|
|Enabled|True|
|AutoMitigate|True|
|EvaluationFrequency|PT15M|
|WindowSize|PT15M|
|Type|rows|
|Query|Event \| where  EventID in (2296) and EventLog == 'Application' and Source == 'Microsoft-Windows-IIS-W3SVC-WP'|
|Threshold|N/A|
|xPathQuery|Application!*[System[Provider[@Name='Microsoft-Windows-IIS-W3SVC-WP'] and (EventID=2296)]]|

### Module registration error detected (failed to find RegisterModule entrypoint)

|Property | Value |
|---|---|
|Severity|1|
|Enabled|True|
|AutoMitigate|True|
|EvaluationFrequency|PT15M|
|WindowSize|PT15M|
|Type|rows|
|Query|Event \| where  EventID in (2295) and EventLog == 'Application' and Source == 'Microsoft-Windows-IIS-W3SVC-WP'|
|Threshold|N/A|
|xPathQuery|Application!*[System[Provider[@Name='Microsoft-Windows-IIS-W3SVC-WP'] and (EventID=2295)]]|

### Module registration error detected (module returned an error during registration)

|Property | Value |
|---|---|
|Severity|1|
|Enabled|True|
|AutoMitigate|True|
|EvaluationFrequency|PT15M|
|WindowSize|PT15M|
|Type|rows|
|Query|Event \| where  EventID in (2293) and EventLog == 'Application' and Source == 'Microsoft-Windows-IIS-W3SVC-WP'|
|Threshold|N/A|
|xPathQuery|Application!*[System[Provider[@Name='Microsoft-Windows-IIS-W3SVC-WP'] and (EventID=2293)]]|

### Only one type of logging can be enabled at a time

|Property | Value |
|---|---|
|Severity|1|
|Enabled|True|
|AutoMitigate|True|
|EvaluationFrequency|PT15M|
|WindowSize|PT15M|
|Type|rows|
|Query|Event \| where  EventID in (1133) and EventLog == 'System' and Source == 'Microsoft-Windows-IIS-W3SVC'|
|Threshold|N/A|
|xPathQuery|System!*[System[Provider[@Name='Microsoft-Windows-IIS-W3SVC'] and (EventID=1133)]]|

### SF_NOTIFY_READ_RAW_DATA filter notification is not supported in IIS 8

|Property | Value |
|---|---|
|Severity|1|
|Enabled|True|
|AutoMitigate|True|
|EvaluationFrequency|PT15M|
|WindowSize|PT15M|
|Type|rows|
|Query|Event \| where  EventID in (2261) and EventLog == 'Application' and Source == 'Microsoft-Windows-IIS-W3SVC-WP'|
|Threshold|N/A|
|xPathQuery|Application!*[System[Provider[@Name='Microsoft-Windows-IIS-W3SVC-WP'] and (EventID=2261)]]|

### The configuration manager for WAS did not initialize

|Property | Value |
|---|---|
|Severity|2|
|Enabled|True|
|AutoMitigate|True|
|EvaluationFrequency|PT15M|
|WindowSize|PT15M|
|Type|rows|
|Query|Event \| where  EventID in (5036) and EventLog == 'System' and Source == 'Microsoft-Windows-WAS'|
|Threshold|N/A|
|xPathQuery|System!*[System[Provider[@Name='Microsoft-Windows-WAS'] and (EventID=5036)]]|

### The directory specified for caching compressed content is invalid

|Property | Value |
|---|---|
|Severity|1|
|Enabled|True|
|AutoMitigate|True|
|EvaluationFrequency|PT15M|
|WindowSize|PT15M|
|Type|rows|
|Query|Event \| where  EventID in (2264) and EventLog == 'Application' and Source == 'Microsoft-Windows-IIS-W3SVC-WP'|
|Threshold|N/A|
|xPathQuery|Application!*[System[Provider[@Name='Microsoft-Windows-IIS-W3SVC-WP'] and (EventID=2264)]]|

### The Global Modules list is empty

|Property | Value |
|---|---|
|Severity|1|
|Enabled|True|
|AutoMitigate|True|
|EvaluationFrequency|PT15M|
|WindowSize|PT15M|
|Type|rows|
|Query|Event \| where  EventID in (2298) and EventLog == 'Application' and Source == 'Microsoft-Windows-IIS-W3SVC-WP'|
|Threshold|N/A|
|xPathQuery|Application!*[System[Provider[@Name='Microsoft-Windows-IIS-W3SVC-WP'] and (EventID=2298)]]|

### The HTTP server encountered an error processing the server side include file

|Property | Value |
|---|---|
|Severity|1|
|Enabled|True|
|AutoMitigate|True|
|EvaluationFrequency|PT15M|
|WindowSize|PT15M|
|Type|rows|
|Query|Event \| where  EventID in (2218) and EventLog == 'Application' and Source == 'Microsoft-Windows-IIS-W3SVC-WP'|
|Threshold|N/A|
|xPathQuery|Application!*[System[Provider[@Name='Microsoft-Windows-IIS-W3SVC-WP'] and (EventID=2218)]]|

### The server failed to close client connections to URLs during shutdown

|Property | Value |
|---|---|
|Severity|1|
|Enabled|True|
|AutoMitigate|True|
|EvaluationFrequency|PT15M|
|WindowSize|PT15M|
|Type|rows|
|Query|Event \| where  EventID in (2258) and EventLog == 'Application' and Source == 'Microsoft-Windows-IIS-W3SVC-WP'|
|Threshold|N/A|
|xPathQuery|Application!*[System[Provider[@Name='Microsoft-Windows-IIS-W3SVC-WP'] and (EventID=2258)]]|

### The server was unable to acquire a license for a SSL connection

|Property | Value |
|---|---|
|Severity|1|
|Enabled|True|
|AutoMitigate|True|
|EvaluationFrequency|PT15M|
|WindowSize|PT15M|
|Type|rows|
|Query|Event \| where  EventID in (2227) and EventLog == 'Application' and Source == 'Microsoft-Windows-IIS-W3SVC-WP'|
|Threshold|N/A|
|xPathQuery|Application!*[System[Provider[@Name='Microsoft-Windows-IIS-W3SVC-WP'] and (EventID=2227)]]|

### The server was unable to allocate a buffer to read a file

|Property | Value |
|---|---|
|Severity|1|
|Enabled|True|
|AutoMitigate|True|
|EvaluationFrequency|PT15M|
|WindowSize|PT15M|
|Type|rows|
|Query|Event \| where  EventID in (2233) and EventLog == 'Application' and Source == 'Microsoft-Windows-IIS-W3SVC-WP'|
|Threshold|N/A|
|xPathQuery|Application!*[System[Provider[@Name='Microsoft-Windows-IIS-W3SVC-WP'] and (EventID=2233)]]|

### The server was unable to read a file

|Property | Value |
|---|---|
|Severity|1|
|Enabled|True|
|AutoMitigate|True|
|EvaluationFrequency|PT15M|
|WindowSize|PT15M|
|Type|rows|
|Query|Event \| where  EventID in (2226,2230,2231,2232) and EventLog == 'Application' and Source == 'Microsoft-Windows-IIS-W3SVC-WP'|
|Threshold|N/A|
|xPathQuery|Application!*[System[Provider[@Name='Microsoft-Windows-IIS-W3SVC-WP'] and (EventID=2226 or EventID=2230 or EventID=2231 or EventID=2232)]]|

### WAS detected invalid configuration data

|Property | Value |
|---|---|
|Severity|1|
|Enabled|True|
|AutoMitigate|True|
|EvaluationFrequency|PT15M|
|WindowSize|PT15M|
|Type|rows|
|Query|Event \| where  EventID in (5174,5179,5180) and EventLog == 'System' and Source == 'Microsoft-Windows-WAS'|
|Threshold|N/A|
|xPathQuery|System!*[System[Provider[@Name='Microsoft-Windows-WAS'] and (EventID=5174 or EventID=5179 or EventID=5180)]]|

## Performance Counters

|Performance Counter|
|---|
|\Web Service(_Total)\Bytes Received/sec|
|\Web Service(_Total)\Bytes Sent/sec|
|\Web Service(_Total)\Bytes Total/sec|
|\Web Service(_Total)\Connection Attempts/sec|
|\Web Service(_Total)\Current Connections|
|\Web Service(_Total)\Total Method Requests/sec|
|\Microsoft FTP Service(_Total)\Bytes Total/sec|
|\Microsoft FTP Service(_Total)\Current Connections|
|\SMTP Server(_Total)\Bytes Received/sec|
|\SMTP Server(_Total)\Bytes Sent/sec|
|\SMTP Server(_Total)\Bytes Total/sec|
|\SMTP Server(_Total)\Inbound Connections Current|
|\SMTP Server(_Total)\Message Bytes Received/sec|
|\SMTP Server(_Total)\Message Bytes Sent/sec|
|\SMTP Server(_Total)\Messages Delivered/sec|
|\SMTP Server(_Total)\Messages Received/sec|
|\SMTP Server(_Total)\Messages Sent/sec|
|\SMTP Server(_Total)\Outbound Connections Current|
|\SMTP Server(_Total)\Total Messages Submitted|
|\SMTP Server(SMTP 1)\Bytes Received/sec|
|\SMTP Server(SMTP 1)\Bytes Sent/sec|
|\SMTP Server(SMTP 1)\Bytes Total/sec|
|\SMTP Server(SMTP 1)\Inbound Connections Current|
|\SMTP Server(SMTP 1)\Message Bytes Received/sec|
|\SMTP Server(SMTP 1)\Message Bytes Sent/sec|
|\SMTP Server(SMTP 1)\Messages Delivered/sec|
|\SMTP Server(SMTP 1)\Messages Received/sec|
|\SMTP Server(SMTP 1)\Messages Sent/sec|
|\SMTP Server(SMTP 1)\Outbound Connections Current|
|\SMTP Server(SMTP 1)\Total Messages Submitted|
