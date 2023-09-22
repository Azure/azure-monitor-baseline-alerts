---
title: Brownfield post-deployment actions
geekdocCollapseSection: true
weight: 40
---

## Overview

The term *brownfield* identifies an environment in which the preview version of Azure Monitor Baseline Alerts (AMBA) has been previously deployed. As opposite, the term *greenfield* indicates an environment wit no previous version of AMBA installed.

New AMBA versions are built to allow for update from preview version installation, however some post-deployment actions are required to align brownfield to *greenfield* deployments.

## 1. Delete unnecessary alerts

The preview version of AMBA (named alz-monitor) deployed 2 alerts which have been updated and enhanced. Hence, the old version of them can be deleted. To do so:

1. Navigate to ***Monitor*** --> ***Alerts***
2. Click on ***Alert rules***
3. In the search box, type ***lowdatadisk***
4. Select the alerts listed below and click on ***Delete***
   - ***VMLowdataDiskReadLatencyAlert***
   - ***VMLowdataDiskWriteLatencyAlert***

## 2. Delete the old policy assignments

The preview version of AMBA created policy assignments recognizable by the name starting with ***ALZ Monitoring Alerts for***. These assignments are no longer necessary and can be deleted. To delete them:

1. Navigate to ***Policy*** --> ***Assignements***
2. In the search box, type ***ALZ Monitoring Alerts for***
3. Select, one after another, the assignements listed below and once the new blade opens, click ***Delete assignment***
    - ***ALZ Monitoring Alerts for LandingZones***
    - ***ALZ Monitoring Alerts for Service Health***
    - ***ALZ Monitoring Alerts for Identity***
    - ***ALZ Monitoring Alerts for Management***
    - ***ALZ Monitoring Alerts for Connectivity***

## 3. Delete orphaned role assignements

As part of the installation on a brownfield environment, the role assignment are recreated. Once the old policy assignments are deleted, the previous role assignments become orphaned, hence can be deleted. Follow the steps below to delete them:

1. Navigate to ***Management Groups***
2. Select the management group (corresponding to the value entered for the *enterpriseScaleCompanyPrefix* during the deployment) were AMBA deployment was targeted to
3. Select ***Access control (IAM)***
4. Under the ***Contributor*** role, select all records named ***Identity not found*** entry and click ***Remove***

## 4. Fix deployment location

When updating from a preview version, the following policy definitions might fail to remediate:

| Policy Definition | Referenced in Policy Initiative |
| ----------------- | ---------------- |
| - Deploy Alert Processing Rule </br> - Deploy Resource Health Unhealthy Alert </br> - Deploy Service Health Advisory Alert </br> - Deploy Service Health Incident Alert </br> - Deploy Service Health Maintenance Alert </br> - Deploy Service Health Security Advisory Alert | ***Deploy Azure Monitor Baseline Alerts for Service Health*** |
| - Deploy Activity Log Key Vault Delete Alert | ***Deploy Azure Monitor Baseline Alerts for Identity*** |
| - Deploy Activity Log LA Workspace Delete Alert </br> - Deploy Activity Log LA Workspace Regenerate Key Alert| ***Deploy Azure Monitor Baseline Alerts for Management*** |
| - Deploy Activity Log NSG Delete Alert </br> - Deploy Activity Log Route Table Update Alert </br> - Deploy VM HeartBeat Alert </br> - Deploy VM Network Read Alert </br> - Deploy VM Network Write Alert </br> - Deploy VM OS Disk Read Latency Alert </br> - Deploy VM OS Disk Write Latency Alert </br> - Deploy VM OS Disk Space Alert </br> - Deploy VM CPU Alert </br> - Deploy VM Memory Alert </br> - Deploy VM Data Disk Space Alert </br> - Deploy VM Data Disk Read Latency Alert </br> - Deploy VM Data Disk Write Latency Alert | ***Deploy Azure Monitor Baseline Alerts for Landing Zone*** |
| - Deploy Activity Log Azure FireWall Delete Alert </br> - Deploy Activity Log VPN Gateway Delete Alert | ***Deploy Azure Monitor Baseline Alerts for Connectivity*** |

To fix the issue and to allow the remeditation to complete successfully, follow the steps below to change the deployment location on the above affected policy definitions to deploy in ***northeurope*** region:

1. Navigate to ***Policy*** --> ***Definitions***
2. Select the policy initiatice which contains the affected policy definitions (i.e. ***Deploy Azure Monitor Baseline Alerts for Management***)
3. Click on the affected policy definition and clik on ***Edit definition***
4. In the template, scroll down to

    *"deplyment": { </br>
    &emsp;"location": "westeurope", </br>
    &emsp;"properties": "{"

    > [!NOTE]
    > The location appearing here could be different from the *westeurope+ used in the example. Make sure to change it to ***northeurope***

5. At the end of the page click ***Save***
6. Repeate steps 3 to 5 for the other policy definitions
