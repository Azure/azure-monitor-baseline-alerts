---
title: Disable policies
geekdocCollapseSection: true
weight: 60
---

The Azure Monitor Baseline Alerts (AMBA) policies offer various methods to enable or disable the effects of the policies.

1. **Parameter: AlertState** - Configures the state of the alert rule, enabling deployment of alert rules in a disabled state or disabling existing alert rules at scale through policy.
2. **Parameter: PolicyEffect** - Defines the effect of a Policy Definition, allowing the policy to be deployed in a disabled state.
3. **Tag: MonitorDisable** - Specifies whether a resource should be evaluated, enabling exclusion of selected resources from monitoring.

## AlertState parameter

In scenarios where it is not feasible to test alerts in a development or test environment, the AlertState parameter has been introduced for all metric alerts. This parameter, named by combining {resourceType}, {metricName}, and AlertState (e.g., VnetGwTunnelIngressAlertState), allows for the controlled disabling of one or more alerts deployed via policies. This feature is particularly useful in situations where an alert storm occurs and a rollback process is necessary as part of a change request.

### Allowed values

- "true" - Alert rule will be enabled. (Default)
- "false" - Alert rule will be disabled.

### How it works

The **AlertState** parameter serves dual purposes: compliance evaluation and configuring the state of the alert rule. The value assigned to the **AlertState** parameter is transferred to the **enabled** parameter, which is a component of the policy's existenceCondition.

```json
"existenceCondition": {
  "allOf": [
    {
      "field": "Microsoft.Insights/metricAlerts/criteria.Microsoft-Azure-Monitor-SingleResourceMultipleMetricCriteria.allOf[*].metricNamespace",
      "equals": "Microsoft.Automation/automationAccounts"
    },
    {
      "field": "Microsoft.Insights/metricAlerts/criteria.Microsoft-Azure-Monitor-SingleResourceMultipleMetricCriteria.allOf[*].metricName",
      "equals": "TotalJob"
    },
    {
      "field": "Microsoft.Insights/metricalerts/scopes[*]",
      "equals": "[[concat(subscription().id, '/resourceGroups/', resourceGroup().name, '/providers/Microsoft.Automation/automationAccounts/', field('fullName'))]"
    },
    {
      "field": "Microsoft.Insights/metricAlerts/enabled",
      "equals": "[[parameters('enabled')]"
    }
  ]
}
```

If "allOf" evaluates to true, the policy effect is satisfied, and the deployment does not proceed. To disable an existing alert rule, set the AlertState parameter to "false". This change causes "allOf" to evaluate as false, triggering the deployment that updates the "enabled" property of the alert rule to false.

### Deployment steps

These are the high-level steps to disable policies:

1. Set the AlertState parameter to "false" for the relevant policies, either via command line or parameter file.
2. Deploy the policies and assignments as previously described.
3. After deployment and policy evaluation, identify non-compliant policies based on the alerts to be disabled. Remediate these policies through the portal on a policy-by-policy basis or use the script available at [patterns/alz/scripts/Start-AMBARemediation](https://github.com/Azure/azure-monitor-baseline-alerts/blob/main/patterns/alz/scripts/Start-AMBARemediation.ps1) to remediate all ALZ-Monitor policies in scope as defined by the management group prefix.

Note: This approach will disable the alerts but not delete them. To delete alerts, you must do so manually. Ensure successful remediation before engaging the PolicyEffect to avoid deploying new alerts, as disabling the policy will prevent turning off alerts via policy until it is re-enabled.

## PolicyEffect parameter

In practice, alert rules are evaluated based on best practices, field experience, customer feedback, alert type, and potential impact. There are scenarios where disabling a policy is beneficial to avoid unnecessary or duplicate alerts. For instance, while we deploy an alert rule for VPN Gateway Bandwidth Utilization, we have disabled the alert rules for VPN Gateway Egress and Ingress to prevent redundant notifications.
The default settings are designed to offer a balanced baseline, but adjustments may be necessary to better align with your specific requirements.

### Allowed values

- "deployIfNotExists" - The policy will deploy the alert rule if the specified conditions are met. This is the default setting for most policies.
- "disabled" - The policy will be created, but it will not deploy the corresponding alert rule.

### How it works

The **PolicyEffect** parameter configures the effect of the Policy Definition. In the initiatives and example parameter files, this parameter is named by combining {resourceType}, {metricName}, and PolicyEffect (e.g., ERCIRQoSDropBitsinPerSecPolicyEffect). The value assigned to the **PolicyEffect** parameter is transferred to the **effect** parameter, which determines the policy's effect.

```json
"policyRule": {
  "if": {
    "allOf": [
      {
        "field": "type",
        "equals": "Microsoft.Automation/automationAccounts"
      },
      {
        "field": "[[concat('tags[', parameters('MonitorDisable'), ']')]",
        "notEquals": "true"
      }
    ]
  },
  "then": {
    "effect": "[[parameters('effect')]",
```

## MonitorDisable parameter

It is also possible to exclude specific resources from monitoring. For instance, you might not want to monitor pre-production or development environments. The **MonitorDisable** parameter includes the tag name and tag value to determine whether a resource should be monitored. By default, creating a tag named **MonitorDisable** with the value **"true"** will prevent the deployment of alert rules on those resources. This can be easily adjusted to use existing tags and tag values. For example, you could configure the parameters with the tag name **Environment** and tag values such as **Production**, **Test**, or **Sandbox** to exclude resources in these environments (refer to the sample parameter section).

```json
.
.
"ALZMonitorDisableTagName": {
  "value": "MonitorDisable"
},
"ALZMonitorDisableTagValues": {
  "value": [
    "true",
    "Test",
    "Dev",
    "Sandbox"
  ]
},
.
.
```
This deployment will implement policy definitions that will only be evaluated and remediated if the specified tag values are not present in the provided list.

### How it works

The policy rule proceeds only if "allOf" evaluates to true. This means the deployment will continue as long as the tag specified by the MonitorDisableTagName parameter does not exist or does not contain any of the values listed in the MonitorDisableTagValues parameter. If the tag contains one of the specified values, the "allOf" condition will evaluate to false because the _"notIn": "[parameters('MonitorDisableTagValues')]"_ condition is not met, thereby halting the evaluation and remediation process.

```json
    "policyRule": {
      "if": {
        "allOf": [
          {
            "field": "type",
            "equals": "Microsoft.Automation/automationAccounts"
          },
          {
            "field": "[[concat('tags[', parameters('MonitorDisableTagName'), ']')]",
            "notIn": "[[parameters('MonitorDisableTagValues')]"
          }
        ]
      },
```

Given the varying resource scopes to which this method can be applied, the approach for log-based alerts differs slightly. For example, virtual machine alerts are scoped to the subscription level, and tagging the subscription would disable all targeted policies.

With the introduction of the _**Bring Your Own User Assigned Managed Identity (BYO UAMI)**_ feature in the [2024-06-05](../../Overview/Whats-New#2024-06-05) release, and the capability to query Azure Resource Graph using Azure Monitor (refer to [Quickstart: Create alerts with Azure Resource Graph and Log Analytics](https://learn.microsoft.com/en-us/azure/governance/resource-graph/alerts-query-quickstart?tabs=azure-resource-graph)), it is now feasible to disable individual alerts for both Azure and hybrid virtual machines post-creation. This enhancement addresses requests to stop alerting for virtual machines that are offline for maintenance, providing a timely solution.

To disable alerts for your virtual machines after they are created, ensure that you tag the relevant resources appropriately. The alert queries have been updated to reference resource properties in [Azure Resource Graph](https://learn.microsoft.com/en-us/azure/governance/resource-graph/overview). If a resource contains the specified tag name and tag value, it will be included in an exclusion list, preventing alerts from being generated for those resources. This approach allows for dynamic and rapid exclusion of necessary resources from alerts without needing to delete the alert. Simply tag the resource and run the remediation process again.

[Back to top of page](.)
