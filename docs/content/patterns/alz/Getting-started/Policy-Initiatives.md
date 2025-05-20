---
title: Policy Initiatives
geekdocCollapseSection: true
weight: 40
---

### In this page

> [Overview](../Policy-Initiatives#overview) </br>
> [Connectivity Initiative](../Policy-Initiatives#connectivity-initiative) </br>
> [Management Initiative](../Policy-Initiatives#management-initiative) </br>
> [Identity Initiative](../Policy-Initiatives#identity-initiative) </br>
> [Key Management Initiative](../Policy-Initiatives#key-management-initiative) </br>
> [Load Balancing Initiative](../Policy-Initiatives#load-balancing-initiative) </br>
> [Network Changes Initiative](../Policy-Initiatives#network-changes-initiative) </br>
> [Recovery Services Initiative](../Policy-Initiatives#recovery-services-initiative) </br>
> [Storage Initiative](../Policy-Initiatives#storage-initiative) </br>
> [VM Initiative](../Policy-Initiatives#vm-initiative) </br>
> [Web Initiative](../Policy-Initiatives#web-initiative) </br>
> [Hybrid VM Initiative](../Policy-Initiatives#hybrid-vm-initiative) </br>
> [Service Health Initiative](../Policy-Initiatives#service-health-initiative) </br>
> [Notification Assets Initiative](../Policy-Initiatives#notification-assets-initiative) </br>
> [Landing Zone Initiative (Deprecated)](../Policy-Initiatives#landing-zone-initiative-deprecated) </br>

## Overview

This document details the AMBA-ALZ pattern Azure policy initiatives used for deploying the AMBA-ALZ baselines. For references on individual alerts/policies, refer to [Alert Details](../..//Getting-started//Alerts-Details).

## Connectivity initiative

This initiative is intended for relevant policy assignment to networking components in ALZ. Using the guidance provided in [Introduction to deploying the AMBA-ALZ Pattern](../../HowTo/deploy/Introduction-to-deploying-the-ALZ-Pattern), this will assign policies to the alz-platform-connectivity management group structure in the ALZ reference architecture. For details on the initiative policies and their default enablement state, refer to the table below.

{{% include "Alerting-Connectivity-PolicyInitiative-Table.md" %}}

## Management initiative

This initiative is intended for relevant policy assignment to management components in AMBA-ALZ. Using the guidance provided in [Introduction to deploying the AMBA-ALZ Pattern](../../HowTo/deploy/Introduction-to-deploying-the-ALZ-Pattern), this will assign policies to the alz-platform-management group structure in the ALZ reference architecture. For details on the initiative policies and their default enablement state, refer to the table below.

{{% include "Alerting-Management-PolicyInitiative-Table.md" %}}

## Identity initiative

This initiative is intended for relevant policy assignment to identity components in ALZ. Using the guidance provided in [Introduction to deploying the AMBA-ALZ Pattern](../../HowTo/deploy/Introduction-to-deploying-the-ALZ-Pattern), this will assign policies to the alz-platform-identity management group structure in the ALZ reference architecture. For details on the initiative policies and their default enablement state, refer to the table below.

{{% include "Alerting-Identity-PolicyInitiative-Table.md" %}}

## Key Management initiative

This initiative deploys Azure Monitor Baseline Alerts to monitor Key Management Services such as Azure Key Vault, and Managed HSM. Using the guidance provided in [Introduction to deploying the AMBA-ALZ Pattern](../../HowTo/deploy/Introduction-to-deploying-the-ALZ-Pattern) this will be assigned to the Landing Zones management group in the ALZ reference architecture. For details on the initiative policies and their default enablement state, refer to the table below.

{{% include "Alerting-KeyManagement-PolicyInitiative-Table.md" %}}

## Load Balancing initiative

This initiative deploys Azure Monitor Baseline Alerts to monitor Load Balancing Services such as Load Balancer, Application Gateway, Traffic Manager, and Azure Front Door. Using the guidance provided in [Introduction to deploying the AMBA-ALZ Pattern](../../HowTo/deploy/Introduction-to-deploying-the-ALZ-Pattern) this will be assigned to the Landing Zones management group in the ALZ reference architecture. For details on the initiative policies and their default enablement state, refer to the table below.

{{% include "Alerting-LoadBalancing-PolicyInitiative-Table.md" %}}

## Network Changes initiative

This initiative implements Azure Monitor Baseline Alerts to monitor alterations in Network Routing and Security, such as modifications to Route Tables and the removal of Network Security Groups. Using the guidance provided in [Introduction to deploying the AMBA-ALZ Pattern](../../HowTo/deploy/Introduction-to-deploying-the-ALZ-Pattern) this will be assigned to the Landing Zones management group in the ALZ reference architecture. For details on the initiative policies and their default enablement state, refer to the table below.

{{% include "Alerting-NetworkChanges-PolicyInitiative-Table.md" %}}

## Recovery Services initiative

This initiative deploys Azure Monitor Baseline Alerts to monitor Recovery Services such as Azure Backup, and Azure Site Recovery. Using the guidance provided in [Introduction to deploying the AMBA-ALZ Pattern](../../HowTo/deploy/Introduction-to-deploying-the-ALZ-Pattern) this will be assigned to the Landing Zones management group in the ALZ reference architecture. For details on the initiative policies and their default enablement state, refer to the table below.

{{% include "Alerting-RecoveryServices-PolicyInitiative-Table.md" %}}

## Storage initiative

This initiative deploys Azure Monitor Baseline Alerts to monitor Storage Services such as Storage accounts. Using the guidance provided in [Introduction to deploying the AMBA-ALZ Pattern](../../HowTo/deploy/Introduction-to-deploying-the-ALZ-Pattern) this will be assigned to the Landing Zones management group in the ALZ reference architecture. For details on the initiative policies and their default enablement state, refer to the table below.

{{% include "Alerting-Storage-PolicyInitiative-Table.md" %}}

## VM initiative

This initiative deploys Azure Monitor Baseline Alerts to monitor Azure Virtual Machines. Using the guidance provided in [Introduction to deploying the AMBA-ALZ Pattern](../../HowTo/deploy/Introduction-to-deploying-the-ALZ-Pattern) this will be assigned to the Landing Zones management group in the ALZ reference architecture. For details on the initiative policies and their default enablement state, refer to the table below.

{{% include "Alerting-VM-PolicyInitiative-Table.md" %}}

## Web initiative

This initiative deploys Azure Monitor Baseline Alerts to monitor Web Services such as App Services. It is intended for relevant policy assignment to a landing zone in the ALZ structure. Using the guidance provided in [Introduction to deploying the AMBA-ALZ Pattern](../../HowTo/deploy/Introduction-to-deploying-the-ALZ-Pattern) this will be assigned to the Landing Zones management group in the ALZ reference architecture. For details on the initiative policies and their default enablement state, refer to the table below.

{{% include "Alerting-Web-PolicyInitiative-Table.md" %}}

## Hybrid VM initiative

This initiative is intended for relevant policy assignment to Hybrid VM alerts in AMBA-ALZ. Using the guidance provided in [Introduction to deploying the AMBA-ALZ Pattern](../../HowTo/deploy/Introduction-to-deploying-the-ALZ-Pattern), this will be assigned to the 'alz' intermediate root management group structure in the ALZ reference architecture. For details on the initiative policies and their default enablement state, refer to the table below.

{{% include "Alerting-HybridVM-PolicyInitiative-Table.md" %}}

## Service Health initiative

This initiative is intended for relevant policy assignment service health alerts in ALZ. Using the guidance provided in [Introduction to deploying the AMBA-ALZ Pattern](../../HowTo/deploy/Introduction-to-deploying-the-ALZ-Pattern), this will assign to the alz intermediate root management group structure in the ALZ reference architecture. For details on the initiative policies and their default enablement state, refer to the table below.

{{% include "Alerting-ServiceHealth-PolicyInitiative-Table.md" %}}

## Notification Assets initiative

This initiative is intended for relevant policy assignment to notification in AMBA-ALZ. Using the guidance provided in [Introduction to deploying the AMBA-ALZ Pattern](../../HowTo/deploy/Introduction-to-deploying-the-ALZ-Pattern), this will assign to the alz intermediate root management group structure in the ALZ reference architecture. For details on the initiative policies and their default enablement state, refer to the table below.

{{% include "Notification-Assets-PolicyInitiative-Table.md" %}}

## Landing Zone initiative (Deprecated)

{{< hint type=note >}}
This initiative has been ***DEPRECATED*** and the content is still included in the documentation for reference purpose only.
{{< /hint >}}

This initiative is intended for relevant policy assignment to a landing zone in the ALZ structure. Using the guidance provided in [Introduction to deploying the AMBA-ALZ Pattern](../../HowTo/deploy/Introduction-to-deploying-the-ALZ-Pattern) this will be assigned to the Landing Zones management group in the ALZ reference architecture. For details on the initiative policies and their default enablement state, refer to the table below.

{{% include "Alerting-LandingZone-PolicyInitiative-Table.md" %}}
