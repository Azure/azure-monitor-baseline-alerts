---
title: Temporarily disabling notifications
geekdocCollapseSection: true
weight: 65
---

Azure Monitor alerts targeted to a large scope allow for at scale coverage, but reduce the flexibility to disable them for specific resources. There might be several reason to stop the notification of alerts. For instance, customers could have resources that are stopped or disabled due to maintenance or just want to stop the notification during the night shift. To allow this kind of flexibility, as part of the Notification Assets policy initiative, AMBA provides you with an asset to stop the notification for specific resources.

This asset is made of an alert processing rule (also known as APR) with the following characteristics:

- deployed as disabled
- scoped at the subscription level
- suppression rule type
- scheduled to run always

This APR needs to be configured with the resource ID of the resource(s) for which you want to stop notifications and then enabled every time you need it.

Once the resource is out of the maintenance period or when you don't need the suppression rule anymore, ***remember*** to remove the resources and disable the rule.

To know more about how to suppress notifications, see [Suppress notifications during planned maintenance](https://learn.microsoft.com/en-us/azure/azure-monitor/alerts/alerts-processing-rules?tabs=portal#suppress-notifications-during-planned-maintenance)

To configure the APR, do the following:

1. In **Monitor --> Alerts**, click on **Alert processing rules**

  ![Monitor/Alerts/Alert processing rule](../media/AlertProcessingRules.png)

2. Click on the ARP named ***apr-AMBA-<mark>subscription display name</mark>-002*** with rule type **Suppression**

  ![Suppression aler processing rule](../media/SuppressionAlertProcessingRule.png)

3. Click on ***Edit***

  ![Edit alert processing rule](../media/Edit-AlertProcessingRule.png)

4. In the **Scope** tab, under the filter section, configure the following:

   - Filters: ***Resource***
   - Operator: ***Equals***
   - Value: **Enter the <mark>resource Id</mark> of resources separated by comma <mark>with no spaces before, after or between the strings.</mark>**

    ![Configure filter](../media/Filter-AlertProcessingRule.png)

  {{< hint type=Important >}}
  Each filter can include up to **five** values. Should you need more than **5** resources, add more lines of filter.
  {{< /hint >}}

5. Click on ***Review + save*** and then ***Save***

{{< hint type=Note >}}
  It is possible to apply other types of filter. For a complete list of allowed scopes and filters, refer to the official [Scope and filters for alert processing rules](https://learn.microsoft.com/en-us/azure/azure-monitor/alerts/alerts-processing-rules?tabs=portal#scope-and-filters-for-alert-processing-rules) documentation.
  {{< /hint >}}
