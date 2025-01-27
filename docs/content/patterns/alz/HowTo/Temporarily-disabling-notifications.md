---
title: Temporarily disabling notifications
geekdocCollapseSection: true
weight: 60
---

Azure Monitor alerts configured for a broad scope provide extensive coverage but limit the ability to disable them for specific resources. There are various reasons to halt alert notifications, such as resources being stopped or disabled for maintenance, or the desire to suppress notifications during night shifts. To offer this level of flexibility, the Notification Assets policy initiative includes an asset from AMBA-ALZ that allows you to stop notifications for specific resources.

This asset consists of an alert processing rule (APR) with the following characteristics:

- Initially deployed in a disabled state
- Applied at the subscription level
- Configured as a suppression rule
- Set to run continuously

To utilize this APR, configure it with the resource ID(s) of the resources for which you want to suppress notifications. Enable the rule whenever suppression is required.

When the maintenance period concludes or the suppression rule is no longer needed, ensure to remove the specified resources and disable the rule.

For detailed information on how to suppress notifications, refer to the [Suppress notifications during planned maintenance](https://learn.microsoft.com/en-us/azure/azure-monitor/alerts/alerts-processing-rules?tabs=portal#suppress-notifications-during-planned-maintenance) documentation.

To configure the APR, follow these steps:

1. In **Monitor --> Alerts**, click on **Alert processing rules**

  ![Monitor/Alerts/Alert processing rule](../../media/AlertProcessingRules.png)

2. Click on the ARP named ***apr-AMBA-<mark>subscription display name</mark>-002*** with rule type **Suppression**

  ![Suppression alert processing rule](../../media/SuppressionAlertProcessingRule.png)

3. Click on ***Edit***

  ![Edit alert processing rule](../../media/Edit-AlertProcessingRule.png)

4. In the **Scope** tab, under the filter section, configure the following:

   - Filters: ***Resource***
   - Operator: ***Equals***
   - Value: **Enter the <mark>resource Id</mark> of resources separated by comma <mark>with no spaces before, after or between the strings.</mark>**

    ![Configure filter](../../media/Filter-AlertProcessingRule.png)

    {{< hint type=Important >}}
  Each filter can include up to ***5*** values. If you need to specify more than **5** resources, you will need to create a new Alert Processing Rule to suppress notifications, as each filter type can only be used once within the same Alert Processing Rule.
    {{< /hint >}}

5. Click on ***Review + save*** and then ***Save***

  {{< hint type=Note >}}
  It is possible to apply other types of filter. For example, you could add the *Alert Rule name* as a filter to only suppress the *ResourceHealthUnhealthyAlert* for specific resources during maintenance instead of all resource-related alerts.

  For a complete list of allowed scopes and filters, refer to the official [Scope and filters for alert processing rules](https://learn.microsoft.com/en-us/azure/azure-monitor/alerts/alerts-processing-rules?tabs=portal#scope-and-filters-for-alert-processing-rules) documentation.
  {{< /hint >}}
