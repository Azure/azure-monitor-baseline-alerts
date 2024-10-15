---
title: Artificial Intelligence
geekdocCollapseSection: true
---

# Overview

There are numerous ways to implement AI solution on Azure, and each comes with its own monitoring solution. Monitoring AI solutions involves a combination of the infra or paas resources, along with monitoring any utilization metrics that can be exposed through the platform or other tooling. This page will summarize the recommended monitoring solutions for different scenarios.

## AI on Infrastructure (BYOM)

Running AI workloads on Azure infrastructure involves monitoring each of the components of the solution, including virtual machines, storage, and networking. Refer to the defined metrics in [HPC](../../specialized/hpc/Alerting-and-Monitoring.md). For monitoring the GPU/CPU metrics, use [Moneo](https://github.com/Azure/Moneo)
