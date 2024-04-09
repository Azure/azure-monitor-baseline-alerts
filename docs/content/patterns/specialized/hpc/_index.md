---
title: High Performance Compute
geekdocCollapseSection: true
---

## Overview

High Performance Compute supports a variety of workloads. Seismic modeling, fluid dynamics, Artificial Intelligence workloads all require a more powerful level of compute, networking, and storage than other traditional workloads.  Monitoring these environments is critical to ensure continuity in business. You cannot measure what you do not measure. Monitoring HPC workload infrastructure involves implementing alerts and monitoring for Virtual Machines, Storage and Networking across the stack. Alerting for these resources involve monitoring CPU/GPU utilization, throughput/availability, and stability. In this section we provide alert recommendations for the following HPC centric resources:

* Virtual Machines
* Azure Batch Service
* Azure NetApp Files
* Azure Blob Storage
* Azure Managed Lustre Filesystem - Coming Soon!

Please note that an HPC Landing Zone is built on top of the best practices of the Azure Landing Zone. The approach for broader monitoring and alerting in the context of the Azure Landing Zone can be found [here](https://azure.github.io/azure-monitor-baseline-alerts/patterns/alz/Monitoring-and-Alerting/).

## Azure High Performance Computing on Demand

[Azure High Performance Computing on Demand (Az-HOP)](https://learn.microsoft.com/azure/cloud-adoption-framework/scenarios/azure-hpc/azure-hpc-landing-zone-accelerator) is our HPC Landing Zone accelerator. It provides Grafana Dashboards to monitor you cluster. It uses [Azure CycleCloud](https://learn.microsoft.com/azure/cyclecloud/overview?view=cyclecloud-8) as a scheduler.

## GPU Monitoring

We are working on explicit GPU metrics to monitor to for HPC/AI workloads. Until then, Azure HPC Ubuntu VMs come with [Moneo](https://github.com/Azure/Moneo)
