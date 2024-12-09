---
title: Known Issues
geekdocCollapseSection: true
weight: 100
---

## Host Pool Capacity Remaining not reporting
After 3/21/24 there was a permission missing that did not allow the automation account to gather the information.
(Fixed on: 12/10/2024)

Fix without Redeploying:
Simply assigning the identity tied to the Automation Account the Virtual Desktop Reader role on the Resource Group that houses the Host Pools.

## Remaining Storage Calculation always 99.xx% / INCORRECT
Prior to 6/29/2024

