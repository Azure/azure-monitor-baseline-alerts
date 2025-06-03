---
title: Remediate Policies
weight: 90
---

By default, the policies are set to deploy-if-not-exists. This configuration affects any new deployments. In a greenfield scenario, where new resources and subscriptions are deployed, the policies will automatically create the necessary alert rules, action groups, and alert processing rules.

In a brownfield scenario, the policies will report non-compliance for existing resources within their scope. To remediate these non-compliant resources, you need to initiate remediation. This can be done through the Azure portal on a policy-by-policy basis or by running the *Start-AMBA-ALZ-Remediation.ps1* script located in the *.\patterns\alz\scripts* folder. This script will remediate all AMBA-ALZ policies in scope as defined by the management group prefix.

{{< hint type=Important >}}
This script requires PowerShell 7.0 or higher, and the following PowerShell modules:

- [Az.Accounts](https://www.powershellgallery.com/packages/Az.Accounts)
- [Az.Resources](https://www.powershellgallery.com/packages/Az.Resources)

{{< /hint >}}

To use the script, follow these steps:

1. Log in to Azure PowerShell with an account that has at least Resource Policy Contributor permissions at the pseudo-root management group level.
2. Navigate to the root directory of the cloned repository.
3. Set the necessary variables.
4. Execute the remediation script.

  {{% include "./PowerShell-ExecutionPolicy.md" %}}

For example, to remediate the **Alerting-Management** initiative assigned to the **alz-platform-management** Management Group, execute the following commands:

```powershell
# Modify the following variables to match your environment
$managementManagementGroup = "The management group id for Management"
```

```powershell
# Run the following commands to initiate remediation
.\patterns\alz\scripts\Start-AMBA-ALZ-Remediation.ps1 -managementGroupName $managementManagementGroup -policyName Alerting-Management
```

The script will output the results of the REST API calls, typically returning a status code 201. If the script encounters an error, review the error message and verify that the management group name and policy name are correct. Upon successful execution of the script, you should observe multiple remediation tasks initiated within the **alz-platform-management** management group.

For convenience, assuming that the management hierarchy is fully aligned with the Azure Landing Zones (ALZ) architecture, the following commands can be used to remediate all policies assigned as per the guidance provided in this repository:

```powershell
# Modify the following variables to match your environment
$pseudoRootManagementGroup = "The pseudo root management group ID parenting the identity, management and connectivity management groups"
$platformManagementGroup = "The management group ID for Platform"
$identityManagementGroup = "The management group ID for Identity"
$managementManagementGroup = "The management group ID for Management"
$connectivityManagementGroup = "The management group ID for Connectivity"
$LZManagementGroup="The management group ID for Landing Zones"
```

```powershell
# Run the following commands to initiate remediation
.\patterns\alz\scripts\Start-AMBA-ALZ-Remediation.ps1 -managementGroupName $pseudoRootManagementGroup -policyName Notification-Assets
.\patterns\alz\scripts\Start-AMBA-ALZ-Remediation.ps1 -managementGroupName $pseudoRootManagementGroup -policyName Alerting-ServiceHealth
.\patterns\alz\scripts\Start-AMBA-ALZ-Remediation.ps1 -managementGroupName $platformManagementGroup -policyName Alerting-HybridVM
.\patterns\alz\scripts\Start-AMBA-ALZ-Remediation.ps1 -managementGroupName $platformManagementGroup -policyName Alerting-VM
.\patterns\alz\scripts\Start-AMBA-ALZ-Remediation.ps1 -managementGroupName $connectivityManagementGroup -policyName Alerting-Connectivity
.\patterns\alz\scripts\Start-AMBA-ALZ-Remediation.ps1 -managementGroupName $connectivityManagementGroup -policyName Alerting-Connectivity-2
.\patterns\alz\scripts\Start-AMBA-ALZ-Remediation.ps1 -managementGroupName $identityManagementGroup -policyName Alerting-Identity
.\patterns\alz\scripts\Start-AMBA-ALZ-Remediation.ps1 -managementGroupName $managementManagementGroup -policyName Alerting-Management
.\patterns\alz\scripts\Start-AMBA-ALZ-Remediation.ps1 -managementGroupName $LZManagementGroup -policyName Alerting-KeyManagement
.\patterns\alz\scripts\Start-AMBA-ALZ-Remediation.ps1 -managementGroupName $LZManagementGroup -policyName Alerting-LoadBalancing
.\patterns\alz\scripts\Start-AMBA-ALZ-Remediation.ps1 -managementGroupName $LZManagementGroup -policyName Alerting-NetworkChanges
.\patterns\alz\scripts\Start-AMBA-ALZ-Remediation.ps1 -managementGroupName $LZManagementGroup -policyName Alerting-RecoveryServices
.\patterns\alz\scripts\Start-AMBA-ALZ-Remediation.ps1 -managementGroupName $LZManagementGroup -policyName Alerting-Storage
.\patterns\alz\scripts\Start-AMBA-ALZ-Remediation.ps1 -managementGroupName $LZManagementGroup -policyName Alerting-HybridVM
.\patterns\alz\scripts\Start-AMBA-ALZ-Remediation.ps1 -managementGroupName $LZManagementGroup -policyName Alerting-VM
.\patterns\alz\scripts\Start-AMBA-ALZ-Remediation.ps1 -managementGroupName $LZManagementGroup -policyName Alerting-Web
```

To remediate a single policy definition instead of the entire policy initiative, use the remediation script with the specific policy reference ID available on the [Policy Initiatives](../../../Getting-started/Policy-Initiatives) page. For example, to remediate the **Deploy AMBA Notification Assets** policy, execute the following command:

```powershell
# Run the following command to initiate remediation of a single policy definition
.\patterns\alz\scripts\Start-AMBA-ALZ-Remediation.ps1 -managementGroupName $pseudoRootManagementGroup -policyName ALZ_AlertProcessing_Rule
```
