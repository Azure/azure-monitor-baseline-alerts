---
title: Updating to release 2025-03-03
geekdocCollapseSection: true
weight: 92
---

### In this page

> [Pre update actions](#pre-update-actions) </br>
> [Update](#update)

## Pre update actions

In this release, we have enabled the option of saving log-search alert rules in Customer-managed key protected storage account linked to the workspace. Guidance and considerations for this option can be found in the following article: [Azure Monitor customer-managed keys](https://learn.microsoft.com/en-us/azure/azure-monitor/logs/customer-managed-keys?tabs=portal). </br>
However, adding this option requires a breaking change because of the number of parameters a given policy definition supports. The hard platform limit is fixed to 20 (see [Azure Policy limits](https://learn.microsoft.com/en-us/azure/azure-resource-manager/management/azure-subscription-service-limits#azure-policy-limits) for more information), hence we had to remove some parameters which were not really useful. Unfortunately removing a parameter from a policy definition breaks the backward compatibility. In this case to deploy the new policy it is necessary to remove the previous version first.</br>
To ease the update process and successfully update an existing deployment, it is possible to use the [Start-AMBA-ALZ-Maintenance.ps1](https://github.com/Azure/azure-monitor-baseline-alerts/blob/main/patterns/alz/scripts/Start-AMBA-ALZ-Maintenance.ps1) script to clean up the deployment.</br>
For instructions on running the script, refer to the documentation available on the [Clean-up AMBA-ALZ Deployment](../../Cleaning-up-a-Deployment) page, ensuring that you enter **Amba-Alz** as the value for the ***-cleanItems*** script parameter:

```powershell
.\patterns\alz\scripts\Start-AMBA-ALZ-Maintenance.ps1 -pseudoRootManagementGroup $pseudoRootManagementGroup -cleanItems Amba-Alz
```

  ![Clean up current deployment](../../../media/Clean-up-current-deployment.png)

## Update

Complete the activities documented in the [Steps to update to the latest release](../#steps-to-update-to-the-latest-release) page.
