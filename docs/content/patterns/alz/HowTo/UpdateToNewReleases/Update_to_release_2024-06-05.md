---
title: Updating to release 2024-06-05
geekdocCollapseSection: true
weight: 98
---

### In this page

> [Pre update actions](#pre-update-actions) </br>
> [Update](#update)

{{< hint type=Important >}}
***The parameter file structure has changed to accommodate a new feature coming soon.***
{{< /hint >}}

## Pre update actions

The parameter file structure has been updated to support an upcoming feature. Therefore, when updating from release [2024-06-05](../../../Overview/Whats-New#2024-06-05), you must align your existing parameter file structure with the new format introduced in this release.
In particular, the new parameter file includes the following changes:

1. Introduces new parameters for utilizing an existing User Assigned Managed Identity (UAMI) or creating a new one during the AMBA-ALZ deployment. These parameters are essential for the new hybrid virtual machine alert set. Ensure to review and configure the following parameters accurately:

   1. ***bringYourOwnUserAssignedManagedIdentity***: Set this parameter to **Yes** if you want to use an existing User Assigned Managed Identity (UAMI). Set it to **No** if you prefer the AMBA-ALZ deployment to create a new UAMI for you.

   2. ***bringYourOwnUserAssignedManagedIdentityResourceId***: If you set the **bringYourOwnUserAssignedManagedIdentity** parameter to **Yes**, provide the resource ID of your existing UAMI.

      1.1. Enter the UAMI resource ID, leaving the **managementSubscriptionId** blank

        ![UAMI resource ID](../../../media/alz-BYO-UAMI.png)

      1.2. Configure it with the ***Monitoring Reader*** role on the pseudo root Management Group.

   3. ***userAssignedManagedIdentityName***: If the **bringYourOwnUserAssignedManagedIdentity** parameter is set to **No**, you can either use the default value or specify a custom name for the UAMI that will be created during the deployment. The default name follows the ALZ standard naming convention.

      ![UAMI default name](../../../media/alz-UAMI-Default-Name.png)

   4. ***managementSubscriptionId***: If the **bringYourOwnUserAssignedManagedIdentity** parameter is set to **No**, provide the subscription ID of the subscription within the Management management group. The deployment process will create the UAMI in this subscription and assign it the ***Monitoring Reader*** role on the pseudo root Management Group.

      ![Management subscription ID](../../../media/alz-ManagementSubscription.png)

      ![Management subscription ID parameter](../../../media/alz-UAMI-Management-SubscriptionID.png)

2. Converts the previous parameter objects, including ***policyAssignmentParametersCommon***, ***policyAssignmentParametersBYON***, and ***policyAssignmentParametersNotificationAssets***, into standard parameters while retaining their original names. Consequently, the corresponding sections of the parameter file will now appear as shown in the following image:

    ![New parameter file sample](../../../media/alz-New-ParamterFile-Structure.png)

## Update

Complete the activities documented in the [Steps to update to the latest release](../#steps-to-update-to-the-latest-release) page.
