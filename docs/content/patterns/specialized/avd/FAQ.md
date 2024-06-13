---
title: Frequently Asked Questions
geekdocCollapseSection: true
weight: 80
---

## What are the Prerequisites?  

An AVD deployment and the Owner Role on the Subscription containing the AVD resources, VMs and Storage.  You must have also pre-configured the AVD Insights as it will enable diagnostic logging for the Host Pools and associated VMs in which the alerts rely on.  

## What's deployed to my Subscription?

The current solution will need an existing or on deployment create a resource group with predefined alerts related to AVD to include the storage, virtual machines an host pool.

## What's the cost?

While this is highly subjective on the environment, number of triggered alerts, etc. it was designed with cost in mind. The primary resources in this deployment are the Automation Account and Alerts. We recommend you enable alerts in stages and monitor costs, however the overall cost should be minimal.

