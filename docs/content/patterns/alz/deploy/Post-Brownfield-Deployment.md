---
title: Brownfield post-deployment actions
geekdocCollapseSection: true
weight: 40
---

## Overview

The term *brownfield* identifies an environment in which the preview version of Azure Monitor Baseline Alerts (AMBA) has been previously deployed. As opposite, the term *greenfield* indicates an environment wit no previous version of AMBA installed.

New AMBA versions are built to allow for previous installations update, however some post-deployment actions are required to align brownfield to *greenfield* deployments.

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

1. Navigate to ***Management Groups*** and select the management group (corresponding to the value entered for the *enterpriseScaleCompanyPrefix* during the deployment) were AMBA deployment was targeted to
2. Select ***Access control (IAM)***
3. Select each ***Identity not found*** entry and click ***Remove***
