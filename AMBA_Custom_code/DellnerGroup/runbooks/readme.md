# For remediation tasks to succeed after deploying AMBA there is a prereq of certain resource Providers

# Specifically: Microsoft.AlertsManagement

# To solve this we need to create
- 1 automation account runbook with managed identity enabled
- 1 custom Azure RBAC role to allow registration of resource provider
    - Assign Custom RBAC role to Automation account identity
- 1 assignment of built-in role "Tag Contributor" to AA managed identity
    - Assign built-in RBAC role to Automation account identity
- 1x runbook in the automation account, runbook registers resource provider and sets tag once updated
  - Runbook only looks for subscriptions that are missing the 'AMBAenabled' = 'yes' tag
- 1x schedule for runbook (either daily/bi-daily/weekdays/weekly) or similar
- 1x Azure Policy in Audit mode that evaluates if resource provider exists on sub by looking for 'AMBAenabled' = 'yes' tag on each subscription under Intermediate Root MG
* For all of the above the "configuring_prereqs.ps1" can be used