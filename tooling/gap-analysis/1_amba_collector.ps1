#Requires -Version 7

<#
.SYNOPSIS
Azure Monitor Baseline Alerts (AMBA) Gap Analysis v0.1 collector script

.DESCRIPTION
This script does...

.LINK
https://azure.github.io/azure-monitor-baseline-alerts/welcome/

.PARAMETER Debugging
[Switch]: Enables debugging output.

.PARAMETER TenantID
Specifies the Entra tenant ID to be used to authenticate to Azure.

.PARAMETER SubscriptionIds
Specifies the subscription IDs to be included in the analysis. Multiple subscription IDs should be separated by commas. Subscription IDs must be in either GUID form (e.g., 00000000-0000-0000-0000-000000000000) or full subscription ID form (e.g., /subscriptions/00000000-0000-0000-0000-000000000000).

NOTE: Can't be used in combination with -ConfigFile parameter.

.PARAMETER ResourceGroups
Specifies the resource groups to be included in the analysis. Multiple resource groups should be separated by commas. Resource groups must be in full resource group ID form (e.g., /subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/rg1).

.PARAMETER AzureEnvironment
Specifies the Azure environment to be used. Valid values are 'AzureCloud' and 'AzureUSGovernment'. Default value is 'AzureCloud'.

.EXAMPLE
Run against all subscriptions in tenant "00000000-0000-0000-0000-000000000000":
.\1_amba_collector.ps1 -TenantID 00000000-0000-0000-0000-000000000000

.EXAMPLE
Run against specific subscriptions in tenant "00000000-0000-0000-0000-000000000000":
.\1_amba_collector.ps1 -TenantID 00000000-0000-0000-0000-000000000000 -SubscriptionIds /subscriptions/00000000-0000-0000-0000-000000000000,/subscriptions/11111111-1111-1111-1111-111111111111

.OUTPUTS
A JSON file with the collected data.
#>

[Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingWriteHost', '', Justification = 'False positive as Write-Host does not represent a security risk and this script will always run on host consoles')]
[Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSReviewUnusedParameter', '', Justification = 'False positive as parameters are not always required')]

Param(
        [switch]$Debugging,
        [ValidatePattern('^(\/subscriptions\/)?[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$')]
        [String[]]$SubscriptionIds,
        [ValidatePattern('^\/subscriptions\/[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}\/resourceGroups\/[a-zA-Z0-9._-]+$')]
        [String[]]$ResourceGroups,
        [GUID]$TenantID,
        [ValidatePattern('^[^<>&%\\?/]+=~[^<>&%\\?/]+$|[^<>&%\\?/]+!~[^<>&%\\?/]+$')]
        [String[]]$Tags,
        [ValidateSet('AzureCloud', 'AzureUSGovernment')]
        $AzureEnvironment = 'AzureCloud'
        )


#import-module "./modules/collector.psm1" -Force

$Script:ShellPlatform = $PSVersionTable.Platform

$Script:Runtime = Measure-Command -Expression {


  Function Test-ResourceGroupId {
    param (
      [string[]]$InputValue
    )
    $pattern = '\/subscriptions\/[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}\/resourceGroups\/[a-zA-Z0-9._-]+'

    $allMatch = $true

    $InputValue | ForEach-Object {
      if ($_ -notmatch $Pattern) {
        $allMatch = $false
      }
    }
    return $allMatch
  }

  Function Test-SubscriptionId {
    param (
      [string[]]$InputValue
    )
    $pattern = '\/subscriptions\/[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}'

    $allMatch = $true

    $InputValue | ForEach-Object {
      if ($_ -notmatch $Pattern) {
        $allMatch = $false
      }
    }
    return $allMatch
  }

  Function Get-AllAzGraphResource {
    param (
      [string[]]$subscriptionId,
      [string]$query = 'Resources | project id, resourceGroup, subscriptionId, name, type, location'
    )

    $result = $subscriptionId ? (Search-AzGraph -Query $query -first 1000 -Subscription $subscriptionId) : (Search-AzGraph -Query $query -first 1000 -usetenantscope) # -first 1000 returns the first 1000 results and subsequently reduces the amount of queries required to get data.

    # Collection to store all resources
    $allResources = @($result)

    # Loop to paginate through the results using the skip token
    while ($result.SkipToken) {
      # Retrieve the next set of results using the skip token
      $result = $subscriptionId ? (Search-AzGraph -Query $query -SkipToken $result.SkipToken -Subscription $subscriptionId -First 1000) : (Search-AzGraph -query $query -SkipToken $result.SkipToken -First 1000 -UseTenantScope)
      # Add the results to the collection
      $allResources += $result
    }

    # Output all resources
    return $allResources
  }

  function Get-ResourceGroupsByList {
    param (
      [Parameter(Mandatory = $true)]
      [array]$ObjectList,

      [Parameter(Mandatory = $true)]
      [array]$FilterList,

      [Parameter(Mandatory = $true)]
      [string]$KeyColumn
    )

    $matchingObjects = @()

    foreach ($obj in $ObjectList) {
      if (($obj.$KeyColumn.split('/')[0..4] -join '/') -in $FilterList) {
        $matchingObjects += $obj
      }
    }

    return $matchingObjects
  }

  function Test-ScriptParameters {
    $IsValid = $true

    if (!($TenantId)) {
          Write-Host "Tenant ID (-TenantId) is required." -ForegroundColor Red
          $IsValid = $false
    }

    if (!($SubscriptionIds) -and !($ResourceGroups)) {
          Write-Host "Subscription ID(s) (-SubscriptionIds) or resource group(s) (-ResourceGroups) are required." -ForegroundColor Red
          $IsValid = $false
    }
    return $IsValid
  }

  function Invoke-ResetVariable {
    $Script:SubIds = ''
    $Script:AllResourceTypes = @()
    $Script:SupportedResTypes = @()
    $Script:AllResourceTypesOrdered = @()
    $Script:AllServiceHealth = @()
    $Script:results = @()
    $Script:InScope = @()
    $Script:OutOfScope = @()
    $Script:PreInScopeResources = @()
    $Script:PreOutOfScopeResources = @()
  }

  function Test-Requirement {
    # Install required modules
    try
      {
        Write-Host "Validating " -NoNewline
        Write-Host "Az.ResourceGraph" -ForegroundColor Cyan -NoNewline
        Write-Host " Module.."
        $AzModules = Get-Module -Name Az.ResourceGraph -ListAvailable -ErrorAction silentlycontinue
        if ($null -eq $AzModules)
          {
            Write-Host "Installing Az Modules" -ForegroundColor Yellow
            Install-Module -Name Az.ResourceGraph -SkipPublisherCheck -InformationAction SilentlyContinue
          }
        $Script:ScriptData = [pscustomobject]@{
            Version             = $Script:Version
            Debugging           = if($Debugging.IsPresent){$true}else{$false}
            SubscriptionIds     = if($SubscriptionIds){$SubscriptionIds}else{$false}
            ResourceGroups      = if($ResourceGroups){$ResourceGroups}else{$false}
          }
      }
    catch
      {
        # Report Error
        $errorMessage = $_.Exception.Message
        Write-Host "Error executing function Requirements: $errorMessage" -ForegroundColor Red
      }
  }

  function Set-LocalFile {
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'Low')]
    param()

    if ($PSCmdlet.ShouldProcess('')) {
      Write-Debug 'Setting local path'
      try {
        # Define script path as the default path to save files
        $workingFolderPath = $PSScriptRoot
        Set-Location -Path $workingFolderPath;

        # Validates if queries are applicable based on Resource Types present in the current subscription
        if ($Script:ShellPlatform -eq 'Win32NT') {
          $RootTypes = Get-Content -Path "AMBAinScopeResTypes.csv" | ConvertFrom-Csv
        } else {
          $RootTypes = Get-Content -Path "AMBAinScopeResTypes.csv" | ConvertFrom-Csv
        }
        $Script:SupportedResTypes = (($RootTypes | Where-Object {$_.AMBAinScope -eq 'yes'}).ResourceType).tolower()

        # Read in AMBA metric alerts
        if ($Script:ShellPlatform -eq 'Win32NT') {
          $RootMetricAlerts = Get-Content -Path "amba-metric-alerts.csv" | ConvertFrom-Csv
        } else {
          $RootMetricAlerts = Get-Content -Path "amba-metric-alerts.csv" | ConvertFrom-Csv
        }
        #Get all metric alerts that are visible (popular and verified)
        $Script:AMBAMetricAlerts = $RootMetricAlerts | Where-Object {$_.visible -eq 'TRUE'}

      } catch {
        # Report Error
        $errorMessage = $_.Exception.Message
        Write-Host "Error executing function LocalFiles: $errorMessage" -ForegroundColor Red
      }
    }
  }

  function Connect-ToAzure {
    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory = $true)]
        [ValidatePattern("^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$")]
        [GUID]$TenantID,

        [ValidateSet('AzureCloud', 'AzureChinaCloud', 'AzureGermanCloud', 'AzureUSGovernment')]
        [string]$AzureEnvironment = 'AzureCloud'
    )

    begin {
        Write-Verbose "Starting connection process to Azure Tenant."
        $AzContext = $null
    }

    process {
        try {
            # Attempt to get the current Azure context
            $AzContext = Get-AzContext -ErrorAction SilentlyContinue

            # Check if a valid context is available or if it matches the provided Tenant ID
            if ($null -eq $AzContext -or $AzContext.Tenant.Id -ne $TenantID) {
                Write-Verbose "Not logged into a tenant with any of the specified subscriptions. Authenticating to Azure. `n"

                # Check if EnableLoginByWam is true
                if ((Get-AzConfig -EnableLoginByWam).Value -eq $true) {
                    Write-Verbose "Process: Disabling interactive login experience (EnableLoginByWam).`n"
                    # Disable the WAM login experience for the current PowerShell session
                    Update-AzConfig -EnableLoginByWam $false -Scope Process | Out-Null
                }

                # Check if LoginExperienceV2 is 'On'
                if ((Get-AzConfig -LoginExperienceV2).Value -eq 'On') {
                    Write-Verbose "Process: Disabling interactive login experience (LoginExperienceV2).`n"
                    # Disable the new login experience for the current PowerShell session
                    Update-AzConfig -LoginExperienceV2 Off -Scope Process | Out-Null
                }

                Write-Verbose 'Process: Connecting to Azure.'
                Write-Verbose "No existing context found or context does not match TenantID. Connecting to Azure..."
                Connect-AzAccount -Tenant $TenantID -Environment $AzureEnvironment -ErrorAction Stop -WarningAction Ignore -InformationAction Ignore
                $AzContext = Get-AzContext -ErrorAction Stop
                Write-Verbose "Successfully connected to Azure Tenant: $TenantID"
            }
            else {
                Write-Host "`nAlready connected to Azure Tenant: $($AzContext.Tenant.Id)`n" -ForegroundColor Green
            }

            # Validate that the provided Subscription IDs exist in the current context
            $Script:SubIds = Get-AzSubscription -ErrorAction Stop -WarningAction Ignore
            Write-Verbose "Connected to Azure Tenant: $($AzContext.Tenant.Id) with Subscriptions: $($SubscriptionIds -join ', ')"
        }
        catch {
            throw "Failed to connect to Azure Tenant: $TenantID or retrieve subscriptions. Error: $_"
        }
    }

    end {
        if ($AzContext) {
            Write-Verbose "Connection process completed successfully."
        }
        else {
            throw "Connection process failed. No valid Azure context available."
        }
    }
  }

  function Start-ScopesLoop {
    $Date = (Get-Date).AddMonths(-24)
    $Date = $Date.ToString('MM/dd/yyyy')
    if ($AzureEnvironment -eq 'AzureUSGovernment') {
      $BaseURL = 'management.usgovcloudapi.net'
    } else {
      $BaseURL = 'management.azure.com'
    }
    $LoopedSub = @()

    foreach ($Scope in $Scopes)
      {
        if (![string]::IsNullOrEmpty($Scope))
          {
            $ScopeWithoutParameter = $Scope.split(" -")[0]
            $ScopeParameters = $Scope.split(" -")
            $ScopeParameters = $ScopeParameters[1..($ScopeParameters.Length-1)]
            $Subscription = $ScopeWithoutParameter.split("/")[2]
            $RGroup = if (![string]::IsNullOrEmpty($ScopeWithoutParameter.split("/")[4])){$ScopeWithoutParameter.split("/")[4]}else{$null}
            $SubId = $SubIds | Where-Object { $_.Id -eq $Subscription }
            Write-Host '---------------------------------------------------------------------'
            Write-Host 'Validating Scope: ' -NoNewline
            Write-Host $ScopeWithoutParameter -ForegroundColor Cyan

            Set-AzContext -Subscription $Subscription -ErrorAction SilentlyContinue -WarningAction SilentlyContinue | Out-Null
            Select-AzSubscription -Subscription $Subscription -WarningAction SilentlyContinue -InformationAction SilentlyContinue | Out-Null

            Write-Host '----------------------------'
            Write-Host 'Collecting: ' -NoNewline
            Write-Host 'Resources Details' -ForegroundColor Magenta
            if ($ScopeWithoutParameter.split("/").count -lt 5)
              {
                $InScopeSub = $ScopeWithoutParameter.split("/")[2]
                $ScopeQuery = "resources | where subscriptionId =~ '$InScopeSub' | project id, resourceGroup, subscriptionId, name, type, location"
              }
            elseif ($ScopeWithoutParameter.split("/").count -gt 4 -and $Scope.split("/").count -lt 8)
              {
                $InScopeSub = $Scope.split("/")[2]
                $InScopeRG = $Scope.split("/")[4]
                $ScopeQuery = "resources | where subscriptionId =~ '$InScopeSub' and resourceGroup =~ '$InScopeRG' | project id, resourceGroup, subscriptionId, name, type, location"
              }
            elseif ($ScopeWithoutParameter.split("/").count -ge 9)
              {
                $ScopeQuery = "resources | where id =~ '$ScopeWithoutParameter' | project id, resourceGroup, subscriptionId, name, type, location"
              }
            #Filter out the Supported Types
            if($Debugging.IsPresent)
              {
                Write-Host $ScopeQuery -ForegroundColor Cyan
              }
            $ScopeResources = Get-AllAzGraphResource -query $ScopeQuery -subscriptionId $Subid
            foreach ($Resource in $ScopeResources)
              {
                if ($Resource.type -in $Script:SupportedResTypes)
                  {
                    if ($Resource.id -notin $Script:PreInScopeResources.id)
                      {
                        $Script:PreInScopeResources += $Resource
                      }
                  }
                else
                  {
                    $Script:PreOutOfScopeResources += $Resource
                  }
              }

              
            if ($SubId -notin $LoopedSub) {
              Write-Host '----------------------------'
              Write-Host 'Collecting: ' -NoNewline
              Write-Host 'Service Health Alerts' -ForegroundColor Magenta
              Invoke-ServiceHealthExtraction $Subid
              $LoopedSub += $SubId
            }

            Write-Host '----------------------------'
            Write-Host 'Running: ' -NoNewline
            Write-Host 'Queries' -ForegroundColor Magenta
            Write-Host '----------------------------'
            Start-ResourceExtraction -Scope $ScopeWithoutParameter
          }
      }
  }

  function Invoke-QueryExecution {
    param($type, $Subscription, $query, $alertToCheck)

    if ($Debugging.IsPresent)
      {
        Write-Host $query -ForegroundColor Yellow
      }

    try {
      $ResourceType = $Script:AllResourceTypes | Where-Object { $_.Name -eq $type}
      if (![string]::IsNullOrEmpty($resourceType)) {
        # Execute the query and collect the results
        $queryResults = Get-AllAzGraphResource -query $query -subscriptionId $Subscription

        $queryResults = $queryResults | Sort-Object -Property name, id

        foreach ($row in $queryResults) {
            $result = [PSCustomObject]@{
              name                    = [string]$row.name
              Type                    = [string]$type
              id                      = [string]$row.id
              rg                      = [string]$row.resourceGroup
              alertToCheck            = [string]$alertToCheck
              alert                   = [string]$row.alert
              metricNamespace         = [string]$row.metricNamespace
              implemented             = [string]$row.implemented
              severity                = [string]$row.severity
              severityMatch           = [string]$row.severityMatch
              windowSize              = [string]$row.windowSize
              windowSizeMatch         = [string]$row.windowSizeMatch
              evaluationFrequency     = [string]$row.evaluationFrequency
              evaluationFrequencyMatch= [string]$row.evaluationFrequencyMatch
              threshold               = [string]$row.threshold
              thresholdMatch          = [string]$row.thresholdMatch
              operator                = [string]$row.operator
              operatorMatch           = [string]$row.operatorMatch
              timeAggregation         = [string]$row.timeAggregation
              timeAggregationMatch    = [string]$row.timeAggregationMatch
              criterionType           = [string]$row.criterionType
              criterionTypeMatch      = [string]$row.criterionTypeMatch 
            }
          $result
        }
      }
    } catch {
      # Report Error
      $errorMessage = $_.Exception.Message
      Write-Host "Error processing query results: $errorMessage" -ForegroundColor Red
    }
  }

  function Start-ResourceExtraction {
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'Low')]
    param($Scope)

    $TempResult = @()
    if ($PSCmdlet.ShouldProcess('')) {
      $Scope = $Scope.split(" -")[0]

      if ($Scope.split("/").count -lt 5)
        {
          $Subid = $Scope.split("/")[2]
          $ResourceGroup = $null
        }
      elseif ($Scope.split("/").count -gt 4 -and $Scope.split("/").count -lt 8)
        {
          $Subid = $Scope.split("/")[2]
          $ResourceGroup = $Scope.split("/")[4]
        }
      elseif ($Scope.split("/").count -ge 9)
        {
          $Subid = $Scope.split("/")[2]
          $ResourceGroup = $Scope.split("/")[4]
        }

      # Set the variables used in the loop
      if ($Scope.split("/").count -lt 5)
        {
          # Extract and display resource types with the query with subscriptions, we need this to filter the subscriptions later
          $resultAllResourceTypes = $Script:PreInScopeResources | Where-Object { $_.id -like "/subscriptions/$Subid*"} | Group-Object -Property type -NoElement
          $Script:AllResourceTypes += $resultAllResourceTypes
        }
      elseif ($Scope.split("/").count -gt 4 -and $Scope.split("/").count -lt 8)
        {
          $resultAllResourceTypes = $Script:PreInScopeResources | Where-Object { $_.id -like "/subscriptions/$Subid/resourcegroups/$ResourceGroup*" } | Group-Object -Property type -NoElement
          $Script:AllResourceTypes += $resultAllResourceTypes
        }
      elseif ($Scope.split("/").count -ge 9)
        {
          $resultAllResourceTypes = $Script:PreInScopeResources | Where-Object { $_.id -eq $Scope } | Group-Object -Property type -NoElement
          $Script:AllResourceTypes += $resultAllResourceTypes
        }

        foreach ($Type in $resultAllResourceTypes.Name) {
          if ($Type.ToLower() -in $Script:SupportedResTypes) {
            foreach ($alert in $Script:AMBAMetricAlerts) {
              $alertResourceCategory = $alert.ResourceCategory
              $alertResourceType = $alert.ResourceType
              $alertType = "microsoft.$alertResourceCategory/$alertResourceType"
              if (($alertType.ToLower() -eq $Type.ToLower())) {
                $metricNamespace      = $alert.metricNamespace
                $metricName           = $alert.metricName
                $operator             = if($alert.operator) {$alert.operator} else {'NA'}
                $threshold            = if($alert.threshold) {$alert.threshold} else {0.0}
                $severity             = if($alert.severity) {$alert.severity} else {'NA'}
                $windowSize           = if($alert.windowSize) {$alert.windowSize} else {'NA'}
                $evaluationFrequency  = if($alert.evaluationFrequency) {$alert.evaluationFrequency} else {'NA'}
                $timeAggregation      = if($alert.timeAggregation) {$alert.timeAggregation} else {'NA'}
                $criterionType        = if($alert.criterionType) {$alert.criterionType} else {'NA'}

                Write-Host "----------------------------"
                Write-Host "Running Query for: $metricNamespace - $metricName"
                Write-Host "----------------------------"

                $query = "resources
                          | where type =~ 'microsoft.insights/metricalerts'
                          | extend targetType = tostring(properties.targetResourceType)
                          | where targetType =~ '$metricNamespace'
                          | extend targetRegion = tostring(properties.targetResourceRegion)
                          | extend criteria = properties.criteria.allOf
                          | mv-expand criteria
                          | where criteria.metricName =~ '$metricName'
                          | extend operatorMatch = iff(criteria.operator == '$operator', 'Yes', 'No')
                          | extend thresholdMatch = iff(criteria.threshold == $threshold, 'Yes', 'No')
                          | extend severityMatch = iff(properties.severity == '$severity', 'Yes', 'No')
                          | extend windowSizeMatch = iff(properties.windowSize == '$windowSize', 'Yes', 'No')
                          | extend evaluationFrequencyMatch = iff(properties.evaluationFrequency == '$evaluationFrequency', 'Yes', 'No')
                          | extend timeAggregationMatch = iff(criteria.timeAggregation == '$timeAggregation', 'Yes', 'No')
                          | extend criterionTypeMatch = iff(criteria.criterionType == '$criterionType', 'Yes', 'No')
                          | extend implemented = iff(criteria.metricName == '$metricName' and operatorMatch == 'Yes' and thresholdMatch == 'Yes' and severityMatch == 'Yes' and windowSizeMatch == 'Yes' and evaluationFrequencyMatch == 'Yes' and timeAggregationMatch == 'Yes' and criterionTypeMatch == 'Yes', 'Yes', 'Partial')
                          | extend scopes = properties.scopes
                          | project alert=tostring(criteria.metricName), implemented, severity=tostring(properties.severity), severityMatch, windowSize=tostring(properties.windowSize), windowSizeMatch, evaluationFrequency=tostring(properties.evaluationFrequency), evaluationFrequencyMatch, threshold=toreal(criteria.threshold), thresholdMatch, operator=tostring(criteria.operator), operatorMatch, timeAggregation=tostring(criteria.timeAggregation), timeAggregationMatch, criterionType=tostring(criteria.criterionType), criterionTypeMatch, type=targetType, targetRegion, scopes
                          | mv-expand scopes
                          | project id = tostring(scopes), alert, implemented, type, targetRegion, severity, severityMatch, windowSize, windowSizeMatch, evaluationFrequency, evaluationFrequencyMatch, threshold, thresholdMatch, operator, operatorMatch, timeAggregation, timeAggregationMatch, criterionType, criterionTypeMatch
                          | extend subscriptionId = tostring(split(id, '/', 2)[0])
                          | join kind=fullouter resources on subscriptionId
                          | where type1 =~ '$Type'
                          | project-away kind, managedBy, sku, plan, properties, identity, zones, extendedLocation
                          | extend alert = iff(isempty(id), '$metricName', alert)
                          | extend implemented = iff(targetRegion !~ location or isempty(id), 'No', implemented)
                          | extend isSubScope = iff(array_length(split(id,'/'))==3, 'Yes', 'No')
                          | extend isRgScope = iff(array_length(split(id,'/'))==5, 'Yes', 'No')
                          | extend rgMatch = iff(isRgScope == 'Yes' and id == strcat('/subscriptions/', subscriptionId1, '/resourcegroups/', resourceGroup), 'Yes', 'No')
                          | extend implemented = iff(id !contains id1 and isSubScope == 'No' and isRgScope == 'No', 'No', implemented)
                          | extend id = iff(id!~id1 and isSubScope == 'No' and isRgScope == 'No', id1, id)
                          | where id=~id1 or isSubScope == 'Yes' or (isRgScope == 'Yes' and rgMatch == 'Yes') or isempty(id)
                          | extend severity = iff(implemented=='No', '', severity) | extend windowSize = iff(implemented=='No', '', windowSize) | extend evaluationFrequency = iff(implemented=='No', '', evaluationFrequency)
                          | extend threshold = iff(implemented=='No', 0.0, threshold) | extend thresholdMatch = iff(implemented=='No', '', thresholdMatch) | extend operator = iff(implemented=='No', '', operator)
                          | extend operatorMatch = iff(implemented=='No', '', operatorMatch) | extend timeAggregation = iff(implemented=='No', '', timeAggregation) | extend criterionType = iff(implemented=='No', '', criterionType)
                          | summarize implemented=make_list(implemented) by id=id1, name, type=type1, resourceGroup, alert
                          | where implemented !has 'Yes'
                          | extend implemented = iff(implemented has 'Partial', 'Partial', 'No')
                          | project id, name, type, resourceGroup, alert, metricNamespace='$metricNamespace', implemented
                          //| project id=id1, name, type=type1, resourceGroup, alert, implemented, severity, severityMatch, windowSize, windowSizeMatch, evaluationFrequency, evaluationFrequencyMatch, threshold, thresholdMatch, operator, operatorMatch, timeAggregation, timeAggregationMatch, criterionType, criterionTypeMatch"
                          
                #THIS IS WHERE IMPACTED RESOURCES ARE COLLECTED
                $TempResult += Invoke-QueryExecution -type $type -Subscription $Subid -query $query -alertToCheck $alert.metricName
              }  
            }
          }
        }

        if ($Scope.split("/").count -gt 4 -and $Scope.split("/").count -lt 8)
          {
            $Script:results += Get-ResourceGroupsByList -ObjectList $TempResult -FilterList $Scope -KeyColumn "id"
          }
        else
          {
            $Script:results += $TempResult
          }
      }
  }

  Function Invoke-FilterResourceID {
    [cmdletbinding()]
    Param(
        $ResourceID,
        $List
    )
    ForEach ($item in $List){
        If ($ResourceID -eq $Item.id){$item}
    }
}

  function Invoke-ResourceFiltering {
    Write-Host "Selecting In-Scope Resources.." -ForegroundColor Cyan
    $Script:InScope = $Script:PreInScopeResources


    if (![string]::IsNullOrEmpty($Script:ExcludeList))
      {
        Write-Host "Filtering Excluded Resources.." -ForegroundColor Cyan
        $Script:InScope = $Script:InScope | Where-Object {$_.id -notin $Script:ExcludeList.id}
      }

    Write-Host "Ordering Impacted Resources.." -ForegroundColor Cyan
    $Script:results = $Script:results | Sort-Object -Property name, Type, id, alertToCheck

    Write-Host "Filtering Impacted Resources.." -ForegroundColor Cyan
    $Script:ImpactedResources = foreach ($Temp in $Script:results)
      {
        $TempResID = $Temp.id.split('/')
        $TempResID = ('/'+$TempResID[1]+ '/'+ $TempResID[2]+ '/'+ $TempResID[3]+ '/'+ $TempResID[4]+ '/'+ $TempResID[5]+ '/'+ $TempResID[6]+ '/'+ $TempResID[7]+ '/'+ $TempResID[8])

        if ($Temp.id -eq "n/a") {
          $result = [PSCustomObject]@{
            name             = 'n/a'
            id               = 'n/a'
            type             = 'n/a'
            location         = 'n/a'
            subscriptionId   = 'n/a'
            resourceGroup    = 'n/a'
          }
          $result
        }
        elseif ($TempResID -in $Script:InScope.id)
          {
              $TempDetails = Invoke-FilterResourceID -Resource $TempResID -List $Script:PreInScopeResources
              $result = [PSCustomObject]@{
                name                  = $Temp.name
                id                    = $Temp.id
                type                  = $TempDetails.type
                location              = $TempDetails.location
                subscriptionId        = $TempDetails.subscriptionId
                resourceGroup         = $TempDetails.resourceGroup
                alertToCheck          = $Temp.alertToCheck
                alert                 = $Temp.alert
                metricNamespace       = $Temp.metricNamespace
                implemented           = $Temp.implemented
                severity              = $Temp.severity
                severityMatch         = $Temp.severityMatch
                windowSize            = $Temp.windowSize
                windowSizeMatch       = $Temp.windowSizeMatch
                evaluationFrequency   = $Temp.evaluationFrequency
                evaluationFrequencyMatch = $Temp.evaluationFrequencyMatch
                threshold             = $Temp.threshold
                thresholdMatch        = $Temp.thresholdMatch
                operator              = $Temp.operator
                operatorMatch         = $Temp.operatorMatch
                timeAggregation       = $Temp.timeAggregation
                timeAggregationMatch  = $Temp.timeAggregationMatch
                criterionType         = $Temp.criterionType
                criterionTypeMatch    = $Temp.criterionTypeMatch
              }
              $result
            }
    }

    $Script:ImpactedResources = $Script:ImpactedResources | Sort-Object -Property name, Type, id, alertToCheck


    Write-Host "Filtering Out of Scope Resources.." -ForegroundColor Cyan
    $Script:OutOfScope = foreach ($ResIID in $Script:PreOutOfScopeResources)
      {
        $result = [PSCustomObject]@{
          description      = 'Resource out of scope'
          type             = $ResIID.type
          subscriptionId   = $ResIID.subscriptionId
          resourceGroup    = $ResIID.resourceGroup
          name             = $ResIID.name
          location         = $ResIID.location
          id               = $ResIID.id
        }
        $result
      }
  }

  function Resolve-ResourceType {
    $TempTypes = $Script:ImpactedResources | Where-Object { $_.validationAction -eq 'IMPORTANT - Resource Type is not available in either APRL or Advisor - Validate Resources manually if Applicable, if not Delete this line' }
    $Script:AllResourceTypes = $Script:AllResourceTypes | Sort-Object -Property Count -Descending
    $Looper = $Script:AllResourceTypes | Sort-Object -Property Name -Unique
    foreach ($result in $Looper.Name) {
      $ResourceTypeCount = (($Script:AllResourceTypes | Where-Object { $_.Name -eq $result }) | Select-Object -ExpandProperty Count | Measure-Object -Sum).Sum
      $ResultType = $result
      if ($ResultType -in $TempTypes.recommendationId) {
        $tmp = [PSCustomObject]@{
          'Resource Type'               = [string]$ResultType
          'Number of Resources'         = [string]$ResourceTypeCount
        }
        $Script:AllResourceTypesOrdered += $tmp
      } elseif ($ResultType -notin $TempTypes.recommendationId) {
        $tmp = [PSCustomObject]@{
          'Resource Type'               = [string]$ResultType
          'Number of Resources'         = [string]$ResourceTypeCount
        }
        $Script:AllResourceTypesOrdered += $tmp
      }
    }
  }

  function Invoke-ServiceHealthExtraction {
    param($Subid)

    $Servicequery = "resources | where type == 'microsoft.insights/activitylogalerts' | order by id"
    $queryResults = Get-AllAzGraphResource -Query $Servicequery -subscriptionId $Subid

    $Rowler = @()
    $Rowler = foreach ($row in $queryResults) {
      foreach ($type in $row.properties.condition.allOf) {
        if ($type.equals -eq 'ServiceHealth') {
          $row
        }
      }
    }

    $Script:AllServiceHealth = foreach ($Row in $Rowler) {
      $SubName = ($SubIds | Where-Object { $_.Id -eq ($Row.properties.scopes.split('/')[2]) }).Name
      $EventType = if ($Row.Properties.condition.allOf.anyOf | Select-Object -Property equals) { $Row.Properties.condition.allOf.anyOf | Select-Object -Property equals | ForEach-Object { switch ($_.equals) { 'Incident' { 'Service Issues' } 'Informational' { 'Health Advisories' } 'ActionRequired' { 'Security Advisory' } 'Maintenance' { 'Planned Maintenance' } } } } Else { 'All' }
      $Services = if ($Row.Properties.condition.allOf | Where-Object { $_.field -eq 'properties.impactedServices[*].ServiceName' }) { $Row.Properties.condition.allOf | Where-Object { $_.field -eq 'properties.impactedServices[*].ServiceName' } | Select-Object -Property containsAny | ForEach-Object { $_.containsAny } } Else { 'All' }
      $Regions = if ($Row.Properties.condition.allOf | Where-Object { $_.field -eq 'properties.impactedServices[*].ImpactedRegions[*].RegionName' }) { $Row.Properties.condition.allOf | Where-Object { $_.field -eq 'properties.impactedServices[*].ImpactedRegions[*].RegionName' } | Select-Object -Property containsAny | ForEach-Object { $_.containsAny } } Else { 'All' }
      $ActionGroupName = if ($Row.Properties.actions.actionGroups.actionGroupId) { $Row.Properties.actions.actionGroups.actionGroupId.split('/')[8] } else { '' }

      $result = [PSCustomObject]@{
        Name         = [string]$row.name
        Subscription = [string]$SubName
        Enabled      = [string]$Row.properties.enabled
        EventType    = $EventType
        Services     = $Services
        Regions      = $Regions
        ActionGroup  = $ActionGroupName
      }
      $result
    }
  }

  function New-JsonFile {
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'Low')]
    param()

    if ($PSCmdlet.ShouldProcess('')) {
      Write-Host $ResourceGroups -ForegroundColor Yellow

      $ResourceExporter = @{
        ImpactedResources = $Script:ImpactedResources
      }
      $OutOfScopeExporter = @{
        OutOfScope = $Script:OutOfScope
      }
      $ResourceTypeExporter = @{
        ResourceType = $Script:AllResourceTypesOrdered
      }
      $ServiceHealthExporter = @{
        ServiceHealth = $Script:AllServiceHealth
      }
      $ScriptDetailsExporter = @{
        ScriptDetails = $Script:ScriptData
      }
      if ($Debugging.IsPresent)
        {
          $InScopeExporter = @{
            InScopeResources = $Script:InScope
          }
          $PreInScopeExporter = @{
            InScopeBeforeTagFiltering = $Script:PreInScopeResources
          }
          $ImpactedResourcesBeforeFilteringExporter = @{
            ImpactedResourcesBeforeFiltering = $Script:results
          }
        }


      $ExporterArray = @()
      $ExporterArray += $ResourceExporter
      $ExporterArray += $ResourceTypeExporter
      $ExporterArray += $ServiceHealthExporter
      $ExporterArray += $ScriptDetailsExporter
      $ExporterArray += $OutOfScopeExporter
      if ($Debugging.IsPresent)
        {
          $ExporterArray += $InScopeExporter
          $ExporterArray += $PreInScopeExporter
          $ExporterArray += $ImpactedResourcesBeforeFilteringExporter
        }

      $Script:JsonFile = ($PSScriptRoot + '\AMBA-File-' + (Get-Date -Format 'yyyy-MM-dd-HH-mm') + '.json')

      $ExporterArray | ConvertTo-Json -Depth 15 | Out-File $Script:JsonFile
    }
  }


  #Call the functions
  $Script:Version = '0.1'
  Write-Host 'Version: ' -NoNewline
  Write-Host $Script:Version -ForegroundColor DarkBlue

  Write-Debug "Checking parameters..."

  if (!(Test-ScriptParameters)) {
    Write-Host 'Invalid parameters. Exiting...' -ForegroundColor Red
    Exit
  }


  
    $Scopes = @()
    if ($SubscriptionIds)
      {
        $Scopes += foreach ($Sub in $SubscriptionIds)
        {
          $_guid = [Guid]::NewGuid()

          if ([Guid]::TryParse($Sub, [ref]$_guid)) {
            $SubId = "/subscriptions/$Sub"
            Write-Host "[-SubscriptionIds]: Fixed '$Sub' >> '$SubId'" -ForegroundColor Yellow
            "/subscriptions/$Sub" # Fixed!
          } else {
            Write-Host "[-SubscriptionIds]: $Sub" -ForegroundColor Cyan
            $Sub
          }
        }
      }
    if ($ResourceGroups)
      {
        $Scopes += foreach ($RG in $ResourceGroups)
          {
            Write-Host "[-ResourceGroups]: $RG" -ForegroundColor Cyan
            $RG
          }
      }
  

  Write-Debug 'Reseting Variables'
  Invoke-ResetVariable

  Write-Debug 'Calling Function: Test-Requirements'
  Test-Requirement

  Write-Debug 'Calling Function: Set-LocalFiles'
  Set-LocalFile

  Write-Debug "Calling Function: Connect-ToAzure"
  Connect-ToAzure -TenantID $TenantID -AzureEnvironment $AzureEnvironment

  Write-Debug 'Calling Function: Start-ScopesLoop'
  Start-ScopesLoop

  Write-Debug 'Calling Function: Invoke-ResourcesFiltering'
  Invoke-ResourceFiltering

  Write-Debug 'Calling Function: Resolve-ResourceTypes'
  Resolve-ResourceType

  Write-Debug 'Calling Function: New-JsonFile'
  New-JsonFile

}

$TotalTime = $Script:Runtime.Totalminutes.ToString('#######.##')

Write-Host '---------------------------------------------------------------------'
Write-Host ('Execution Complete. Total Runtime was: ') -NoNewline
Write-Host $TotalTime -NoNewline -ForegroundColor Cyan
Write-Host (' Minutes')
Write-Host 'Result File: ' -NoNewline
Write-Host $Script:JsonFile -ForegroundColor Blue
Write-Host '---------------------------------------------------------------------'

