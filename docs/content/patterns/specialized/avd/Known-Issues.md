---
title: Known Issues
geekdocCollapseSection: true
weight: 100
---

## VM in Separate Resource Group option fails deployment (Issue #457)
Updated the custom UI definition to no longer hide the AVD Resource Resource Group selection when selecting option for VMs in seperate resource group(s). This will ensure the value is passed into the ARM template for processing verses the previously noted place holder value of 'Resource Group' with brackets.
(Fixed on 12/18/24 - v2.2.0)

## Action Group in subsequent deployment fails (Issue #315)
Action Group creation now gets appended with a unique 13 character value based on the hash of the Subscription Name and current time. This will allow for subsequent deployments to ensure the action group name is unique across subscriptions.
(Fixed on 12/18/24 - v2.1.8)

## Host Pool Capacity Remaining not reporting (Issue #288)
After 3/21/24 there was a permission missing that did not allow the automation account to gather the information.
(Fixed on: 12/10/2024 - v2.1.7)

Fix without Redeploying:
Simply assigning the identity tied to the Automation Account the Virtual Desktop Reader role on the Resource Group that houses the Host Pools.

## Remaining Storage Calculation always 99.xx% / INCORRECT
Prior to 6/29/2024

