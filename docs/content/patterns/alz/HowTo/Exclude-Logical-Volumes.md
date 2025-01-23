---
title: Exclude logical volumes
geekdocCollapseSection: true
geekdocHidden: true
weight: 80
---

### In this page

> [Overview](../Exclude-Logical-Volumes#overview) </br>
> [How this feature works](../Exclude-Logical-Volumes#how-this-feature-works) </br>

## Overview

The ***Logical Volumes Exclusion*** feature, introduce the capability of excluding logical volumes from being alerted. This feature, introduced in the [2025-02-05 release](../../Overview/Whats-New#2025-02-05), enables both Greenfield and Brownfield customers to customize the exclusion of specific logical volumes (i.e.: **D:** or **/snap/snapd/21759** logical volumes) during or after the deployment of AMBA-ALZ. This feature, supported on both Windows and Linux based virtual machines as well as on both Azure and Hybrid virtual machines, allows the use of a specific tag containing the logical volume names as its value, to ensure the passed entities are not included in the disk alerts.

## How this feature works

This feature is applicable exclusively to log-search disk alerts. To use this feature, customers must create a resource tag named **\_amba-ExcludedLogicalVolumes\_** on the target virtual machine. The value for this tag, has to be populated with the logica volume names. The tag and its value will be used in the log-search alert query as an exclusion list. If a given logical volume is included the list, it will be excluded from the query results. It is supported to enter multiple logical volume names provided that they are separated by comma (**,**). It is only supported the full logical volume name and not just a part of it, hence the name must be entered exactly as it appears: for Windows-based virtual machines, the value must include the column (**:**) symbol whilst for the Linux one it must match the full logical volume name. The following is an example of how to configure some exclusion:

- To exclude the logical volume **D:** on a Windows-based virtual machine, create the **\_amba-ExcludedLogicalVolumes\_** and enter **D:** as value

    ![Windows - Single logical volume exclusion](../../media/Windows-ExcludedFS-One-Volume.png)

- To exclude both **D:** and **E:** logical volumes on a Windows-based virtual machine, create the **\_amba-ExcludedLogicalVolumes\_** and enter **D:, E:** as value

  ![Windows - Multiple logical volumes exclusion](../../media/Windows-ExcludedFS-Multiple-Volumes.png)

- To exclude the logical volume called  **/snap/snapd/21759** on a Linux-based virtual machine, create the **\_amba-ExcludedLogicalVolumes\_** and enter **/snap/snapd/21759** as value

  ![Linux - Single logical volume exclusion](../../media/Linux-ExcludedFS-One-Volume.png)

- To exclude both **/snap/core20/2379** and **/snap/snapd/21759** logical volumes on a Linux-based virtual machine, create the **\_amba-ExcludedLogicalVolumes\_** and enter **/snap/core20/2379, /snap/snapd/21759** as value

  ![Linux - Multiple logical volumes exclusion](../../media/Linux-ExcludedFS-Multiple-Volumes.png)

After deploying this release, the **\_amba-ExcludedLogicalVolumes\_** tag can be created either before or after the remediation task execution.
