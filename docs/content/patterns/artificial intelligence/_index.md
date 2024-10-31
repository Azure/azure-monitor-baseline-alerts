---
title: Artificial Intelligence
geekdocCollapseSection: true
---

## Overview

There are numerous ways to implement AI solution on Azure, and each comes with its own monitoring solution. Monitoring AI solutions involves a combination of the infra or paas resources, along with monitoring any utilization metrics that can be exposed through the platform or other tooling. This page will summarize the recommended monitoring solutions for different scenarios.

### AI on Azure Platforms (PaaS)

Common AI Ready infrastructures on Azure may contain services such as Azure AI Hub, Azure AI Services (including Azure OpenAI) and AI Search. Specific workloads like Azure Kubernetes services, API Management and App Services are also frequently used to build enterprise-level AI applications.
The table below provides quick links to alert guidelines for the most commonly used services. For other Azure services in your architecture, please refer to the [Azure Resource](../../services/), which offers comprehensive lists.

|Services|Resource Type|
|---     |---          |
|Azure AI Studio Hub/Azure Machine Learning |[Microsoft.MachineLearningServices/workspaces](../../services/machineLearningServices/workspaces/)|
|Azure AI Search|[Microsoft.Search/searchServices](../../services/Search/searchServices/)|
|Azure AI Services |[Microsoft.CognitiveServices/accounts](../../services/CognitiveServices/accounts/)|
|Azure Kubernetes services |[Microsoft.ContainerService/managedClusters](../../services/ContainerService/managedClusters/)|
|Azure App Services |[Microsoft.Web/sites](../../services/Web/sites/)|
|Azure API Management |[Microsoft.ApiManagement/service](../../services/ApiManagement/service/)|
|Azure Container Apps |[Microsoft.App/containerApps](../../services/App/containerApps/)|
|Azure Functions Apps |[Microsoft.Web/sites](../../services/Web/sites/)|
|Azure Cosmos DB |[Microsoft.DocumentDB/databaseAccounts](../../services/DocumentDB/databaseAccounts/)|
|Azure SQL Database - managedInstances |[Microsoft.Sql/managedInstances](../../services/Sql/managedInstances/)|
|Azure SQL Database - server |[Microsoft.Sql/servers/databases](../../services/Sql/servers/)|
|Azure Database for MySQL - flexibleServers|[Microsoft.DBforMySQL/flexibleServers](../../services/DBforMySQL/flexibleServers/)|
|Azure Database for MySQL - servers |[Microsoft.DBforMySQL/servers](../../services/DBforMySQL/servers/)|
|Azure Database for PostgreSQL - flexibleServers|[Microsoft.DBforPostgreSQL/flexibleServers](../../services/DBforPostgreSQL/flexibleServers/)|
|Azure Database for PostgreSQL - servers|[Microsoft.DBforPostgreSQL/servers](../../services/DBforPostgreSQL/servers/)|



### AI on Infrastructure (IaaS)

Running AI workloads on Azure infrastructure involves monitoring each of the components of the solution, including virtual machines, storage, and networking. Refer to the defined metrics in [HPC](../../specialized/hpc/Alerting-and-Monitoring.md). For monitoring the GPU/CPU metrics, use [Moneo](https://github.com/Azure/Moneo)



### AI Specialized Workload Patterns

#### [GPT-RAG](./rag/)
