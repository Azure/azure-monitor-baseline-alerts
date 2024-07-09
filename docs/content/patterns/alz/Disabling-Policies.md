---
title: Disabling Policies
geekdocCollapseSection: true
weight: 60
---

The policies in AMBA provide multiple methods to enable or disable the effects of the policy.

1. **Parameter: AlertState** - Determines the state of the alert rule. This either deploys an alert rule in a disabled state, or disables an already deployed alert rule at scale trough policy.
2. **Parameter: PolicyEffect** - Determines the effect of a Policy Definition, allowing a Policy to be deployed in a disabled state.
3. **Tag: MonitorDisable** - A tag that determines whether the resource should be evaluated. Allows you to exclude selected resources from monitoring.

## AlertState parameter

Recognizing that it is not always possible to test alerts in a dev/test environment, we have introduced the AlertState parameter for all metric alerts (in the initiatives and the example parameter file the parameter is named combining {resourceType}, {metricName} and AlertState, for example VnetGwTunnelIngressAlertState). This is to address a scenario where an alert storm occurs and it is necessary to disable one or more alerts deployed via policies through a controlled process. This could be considered for a roll-back process as part of a change request.

### Allowed values

- "true" - Alert rule will be enabled. (Default)
- "false" - Alert rule will be disabled.

### How it works

The AlertState parameter is used for both compliance evaluation and configuration of the state of the alert rule. The value of the **AlertState** parameter is passed on to the **enabled** parameter which is part of the existenceCondition of the Policy.

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

If "allOf" evaluates to true, the effect is satisfied and doesn't trigger the deployment. If you have implemented the alert rules before and want to disable an alert rule you can change the Alert State to "false", this will cause "allOf" to evaluate as false, which will trigger the deployment that changes the "enabled" property of the alert rule to false.

### Deployment steps

These are the high-level steps that would need to take place:

1. Change the value for the AlertState parameter for the offending policies to false, either via command line or parameter file as described previously.
1. Deploy the policies and assignments as described previously.
1. After deploying and policy evaluation there will be a number of non-compliant policies depending on which alerts were to be disabled. These will then need to be remediated which can be done either through the portal, on a policy-by-policy basis or you can run the script found in [patterns/alz/scripts/Start-AMBARemediation](https://github.com/Azure/azure-monitor-baseline-alerts/blob/main/patterns/alz/scripts/Start-AMBARemediation.ps1) to remediate all ALZ-Monitor policies in scope as defined by management group pre-fix.

Note that the above approach will not delete the alerts objects in Azure, merely disable them. To delete the alerts you will have to do so manually. Also note that while you can engage the PolicyEffect to avoid deploying new alerts, you should not do so until you have successfully remediated the above. Otherwise the policy will be disabled, and you will not be able to turn alerts off via policy until that is changed back.

## PolicyEffect parameter

In general, we evaluate the alert rules on best practices, field experience, customer feedback, type of alert and possible impact. There are situations where disabling the policy makes sense to prevent receiving unnecessary and/ or duplicate alerts/ notifications. For example we deploy an alert rule for VPN Gateway Bandwidth Utilization, in turn we have disabled the alert rules for VPN Gateway Egress and Ingress.
The default is intended to provide a well balanced baseline. However you may want to Enable or Disable the creation of certain Alert rules to meet your needs.

### Allowed values

- "deployIfNotExists" - Policy will deploy the alert rule if the conditions are met. (Default for most Policies)
- "disabled" - The policy itself will be created but will not create the corresponding Alert rule.

### How it works

The PolicyEffect parameter is used for the configuration of the effect of the PolicyDefinition (in the initiatives and the example parameter file the parameter is named combining {resourceType}, {metricName} and PolicyEffect, for example ERCIRQoSDropBitsinPerSecPolicyEffect) . The value of the **PolicyEffect** parameter is passed on to the **effect** parameter which configures the effect of the Policy.

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

It´s also possible to exclude certain resources from being monitored. You may not want to monitor pre-production or dev environments. The MonitorDisable parameter contains the tag name and tag value to determine whether a resource should be included. By default, creating the tag MonitorDisable with value "true" will prevent deployment of alert rules on those resources. This can be easily adjusted to use existing tags and tag values. For example you could configure the parameters with the tag name ***Environment*** and tag value of ***Production*** or ***Test*** or ***Sandbox*** or all of them to exclude resources in these environments (see the sample parameter screenshot).

![MonitorDisable* parameters](../media/MonitorDisableParams.png)

This will deploy policy definitions which will only be evaluated and remediated if the tag value(s) are not included in the list you provided.

### How it works

The policyRule only continues if "allOff" is true. Meaning, the deployment will continue as long as the MonitorDisableTagName tag doesn't exist or doesn't hold the any of the values listed in the MonitorDisableTagValues parameter. When the tag holds one of the configured values, the "allOff" will return "false" as *"notIn": "[[parameters('MonitorDisableTagValues')]"* is no longer satisfied, causing the evaluation and hence the remediation to stop.

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

Given the different resource scope that this method can be applied to, we made it working a little bit different when it comes to log-based alerts. For instance, the virtual machine alerts are scoped to subscription and tagging the subcription would result in disabling all the policies targeted at it.
For this reason, and thanks to the new **Bring Your Own User Assigned Managed Identity (BYO UAMI)*** included in the [2024-06-05](../../Whats-New#2024-06-05) release and to the ability to query Azure resource Graph using Azure Monitor (see [Quickstart: Create alerts with Azure Resource Graph and Log Analytics](https://learn.microsoft.com/en-us/azure/governance/resource-graph/alerts-query-quickstart?tabs=azure-resource-graph)), it is now possible to disable individual alerts for both Azure and hybrid virtual machines after they are created. We got requests to stop alerting fro virtual machines that were off for maintenance and this enhancement came up just in time.

Should you need to disable the alerts for your virtual machines after they are created, just make sure you tag the relevant resources accordingly. The alert queries have been modified to look at resource properties in [Azure Resource Graph](https://learn.microsoft.com/en-us/azure/governance/resource-graph/overview). If the resource contains the given tag name and tag value, it is made part of an exclusion list, so alerts will not be generated for them. This behavior allows you to dinamically and rapidly exclude the necessary resources from being alerted without the need of deleteing the alert, tag the resource and run the remediation again.
