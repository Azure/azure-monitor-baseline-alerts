---
title: Disable Policies
geekdocCollapseSection: true
weight: 55
---

### In this page

> [AlertState Parameter](../Disabling-Policies#alertstate-parameter) </br>
> [PolicyEffect Parameter](../Disabling-Policies#policyeffect-parameter) </br>
> [MonitorDisable Parameter](../Disabling-Policies#monitordisable-parameter) </br>

The AMBA-ALZ pattern provides several methods to enable or disable policy effects.

1. **Parameter: AlertState** - Manages the state of alert rules, allowing deployment in a disabled state or disabling existing alert rules at scale through policy.
2. **Parameter: PolicyEffect** - Specifies the effect of a Policy Definition, enabling deployment in a disabled state.
3. **Tag: MonitorDisable** - Determines if a resource should be monitored, allowing exclusion of specific resources from monitoring.

## AlertState Parameter

When testing alerts in a development or test environment is not feasible, the AlertState parameter is used for all metric alerts. This parameter, named by combining {resourceType}, {metricName}, and AlertState (e.g., VnetGwTunnelIngressAlertState), allows controlled disabling of alerts deployed via policies. This is useful during alert storms or rollback processes.

### Allowed Values

- "true" - Alert rule will be enabled. (Default)
- "false" - Alert rule will be disabled.

### How It Works

The **AlertState** parameter is used for compliance evaluation and configuring the alert rule state. The value assigned to **AlertState** is transferred to the **enabled** parameter within the policy's existenceCondition.

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

If "allOf" evaluates to true, the policy effect is satisfied, and deployment does not proceed. To disable an alert rule, set AlertState to "false", causing "allOf" to evaluate as false and updating the "enabled" property to false.

### Deployment Steps

1. Set AlertState to "false" for relevant policies via command line or parameter file.
2. Deploy the policies and assignments.
3. Identify non-compliant policies based on alerts to be disabled. Remediate these policies through the portal or use the script at [patterns/alz/scripts/Start-AMBA-ALZ-Remediation](https://github.com/Azure/azure-monitor-baseline-alerts/blob/main/patterns/alz/scripts/Start-AMBA-ALZ-Remediation.ps1).

Note: This approach disables alerts but does not delete them. Delete alerts manually if needed. Ensure successful remediation before engaging PolicyEffect to avoid deploying new alerts.

## PolicyEffect Parameter

Alert rules are evaluated based on best practices, field experience, customer feedback, alert type, and potential impact. Disabling a policy can prevent unnecessary or duplicate alerts. For example, while deploying an alert rule for VPN Gateway Bandwidth Utilization, disabling alert rules for VPN Gateway Egress and Ingress prevents redundant notifications.

The default settings are designed to offer a balanced baseline, but adjustments may be necessary to better align with your specific requirements.

### Allowed Values

- "deployIfNotExists" - Deploys the alert rule if conditions are met. (Default)
- "disabled" - Creates the policy without deploying the alert rule.

### How It Works

The **PolicyEffect** parameter configures the Policy Definition effect. Named by combining {resourceType}, {metricName}, and PolicyEffect (e.g., ERCIRQoSDropBitsinPerSecPolicyEffect), the value is transferred to the **effect** parameter, determining the policy's effect.

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
    "effect": "[[parameters('effect')]"
  }
}
```

## MonitorDisable Parameter

Exclude specific resources from monitoring by using the **MonitorDisable** parameter. By default, a tag named **MonitorDisable** with the value **"true"** prevents alert rule deployment on those resources. Adjust to use existing tags and values, such as **Environment** with values **Production**, **Test**, or **Sandbox**.

```json
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
}
```

{{< hint type=Info >}}
***This deployment evaluates and remediates policy definitions only if specified tag values are not present and does not apply to policies for both Service Health and Resource Health alert.***
{{< /hint >}}

### How It Works

The policy rule proceeds if "allOf" evaluates to true, meaning deployment continues if the tag specified by MonitorDisableTagName does not exist or does not contain any values listed in MonitorDisableTagValues. If the tag contains a specified value, "allOf" evaluates to false, halting evaluation and remediation. Once tag and value has been added please ensure you you run remediation again to ensure tag and its value is respected.

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
  }
}
```

### Log based alerts

In AMBA-ALZ virtual machine alerts are scoped to the subscription level so if the disable tag is added at the subscription level it will disables all targeted policies to all VMS.

To disable the VM alerts for individual virtual machines or hybrid VMs, tag the relevant resources with the **MonitorDisable** tag. The alert queries reference resource properties in [Azure Resource Graph](https://learn.microsoft.com/en-us/azure/governance/resource-graph/overview). If a resource contains the specified tag name and value, it is included in an exclusion list, preventing alerts. This allows dynamic exclusion of resources from the VM alerts without deleting or disabling the whole alert.
