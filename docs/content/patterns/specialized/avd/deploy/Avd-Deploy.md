---
title: Deploying the AVD pattern
geekdocCollapseSection: true
weight: 50
---

## Background

The Azure Virtual Desktop portal within Azure has a really great feature with regards to knowing the status of all things AVD via the provided Insights. However with the provided workbook it is not possible to create alerts based on what you see in Insights or having some knowledge of Log Analytics and Kusto queries.  In order to provide customers with a quick list of common alerts and pre-created queries based on recommendations between the community with coordination with the Product Group, this solution was created.  The alerts are intended to be disabled upon initial deployment to provide you with a method to phase in what you want to be alerted on, and verify the threshold values that work for your environment.  

## Prerequisites

An AVD deployment with associated Insights configuration per the AVD Portal's AVD Insights Configuration workbook.  
1. An Azure Tenant and Subscription
2. At least 1 Host Pool with Session Hosts deployed
3. Log Analytics Workspace for AVD with diagnostics enabled per the configuration workbook.
    - Host Pool Diagnostics enabled
    - Workspace Diagnostics enabled
    - Data Collection Rule associated with the Log Analytics Workspace
4. Storage either Azure Files or Azure NetApp Files configured for FSLogix Profiles (optional)

## Deploy via the Azure Portal UI  

[![Deploy to Azure](https://aka.ms/deploytoazurebutton)](https://portal.azure.com/#blade/Microsoft_Azure_CreateUIDef/CustomDeploymentBlade/uri/https%3A%2F%2Fraw.githubusercontent.com%2FAzure%2Fazure-monitor-baseline-alerts%2Fmain%2Fpatterns%2Favd%2FavdArm.json/uiFormDefinitionUri/https%3A%2F%2Fraw.githubusercontent.com%2FAzure%2Fazure-monitor-baseline-alerts%2Fmain%2Fpatterns%2Favd%2FavdCustomUi.json) [![Deploy to Azure Gov](https://aka.ms/deploytoazuregovbutton)](https://portal.azure.us/#blade/Microsoft_Azure_CreateUIDef/CustomDeploymentBlade/uri/https%3A%2F%2Fraw.githubusercontent.com%2FAzure%2Fazure-monitor-baseline-alerts%2Fmain%2Fpatterns%2Favd%2FavdArm.json/uiFormDefinitionUri/https%3A%2F%2Fraw.githubusercontent.com%2FAzure%2Fazure-monitor-baseline-alerts%2Fmain%2Fpatterns%2Favd%2FavdCustomUi.json)

## View / Enable Alerts after deployment

By design the alerts solution is deployed with all alerts being disabled in order to provide administrators to view, adjust and enable them in phases or as needed. It is recommended to start with only a few to ensure the thresholds meet your needs and false alerts are not produced or an overwhelming number of alerts flood an email account. 

You can also review the Alert Action Group and adjust as needed with additional email addresses or other methods for recieving notifications.  

1. Open the [Alerts Azure Portal Page](https://portal.azure.com/#blade/Microsoft_Azure_Monitoring/AzureMonitoringBrowseBlade/alertsV2)  
2. Click on the "Alert rules" section at the top of the page.  
<img src="../../../../../img/Avd/avdAlertRules.jpg" width=30%>
 
3. Initially the list of alert rules may be filtered out or appear missing.  Simply change the filter to include "disabled" or click the "Clear filters" option.  
<img src="../../../../../img/Avd/avdAlertRulesFilter.jpg" width=30%>

4. Select the check box next to each you would like to enable and click "Enable" at the top of the page.  
<img src="../../../../../img/Avd/avdAlertRulesEnable.jpg" width=30%>