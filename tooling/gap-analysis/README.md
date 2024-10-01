
# AMBA Gap Analysis Sandbox

This is a sandbox for the development and testing of the AMBA Gap Analysis solution.  The AMBA Gap Analysis solution provides visualizations and reports showing the gap between the alerts currently deployed to an Azure subscription(s) and those that are defined and recommended by [AMBA](https://azure.github.io/azure-monitor-baseline-alerts/welcome/).  The solution reuses all the great work done by the Resiliency team to create the existing WARA scripts found in the [APRL](https://azure.github.io/Azure-Proactive-Resiliency-Library-v2/welcome/).

## Requirements

- Windows OS
- Microsoft Excel installed
- [PowerShell 7](https://learn.microsoft.com/en-us/powershell/scripting/install/installing-powershell?view=powershell-7.4)
- [Git](https://git-scm.com/download/win)
- [Azure PowerShell modules](https://learn.microsoft.com/en-us/powershell/azure/install-azps-windows?view=azps-12.1.0&tabs=powershell&pivots=windows-psgallery) (Commands to install included in steps below)
  - Az.ResourceGraph
  - Az.Accounts
- Role Based Access Control: Reader role to access resources to be evaluated

## Run on Local Machine

- Open Powershell as administrator.  The script must be executed from **PowerShell 7**. Other versions are not supported, for example: Windows PowerShell and PowerShell ISE
- To check version open PowerShell $PSVersionTable  and if your version is not 7 please use the following link to update Powershell [version](https://learn.microsoft.com/en-us/powershell/scripting/install/installing-powershell-on-windows?view=powershell-7.4)

- Install required PowerShell modules

    `` Install-Module -Name Az.ResourceGraph -SkipPublisherCheck ``

    `` Install-Module -Name Az.Accounts -SkipPublisherCheck ``
  You may get this message so click Yes to All
  ![image](https://github.com/user-attachments/assets/2013a9c9-8ddc-4723-be5b-666658ad6ea1)


- Unblock the script to allow execution of scripts not signed locally

    `` Set-ExecutionPolicy -ExecutionPolicy Unrestricted -Scope CurrentUser ``

    `` Set-ExecutionPolicy -ExecutionPolicy Unrestricted -Scope LocalMachine ``

- Close and open a new PowerShell 7 session after completing prerequisites

- It is recommended to run the script from a **Non-OneDrive** folder.  Create a folder in a Non-OneDrive location, for example, C:\AMBA.

    ``mkdir AMBA``

- Change directory to that new folder.

    ``cd AMBA``

- Clone this repository and specific branch using Git.  If you do not have Git installed, see [here](https://git-scm.com/download/win)

    ``
    git clone -b amba-gap-analysis https://github.com/Azure/azure-monitor-baseline-alerts.git
    ``

- Change directory to AMBA-Gap-Analysis-Sandbox

    ``
    cd .\azure-monitor-baseline-alerts\tooling\gap-analysis\
    ``

- Run the 1_amba_collector.ps1 script.  You must replace the TenantID and SubscriptionIds to match your tenant and subscription ids.

    ``
    ./1_amba_collector.ps1 -TenantID "YOUR TENANT ID" -SubscriptionIds "/subscriptions/YOUR SUBSCRIPTION ID"
    ``

- If you want to run the script across multiple subscriptions, separate them with a comma.  Here is an example using the command above and passing in 2 subscriptions.

    ``
    ./1_amba_collector.ps1 -TenantID "cf72e698-0000-42e0-893d-1f2fb9000000" -SubscriptionIds "/subscriptions/e3900bd4-0000-4b29-b32d-a532dc000000","/subscriptions/0e432b0f-5d11-0000-b3a6-765340000000"
    ``

- **The script will ask you to log into your Azure account**.  Once the script is complete, you should see a new JSON file with a timestamp created in the same directory.  For example: AMBA-File-2024-09-20-16-37.json.

- Open the JSON file using the editor of your choice.  Examine the first section that contains "ImpactedResources."  You should see entries for each alert that is missing for each resource.

- To create an Excel spreadsheet using the exported JSON data, run the 2_amba_data_analyzer.ps1 script and pass in the JSON file created in the previous steps.  Once the script is complete, you should see a new Excel file with a timestamp created in the same directory.  For example: AMBA Action Plan 2024-09-23-16-42.xlsx.

    ``
    .\2_amba_data_analyzer.ps1 -JSONFile 'YOUR JSON FILE'
    ``
