---
title: ADDS
geekdocCollapseSection: true
weight: 50
---
[Performance Counters](#performance-counters)

## Performance Counters

|Performance Counter|
|---|
|\Memory()\Available Bytes|
|\Memory()\Committed Bytes|
|\DirectoryServices(NTDS)\DS Search sub-operations/sec|
|\Security System-Wide Statistics()\KDC AS Requests|
|\Security System-Wide Statistics()\KDC TGS Requests|
|\Security System-Wide Statistics()\Kerberos Authentications|
|\DirectoryServices(NTDS)\LDAP Client Sessions|
|\DirectoryServices(NTDS)\LDAP Searches/sec|
|\DirectoryServices(NTDS)\LDAP UDP operations/sec|
|\DirectoryServices(NTDS)\LDAP Writes/sec|
|\Process(LSASS)\Handle Count|
|\Process(LSASS)\Private Bytes|
|\Process(LSASS)\% Processor Time|
|\Security System-Wide Statistics()\NTLM Authentications|
|\Memory()\Pages/sec|
|\Processor(_Total)\% Processor Time|
|\Server()\Server Sessions|
|\System()\System Up Time|
|\TCPv4()\Connections Established|
|\TCPv6()\Connections Established|
|\DirectoryServices(NTDS)\DRA Inbound Bytes Compressed (Between Sites, Before Compression)/sec|
|\DirectoryServices(NTDS)\DRA Inbound Bytes Compressed (Between Sites, After Compression)/sec|
|\DirectoryServices(NTDS)\DRA Inbound Bytes Not Compressed (Within Site)/sec|
|\DirectoryServices(NTDS)\DRA Inbound Bytes Total/sec|
|\DirectoryServices(NTDS)\DRA Outbound Bytes Compressed (Between Sites, After Compression)/sec|
|\DirectoryServices(NTDS)\DRA Outbound Bytes Compressed (Between Sites, Before Compression)/sec|
|\DirectoryServices(NTDS)\DRA Outbound Bytes Not Compressed (Within Site)/sec|
|\DirectoryServices(NTDS)\DRA Outbound Bytes Total/sec|
|\Process(dns)\% Processor Time|
|\DNS()\Total Query Received/sec|
|\Process(dns)\Private Bytes|
|\DirectoryServices(NTDS)\ATQ Outstanding Queued Requests|
|\DirectoryServices(NTDS)\ATQ Request Latency|
|\DirectoryServices(NTDS)\ATQ Threads Other|
|\DirectoryServices(NTDS)\ATQ Threads LDAP|
|\DirectoryServices(NTDS)\ATQ Threads Total|

## Augmented Metrics

These metrics are added to log analytics to the custom adds table.

|Metric|Description|Unit|Type|
|---|---|---|---|
|ADLogFileDriveDiskSpacePctUsed|AD Log File Drive Disk Space Percentage Used|Percentage|Gauge|
|ADDSADDBDrivePctFree|ADDS AD DB Drive Percentage Free|Percentage|Gauge|
|ADDitFileSize|AD Dit File Size|Bytes|Gauge|
|ADDSLFObjCount|AD DS Lost and Found Object Count|Count|Gauge|
