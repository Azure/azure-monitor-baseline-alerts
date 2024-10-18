---
title: Artificial Intelligence
geekdocCollapseSection: true
---

## Overview

There are numerous ways to implement AI solution on Azure, and each comes with its own monitoring solution. Monitoring AI solutions involves a combination of the infra or paas resources, along with monitoring any utilization metrics that can be exposed through the platform or other tooling. This page will summarize the recommended monitoring solutions for different scenarios.

### AI on Azure platforms (PaaS)

Common AI Ready infrastructure on Azure may include services including Azure AI Hub, Azure AI Services including Azure OpenAI, AI Search etc. Specific workloads like Azure Kubernetes Services, API Management, App Services are also used to build enterprise level AI applications. Below table lists quick links to alert guidelines to most commonly used services, for other Azure service in your architecture, refer to the [Azure Resource](../../../../azure-monitor-baseline-alerts/services/) which provides more comprehensive lists.

| Services                      | Resource Type |
| ---                           | ---     |
| Azure AI Studio Hub/Azure Machine Learning Hub   |  [Microsoft.MachineLearningServices/workspaces](../../../../azure-monitor-baseline-alerts/services/MachineLearningServices/workspaces/)       |
| Azure AI Search                     |  [Microsoft.Search/searchServices](../../../../azure-monitor-baseline-alerts/services/Search/searchServices/)    |
| Azure AI Services             |  [Microsoft.CognitiveServices/accounts](../../../../azure-monitor-baseline-alerts/services/CognitiveServices/accounts)    |
| Azure Kubernetes Services     |  [Microsoft.ContainerService/managedClusters](../../../../azure-monitor-baseline-alerts/services/ContainerService/managedClusters/)    |
| Azure App Services            |  [Microsoft.Web/sites](../../../../azure-monitor-baseline-alerts/services/Web/sites/)    |
| Azure API Management          |  [lMicrosoft.ApiManagement/service](../../../../azure-monitor-baseline-alerts/services/ApiManagement/service/)    |
| Azure Container Apps          |  [Microsoft.App/containerApps](../../../../azure-monitor-baseline-alerts/services/App/containerApps//)    |
| Azure Functions Apps          |  [Microsoft.Web/sites](../../../../azure-monitor-baseline-alerts/services/Web/sites/)     |
| Azure Cosmos DB               |  [Microsoft.DocumentDB/databaseAccounts](../../../../azure-monitor-baseline-alerts/services/DocumentDB/databaseAccounts/)    |
| Azure SQL Database - managedInstances            |  [Microsoft.Sql/managedInstances](../../../../azure-monitor-baseline-alerts/services/Sql/managedInstances/)    |
| Azure SQL Database - server           |  [Microsoft.Sql/servers/databases](../../../../azure-monitor-baseline-alerts/services/Sql/servers/)    |
| Azure Database for MySQL      |  [Microsoft.DBforMySQL/servers](../../../../azure-monitor-baseline-alerts/services/DBforMySQL/servers/)    |
| Azure Database for PostgreSQL |  [Microsoft.DBforPostgreSQL/servers](../../../../azure-monitor-baseline-alerts/services/DBforPostgreSQL/servers//)    |

### AI on Azure infrastructure (IaaS)

Running AI workloads on Azure infrastructure involves monitoring each of the components of the solution, including virtual machines, storage, and networking. Refer to the defined metrics in [HPC](../../specialized/hpc/Alerting-and-Monitoring.md). For monitoring the GPU/CPU metrics, use [Moneo](https://github.com/Azure/Moneo)


### AI Specialized Workload Patterns

####    GPT-RAG (coming soon)
