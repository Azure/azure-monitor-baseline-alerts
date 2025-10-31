---
title: Secure log search alert queries with Customer-managed key
geekdocCollapseSection: true
geekdocHidden: false
weight: 79
---

### In this page

> [Overview](../Customer_managed_key_for_log_search_alerts#overview) </br>
> [How this feature works](../Customer_managed_key_for_log_search_alerts#how-this-feature-works) </br>

## Overview

The query language used in Log Analytics is expressive and can contain sensitive information in comments, or in the query syntax. Despite all data and saved queries are encrypted at rest using Microsoft-managed keys (MMK), some organizations might require that such information is kept protected under Customer-managed key policy. For this reason, you need to save your queries encrypted with your key. Azure Monitor enables you to store saved queries and log search alerts encrypted with your key in your own Storage Account when linked to your workspace. Check guidance and considerations in the following article: [Azure Monitor customer-managed keys](https://learn.microsoft.com/en-us/azure/azure-monitor/logs/customer-managed-keys?tabs=portal).

![Alert Rule](../../media/cmk_alertrule.png)

## How this feature works

{{< hint type=Info >}}
**This feature is only available when deploying through the following methods: GitHub Actions, Azure Pipelines, Azure CLI or Azure PowerShell since the AMBA-ALZ portal experience does not require configuration of parameter file. Moreover, it is only applicable to log-search alerts.**
{{< /hint >}}

The **Require a workspace linked storage** option in the query alert rule controls whether this scheduled query rule should be stored in the customer's storage. To control this option in the AMBA-ALZ pattern, we use the ***checkWorkspaceAlertsStorageConfigured*** parameter with a **default value of 'false'**. More information in the following article: [Scheduled Query Rules](https://learn.microsoft.com/en-us/azure/templates/microsoft.insights/scheduledqueryrules?pivots=deployment-language-bicep)

To change the **checkWorkspaceAlertsStorageConfigured** flag to **'true'**, navigate to:

- [alzArm.param.json](https://github.com/azure/azure-monitor-baseline-alerts/blob/2025-04-04/patterns/alz/alzArm.param.json) for the latest release.
- [alzArm.param.json](https://github.com/azure/azure-monitor-baseline-alerts/blob/main/patterns/alz/alzArm.param.json) for the main branch.
- change parameters value where name contains *checkWorkspaceAlertsStorageConfigured* to *true*
  ![Parameter file](../../media/cmk_parameter.png)

{{< hint type=IMPORTANT >}}
An alert rule won't be created if the Log Analytics workspace doesn't have a configured linked storage account.
{{< /hint >}}

Enabling this feature without a linked storage account, will cause the remediation task to fail

  ![remediation task error](../../media/cmk_remediation_task_error.png)

with an error message similar to the following one:

  ![remediation task error message](../../media/cmk_remediation_task_error_message.png)

As consequence, <ins>***no alert rule for the given policy will be created***</ins> and the corresponding policy definition will show as ***Non-compliant***. See the image below

  ![Policy compliance](../../media/cmk_alert_rule_error.png)
