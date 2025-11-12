param (
    [Parameter(Mandatory = $false)]
    [string] $Location = "$($env:LOCATION)",

    [Parameter(Mandatory = $false)]
    [string] $pseudoRootManagementGroup = "$($env:TOP_LEVEL_MG)",

    [Parameter(Mandatory = $false)]
    [string] $RepoFullName = "$($env:REPO_FULL_NAME)",

    [Parameter(Mandatory = $false)]
    [string] $BranchName = "$($env:BRANCH_NAME)",

    [Parameter(Mandatory = $false)]
    [string] $TemplateParameterFile = "./patterns/alz/alzArm.test.param.json",

    [Parameter(Mandatory = $false)]
    [bool] $WhatIfEnabled = [System.Convert]::ToBoolean($env:IS_PULL_REQUEST)
)


$deploymentName = "alz-AMBADeploy-{0}" -f (Get-Date -Format "yyyyMMddTHHmmss")
$deploymentName = $deploymentName.Substring(0, [Math]::Min(64, $deploymentName.Length))


$deploymentParams = @{
    Name                  = $deploymentName
    Location              = $Location
    TemplateUri           = "https://raw.githubusercontent.com/$RepoFullName/$BranchName/patterns/alz/alzArm.json"
    TemplateParameterFile = $TemplateParameterFile
    ManagementGroupId     = $pseudoRootManagementGroup
    Verbose               = $true
}

if ($WhatIfEnabled) {
    Write-Host "Running in What-If mode for PR validation..."
    New-AzManagementGroupDeployment @deploymentParams -WhatIf
} else {
    Write-Host "Running full deployment..."
    New-AzManagementGroupDeployment @deploymentParams
}
