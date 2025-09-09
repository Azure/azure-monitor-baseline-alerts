---
title: Azure Monitoring Packs
geekdocCollapseSection: true
---

## Azure Monitoring Packs (FKA MonStar Packs)

The Azure Monitoring packs in an open source initiative looking to provide another way to quickly enable monitoring for different services and workloads. It is an ongoing project that gladly welcomes contribution from the community.

The Azure Monitoring Packs are also known as the Azure Monitoring Starter Packs (or MonStar packs).

The Monitoring packs, once installed, will install an Azure Function and a Logic App (among other supporting components) to automate the enablement of the monitoring based on a friendly Azure Workbook interface.

## Objectives

- Minimize the initial ramp up required for customers, in multiple aspects of the Azure technologies to deploy basic monitoring.

- Minimize the need for the Customer to determine the minimal monitoring items for a certain type of workload

- Provide best practices out of the box on items that need monitoring for different workloads. The Monitoring Packs work closely with the Azure Monitor Baseline Alerts [AMBA](http://aka.ms/amba) and the Azure Monitor teams to provide a comprehensive and aligned monitoring solution.

- Create a framework for collaboration that will make it easy to add new monitored technologies.

For a details about the solution and setup, please refer to [Azure Monitoring Packs](https://github.com/Azure/AzureMonitorStarterPacks)

## Pre-requisites and recommendations

- Azure Subscription - an Azure subscription to deploy the components
- Owner permissions to the subscription

## Monitoring Packs

The IaaS packs are defined and provided by the Azure Monitoring packs solution. The services packs are based out of the definitions in Amba for each service.

Details can be found [here](https://github.com/Azure/AzureMonitorStarterPacks/blob/main/Packs/README.md#monitoring-pack-summary).


