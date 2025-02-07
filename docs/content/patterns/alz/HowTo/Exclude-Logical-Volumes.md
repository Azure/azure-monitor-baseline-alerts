---
title: Exclude logical volumes
geekdocCollapseSection: true
geekdocHidden: false
weight: 80
---

### In this page

> [Overview](../Exclude-Logical-Volumes#overview) </br>
> [How this feature works](../Exclude-Logical-Volumes#how-this-feature-works) </br>

## Overview

The ***Logical Volumes Exclusion*** feature, introduce the capability of excluding logical volumes from being alerted. This feature, introduced in the [2025-02-05 release](../../Overview/Whats-New#2025-02-05), enables both Greenfield and Brownfield customers to customize the exclusion of specific logical volumes (that is: ***D:*** or ***/snap/snapd/21759*** logical volumes) during or after the deployment of AMBA-ALZ. This feature, supported on both Windows and Linux based virtual machines also on both Azure and Hybrid virtual machines, allows the use of specific tags containing the logical volume names as value, to ensure the passed entities are not included in the disk alerts. This feature can be use with the alerts created by the following policies:

- *Deploy Azure VM OS Disk Read Latency Alert*
- *Deploy Azure VM OS Disk Space Alert*
- *Deploy Azure VM OS Disk Write Latency Alert*
- *Deploy Azure VM Data Disk Read Latency Alert*
- *Deploy Azure VM Data Disk Space Alert*
- *Deploy Azure VM Data Disk Write Latency Alert*
- *Deploy Hybrid VM OS Disk Read Latency Alert*
- *Deploy Hybrid VM OS Disk Space Alert*
- *Deploy Hybrid VM OS Disk Write Latency Alert*
- *Deploy Hybrid VM Data Disk Read Latency Alert*
- *Deploy Hybrid VM Data Disk Space Alert*
- *Deploy Hybrid VM Data Disk Write Latency Alert*

## How this feature works

This feature is applicable exclusively to log-search disk alerts. To use this feature, customers must create resource tags using one of the following allowed names on the target virtual machine:

- ***\_amba-ExcludedLogicalVolumes-ReadLatency\_***
- ***\_amba-ExcludedLogicalVolumes-DiskSpace\_***
- ***\_amba-ExcludedLogicalVolumes-WriteLatency\_***

The value for these tags has to be populated with the logical volume names. The tags and their values will be used in the log-search alert query as an exclusion list. If a given logical volume is included the list, it will be excluded from the query results. It is supported to enter multiple logical volume names provided that they are separated by comma (**,**). It is only supported the full logical volume name and not just a part of it, hence the name must be entered exactly as it appears: for Windows-based virtual machines, the value must include the column (**:**) symbol whilst for the Linux one it must match the full logical volume name. The following examples provide a detailed guidance on how to configure some exclusions for the disk space alert:

- To exclude the logical volume ***D:*** on a Windows-based virtual machine, create the ***\_amba-ExcludedLogicalVolumes-DiskSpace\_*** and enter ***D:*** as value

    ![Windows - Single logical volume exclusion](../../media/Windows-ExcludedFS-One-Volume.png)

- To exclude both ***D:*** and ***E:*** logical volumes on a Windows-based virtual machine, create the ***\_amba-ExcludedLogicalVolumes-DiskSpace\_*** and enter ***D:, E:*** as value

  ![Windows - Multiple logical volumes exclusion](../../media/Windows-ExcludedFS-Multiple-Volumes.png)

- To exclude the logical volume called  ***/snap/snapd/21759*** on a Linux-based virtual machine, create the ***\_amba-ExcludedLogicalVolumes-DiskSpace\_*** and enter ***/snap/snapd/21759*** as value

  ![Linux - Single logical volume exclusion](../../media/Linux-ExcludedFS-One-Volume.png)

- To exclude both ***/snap/core20/2379*** and ***/snap/snapd/21759*** logical volumes on a Linux-based virtual machine, create the ***\_amba-ExcludedLogicalVolumes-DiskSpace\_*** and enter ***/snap/core20/2379, /snap/snapd/21759*** as value

  ![Linux - Multiple logical volumes exclusion](../../media/Linux-ExcludedFS-Multiple-Volumes.png)

The same approach can be followed to configure disk exclusion for either Read or Write Latency or both.

After deploying this release, the ***\_amba-ExcludedLogicalVolumes-DiskSpace\_*** tag can be created either before or after the remediation task execution.
