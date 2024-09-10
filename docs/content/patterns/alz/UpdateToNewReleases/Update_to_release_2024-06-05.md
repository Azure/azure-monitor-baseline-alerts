---
title: Updating to release 2024-06-05
geekdocCollapseSection: true
weight: 98
---
{{< hint type=Important >}}
***The parameter file structure has changed to accommodate a new feature coming soon.***
{{< /hint >}}

# Pre update actions

The parameter file structure has changed to accommodate a new feature coming soon. For this reason, updating from release [2024-06-05](../../Whats-New#2024-06-05) requires the alignment of the parameter file structure you have been using so far with the new one coming with the release.

In particular the new parameter file has the following differences:

1. Contains new parameters for using an existing User Assigned Managed Identity or creating a new one during the AMBA-ALZ deployment. It's required by the new hybrid virtual machine alert set. Make sure to review and set the following parameters correctly:

   1. ***bringYourOwnUserAssignedManagedIdentity***: set it to **Yes** if you would like to use your own User Assigned Managed Identity (UAMI) or to **No** if you don't have one and would like the deployment of AMBA-ALZ to create one.

   2. ***bringYourOwnUserAssignedManagedIdentityResourceId***: If you set the **bringYourOwnUserAssignedManagedIdentity** parameter to **Yes**:

      1.1. Enter the UAMI resource ID, leaving the **managementSubscriptionId** blank

        ![UAMI resource ID](../../media/alz-BYO-UAMI.png)

      1.2. Configure it with the ***Monitoring Reader*** role on the pseudo root Management Group.

   3. ***userAssignedManagedIdentityName***: If you set the **bringYourOwnUserAssignedManagedIdentity** parameter to **No**, leave the default value or set a different one to specify a different name for the UAMI created during the deployment. The provided default name aligns with the ALZ standard naming convention.

      ![UAMI default name](../../media/alz-UAMI-Default-Name.png)

   4. ***managementSubscriptionId***: If you set the **bringYourOwnUserAssignedManagedIdentity** parameter to **No**, enter the subscription ID of the subscription under the Management management group. The deployment procedure will create the UAMI in this subscription and assign it the ***Monitoring Reader*** role on the pseudo root Management Group

      ![Management subscription ID](../../media/alz-ManagementSubscription.png)

      ![](../../media/alz-UAMI-Management-SubscriptionID.png)

2. Changes the previous parameter objects, such as ***policyAssignmentParametersCommon***, ***policyAssignmentParametersBYON*** and ***policyAssignmentParametersNotificationAssets*** into classic parameters using the same name as before. As result, the previous sections of the parameter you'll now look like the following image:

    ![New parameter file sample](../../media/alz-New-ParamterFile-Structure.png)
