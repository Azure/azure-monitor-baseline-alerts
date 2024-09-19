---
title: Remediate Policies
weight: 80
---

The policies are all deploy-if-not-exists, by default, meaning that any new deployments will be influenced by them. Therefore, if you are deploying in a green field scenario and will afterwards be deploying any of the covered resource types, including subscriptions, then the policies will take effect and the relevant alert rules, action groups and alert processing rules will be created.
If you are in a brownfield scenario on the other hand, policies will be reporting non-compliance for resources in scope, but to remediate non-compliant resources you will need to initiate remediation. This can be done either through the portal, on a policy-by-policy basis or you can run the *Start-AMBARemediation.ps1* script located in the *.\patterns\alz\scripts* folder to remediate all AMBA policies in scope as defined by management group pre-fix.

{{< hint type=Important >}}
This script requires PowerShell 7.0 or higher and the following PowerShell modules:

- [Az.Accounts](https://www.powershellgallery.com/packages/Az.Accounts)
- [Az.Resources](https://www.powershellgallery.com/packages/Az.Resources)

{{< /hint >}}

To use the script, do the following:

- Log on to Azure PowerShell with an account with at least Resource Policy Contributor permissions at the pseudo-root management group level
- Navigate to the root of the cloned repo
- Set the variables
- Run the remediation script

  {{% include "PowerShell-ExecutionPolicy.md" %}}

- For example, to remediate **Alerting-Management** initiative, assigned to the **alz-platform-management** Management Group run the following commands:

  ```powershell
  #Modify the following variables to match your environment
  $managementManagementGroup = "The management group id for Management"
  ```

  ```powershell
  #Run the following commands to initiate remediation
  .\patterns\alz\scripts\Start-AMBARemediation.ps1 -managementGroupName $managementManagementGroup -policyName Alerting-Management
  ```

- The script will return the output from the REST API calls, which should be a status code 201. If the script fails, check the error message and ensure that the management group name and policy name are correct.
- After running the script, you should be able to see a number of remediation tasks initiated at the alz-platform-management.

For convenience, assuming that the management hierarchy is fully aligned to ALZ, below are the commands required to remediate all policies assigned through the guidance provided in this repo:

```powershell
#Modify the following variables to match your environment
$pseudoRootManagementGroup = "The pseudo root management group id parenting the Platform and Landing Zones management groups"
$identityManagementGroup = "The management group id for Identity"
$managementManagementGroup = "The management group id for Management"
$connectivityManagementGroup = "The management group id for Connectivity"
$LZManagementGroup="The management group id for Landing Zones"
```

```powershell
#Run the following commands to initiate remediation
.\patterns\alz\scripts\Start-AMBARemediation.ps1 -managementGroupName $pseudoRootManagementGroup -policyName Notification-Assets
.\patterns\alz\scripts\Start-AMBARemediation.ps1 -managementGroupName $pseudoRootManagementGroup -policyName Alerting-ServiceHealth
.\patterns\alz\scripts\Start-AMBARemediation.ps1 -managementGroupName $connectivityManagementGroup -policyName Alerting-Connectivity
.\patterns\alz\scripts\Start-AMBARemediation.ps1 -managementGroupName $identityManagementGroup -policyName Alerting-Identity
.\patterns\alz\scripts\Start-AMBARemediation.ps1 -managementGroupName $managementManagementGroup -policyName Alerting-Management
.\patterns\alz\scripts\Start-AMBARemediation.ps1 -managementGroupName $LZManagementGroup -policyName Alerting-KeyManagement
.\patterns\alz\scripts\Start-AMBARemediation.ps1 -managementGroupName $LZManagementGroup -policyName Alerting-LoadBalancing
.\patterns\alz\scripts\Start-AMBARemediation.ps1 -managementGroupName $LZManagementGroup -policyName Alerting-NetworkChanges
.\patterns\alz\scripts\Start-AMBARemediation.ps1 -managementGroupName $LZManagementGroup -policyName Alerting-RecoveryServices
.\patterns\alz\scripts\Start-AMBARemediation.ps1 -managementGroupName $LZManagementGroup -policyName Alerting-HybridVM
.\patterns\alz\scripts\Start-AMBARemediation.ps1 -managementGroupName $LZManagementGroup -policyName Alerting-Storage
.\patterns\alz\scripts\Start-AMBARemediation.ps1 -managementGroupName $LZManagementGroup -policyName Alerting-VM
.\patterns\alz\scripts\Start-AMBARemediation.ps1 -managementGroupName $LZManagementGroup -policyName Alerting-Web
```

Should you need to remediate just one policy definition and not the entire policy initiative, you can run the remediation script targeted at the policy reference id that can be found under [Policy Initiatives](../../Policy-Initiatives). For example, to remediate the ***Deploy AMBA Notification Assets*** policy, run the command below:

```powershell
#Run the following command to initiate remediation of a single policy definition
.\patterns\alz\scripts\Start-AMBARemediation.ps1 -managementGroupName $pseudoRootManagementGroup -policyName ALZ_AlertProcessing_Rule
```
