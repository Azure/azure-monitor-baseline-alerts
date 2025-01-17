---
title: Monitoring and Alerting
geekdocCollapseSection: true
weight: 20
---

### In this page

> [AMBA-ALZ Monitor Alert Approach](../Monitoring-and-Alerting#amba-alz-monitor-alert-approach) </br>
> [AMBA-ALZ Pattern Monitor Alert Policy Definitions](../Monitoring-and-Alerting#amba-alz-pattern-monitor-alert-policy-definitions) </br>
> [AMBA-ALZ Monitor Alert Processing Rules](../Monitoring-and-Alerting#amba-alz-monitor-alert-processing-rules) </br>
> [Monitoring Backup (Recovery Services Vaults)](../Monitoring-and-Alerting#monitoring-backup-recovery-services-vaults) </br>

## AMBA-ALZ Monitor Alert Approach

The strategy for enabling alerts in the AMBA-ALZ pattern involves using Azure Policy to deploy alerts as resources are created, configuring action groups, and using Alert Processing Rules to activate alerts and link them to the action group.

There are two main approaches to enabling alerting in the AMBA-ALZ pattern:

### Centralized

In a **centralized** alerting approach, a single Action Group is used for all alerts, resulting in a unified alerting email (distribution group) address or other configured actions.

Metric alerts are deployed with resources in the same resource group, while platform alerts like Service Health and Activity are created in a dedicated resource group within a subscription, typically located in the Management platform management group. A single Alert Action Group in this subscription is configured with a central alerting email address and Alert Processing Rules to enable filters and connect alerts to the Alert Action Group.

For example, in the AMBA-ALZ pattern, a single centralized action group is deployed in the "rg-amba-monitoring-001" resource group within a subscription in the Management platform management group.

### Decentralized

In a **decentralized** approach, each subscription has a dedicated Action Group, providing more granular control over how alert notifications are directed. For instance, connectivity/networking alerts for the platform connectivity subscription can be directed to the network operations team.

Metric alerts are deployed with resources in the same resource group, while platform alerts such as Service Health and Activity are created in a dedicated resource group for each subscription. Alert Action Groups are established in each landing zone subscription, allowing different operational areas and landing zone subscriptions to have distinct alerting email addresses (e.g., networking, identity, operations, workloads) or other supported actions. Alert Processing Rules are created to enable filters and connect alerts to the Action Groups.

For example, in the AMBA-ALZ pattern, a graphic representation of the flow is provided below.

![ALZ alerting](../../media/AMBA-focused-rg-alz-monitor-alert-flow.png)

### AMBA-ALZ Approach

In the AMBA-ALZ pattern, a decentralized approach is adopted to provide maximum flexibility in directing alerts. For more information, review [What are Azure Monitor Alerts?](https://learn.microsoft.com/en-us/azure/azure-monitor/alerts/alerts-overview).

- Each subscription will have a single Action Group, allowing customers to configure specific actions per subscription, such as different email addresses or other supported actions.
- Alert Processing Rules will target the Action Group in the subscription where the alert originated.

Initially, AMBA-ALZ will set up all Action Groups with the same email distribution group/address through Azure Policy. Future updates may include alternative or additional actions, such as configuring different email distribution groups based on the subscription, service, or workload owners.

AMBA-ALZ Alerts, Action Groups, and Alert Processing Rules are deployed using Azure Policy defined in the platform native Azure Policy JSON format.

## AMBA-ALZ Pattern Monitor Alert Policy Definitions

The following policy definition categories will be enabled as part of AMBA-ALZ deployments for the hubs and landing zones defined by Azure landing zone:

- Resource Metrics; See [here](../Alerts-Details#azure-landing-zone-metric-alerts-settings) for details on which resource metrics are included.
- Service and Resource Health; See [here](../Alerts-Details#azure-landing-zone-activity-log-resource-health) for details on which alerts are included.
- Activity Logs; See [here](../Alerts-Details#azure-landing-zone-activity-log-administrative) for details on which alerts are included.
- VM Insights Log Alerts; See [here](../Alerts-Details#vm-insights-log-alerts) for details on which alerts are included.
- Recovery Vault Alerts; See [here](../Alerts-Details#recovery-vault-alerts) for details on which alerts are included.

### Resource Metrics

Resource Metric alerts are deployed within the same resource group as the associated Azure resource. For instance, a resource metric alert for Express Route will be created in the resource group that contains the Express Route Gateway. This approach is logical because these alert types are tied to the specific resource ID, making it sensible to link the alert to the resource within the same resource group.

### Log Alerts

Log alerts are scoped at the subscription level. For policies to remediate and deploy, the data queried by the alert must exist in the Log Analytics table. For virtual machine log alerts, the VM insights solution needs to be enabled on the targeted VMs. Only the performance collection of the VM insights solution is required for the current alerts to deploy. To enable VM Insights, you need to install the Azure Monitor Agent and optionally the Dependency agent on your supported machines. Various methods can be used to install the agents, such as the Azure portal, Azure Policy, Azure Resource Manager templates, PowerShell, or manual installation. For more details, please refer to the links below:

- [Enable VM Insights overview](https://learn.microsoft.com/en-us/azure/azure-monitor/vm/vminsights-enable-overview)
- [Enable VM insights by using Azure Policy](https://learn.microsoft.com/en-us/azure/azure-monitor/vm/vminsights-enable-policy)
- [Enable VM insights using Resource Manager templates](https://learn.microsoft.com/en-us/azure/azure-monitor/vm/vminsights-enable-resource-manager)

### Service and Resource Health

[Service health](https://learn.microsoft.com/en-us/azure/service-health/overview) provides a personalized view of the health of the Azure services and regions you're using. Resource health provides information about the health of your individual cloud resources such as a specific virtual machine instance.

Service and resource health events are recorded in the activity log, allowing us to create a subset of activity log alerts that notify on health events. These alerts are scoped to each subscription and include four separate alerts for each of the service health categories: Incident, Planned Maintenance, Security Advisories, and Health Advisories.

A resource health alert will be generated for any resource that enters an unavailable or degraded state, whether platform or user-initiated. We will disregard the unknown state to avoid erroneous alerting.

## AMBA-ALZ Monitor Alert Processing Rules

[Alert Processing Rules](https://learn.microsoft.com/en-us/azure/azure-monitor/alerts/alerts-processing-rules) enable the filtering of alerts and assign alerts to the appropriate action groups based on filter criteria.

For AMBA-ALZ, we will implement a single Action Group per subscription and deploy a single Alert Processing Rule without filters to manage alerts via the Action Group. This approach may be revised in the future.

We still need to investigate appropriate filters for Alert Processing Rules for optimal alert processing.

Available filters:

- Alert condition
- Alert context (payload)
- Alert rule ID
- Alert name
- Description
- Monitor service
- Resource
- Resource group
- Resource type
- Severity
- Signal type

For instance, we could apply a filter to include only Severity levels of Critical, Error, and Warning, while excluding Informational and Verbose.

## Monitoring Backup (Recovery Services Vaults)

Azure Backup now provides new and improved alerting capabilities via Azure Monitor. The following policy: [Backup Monitor Policy](https://github.com/Azure/azure-monitor-baseline-alerts/blob/main/services/RecoveryServices/vaults/Modify-RSV-BackupHealth-Alert.json) configures new and existing recovery services vaults through a modify effect, which disables the classic alerts and enables the new built-in ones.

### Modifications

```json
{
  "effect": "[[parameters('effect')]",
  "details": {
    "roleDefinitionIds": [
      "/providers/Microsoft.Authorization/roleDefinitions/b24988ac-6180-42a0-ab88-20f7382dd24c"
    ],
    "conflictEffect": "audit",
    "operations": [
      {
        "operation": "addOrReplace",
        "field": "Microsoft.RecoveryServices/vaults/monitoringSettings.classicAlertSettings.alertsForCriticalOperations",
        "value": "Disabled"
      },
      {
        "operation": "addOrReplace",
        "field": "Microsoft.RecoveryServices/vaults/monitoringSettings.azureMonitorAlertSettings.alertsForAllJobFailures",
        "value": "Enabled"
      }
    ]
  }
}
```

### Notifications

While alerts are generated by default and cannot be disabled for destructive operations, users have control over the notifications. This allows you to specify the email addresses (or other notification endpoints) to which alerts should be routed. Notifications are configured by an alert processing rule, which is created by default when deploying the AMBA-ALZ pattern.
