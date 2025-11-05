---
title: Frequently Asked Questions
geekdocCollapseSection: true
weight: 80
---

## What are the Prerequisites?  

An AVD deployment and the Owner Role on the Subscription containing the AVD resources, VMs and Storage.  You must have also pre-configured the AVD Insights as it will enable diagnostic logging for the Host Pools and associated VMs in which the alerts rely on.  

## What's deployed to my Subscription?

Names will be created with a standard 'avdmetrics' in the name and vary based on input for things like site, environment type, etc.

Resource Group starting with the name "rg-avdmetrics-" with the following:  

- Automation Account with a Runbook (for Host Pool Information not otherwise available)  
- Identity for the Automation Account in which the name will start with "aa-avdmetrics-"
- Logic App that execute every 5 minutes (Host Pool Info Runbook)

The Automation Account Identity will be assigned the following roles at the Subscription level:

- Desktop Virtualization Reader
- Reader and Data Access (Storage Specific)

## What's the cost?

While this is highly subjective on the environment, number of triggered alerts, etc. it was designed with cost in mind. The primary resources in this deployment are the Automation Account and Alerts. We recommend you enable alerts in stages and monitor costs, however the overall cost should be minimal.  

- Automation Account runs a script every 5 minutes to collect additional Azure File Share data and averages around $5/month
- Alert Rules vary based on number of times triggered but estimates are under $1/mo each.
- Private Endpoints (if used) are charged at standard Azure Private Endpoint rates

## Can I deploy with private endpoints?

Yes! The solution supports configuring private endpoints for the Automation Account. This is useful when Azure policies block public network access. During deployment, you can:

1. Configure the public network access setting (Enabled/Disabled)
2. Provide a subnet resource ID where private endpoints will be created
3. Optionally specify private DNS zone resource IDs for proper name resolution

The deployment will automatically create two private endpoints (Webhook and DSCAndHybridWorker) to ensure full Automation Account functionality.

## My organization blocks public access to Automation Accounts. Will this work?

Yes, the solution now supports private endpoint configuration. During deployment, set the public network access to "Disabled" and configure the private endpoint settings with your subnet and DNS zone information. The Automation Account will be configured with private endpoints for secure access without public internet exposure.


