#######################################################################################################################
# Runbook: Register Microsoft.AlertsManagement Resource Provider
#######################################################################################################################

<#	
	.NOTES
	===========================================================================
	 Created on:  20251014
	 Created by:  Kim Nordqvist
	 Organization:  Onevinn
	 Filename:  register_required_resourceProvider_by_AMBA_on_sub.ps1
     Source Repo :  Custom
	===========================================================================
	.DESCRIPTION
	Runbook will register the required resource provider 'Microsoft.AlertsManagement' on all subscriptions in the tenant.
    The Prod Automation Account Managed ID need the following roles set:
    EntraID role: none
	Azure role: Custom role with 'Microsoft.AlertsManagement/register/action' permission on either Intermediate Management Group or at tenant root MG level (depending on scope of subscriptions to check)
	.NOTES	
#>


param (
    [Parameter(Mandatory = $true)][bool]$TriggerAlertRule
)
$script:TriggerAlertRule = $TriggerAlertRule


#######################################################################################################################
# Functions
#######################################################################################################################
function Write-OutPutStream {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true, ParameterSetName = 'Info')][switch]$Info,
        [Parameter(Mandatory = $true, ParameterSetName = 'Warning')][switch]$Warning,
        [Parameter(ParameterSetName = 'Info')][Parameter(ParameterSetName = 'Warning')][string]$OutputString,
        [Parameter(ParameterSetName = 'Info')][Parameter(ParameterSetName = 'Warning')][switch]$CollectErrorsSilently
    )
    
    if ($info.IsPresent) {
        Write-Output "$outputstring"
    }
    if ($warning.IsPresent -and ($script:TriggerAlertRule)) {
        If ($CollectErrorsSilently) {
            $script:errCounter++
            [string]$script:errCollector += "$OutputString <br>Exception: $($_.Exception.Message) <br>Scriptline: $($_.InvocationInfo.ScriptLineNumber). <br>Command: $($_.InvocationInfo.Line)<br><br>"
        } Else {
            Write-Warning "$OutputString <br>Exception: $($_.Exception.Message) <br>Scriptline: $($_.InvocationInfo.ScriptLineNumber). <br>Command: $($_.InvocationInfo.Line)<br><br>"
        }
    }
    if ($warning.IsPresent -and -not ($script:TriggerAlertRule)) {
        If ($CollectErrorsSilently) {
            Write-Output "Warning: $OutputString, Exception: $($_.Exception.Message), Scriptline: $($_.InvocationInfo.ScriptLineNumber), Command: $($_.InvocationInfo.Line)"
        } Else {
            Write-Output "Warning: $OutputString, Exception: $($_.Exception.Message), Scriptline: $($_.InvocationInfo.ScriptLineNumber), Command: $($_.InvocationInfo.Line)"
        }
    }
} #End function Write-OutPutStream

#######################################################################################################################
# Start of script
#######################################################################################################################
Write-OutPutStream -Info -OutputString "Runbook execution started - registering 'Microsoft.AlertsManagement' provider for all subscriptions."

# Connect AzAccount
try {
    Connect-AzAccount -Identity -WarningAction SilentlyContinue
    Write-OutPutStream -Info -OutputString "Connected to Azure as the Automation Account's managed identity."
    #Update-AzConfig -DisplayBreakingChangeWarning $false -Scope CurrentUser
    #Write-OutPutStream -Info -OutputString "Updated AzConfig to suppress breaking change warnings."
}
catch {
    Write-OutPutStream -Warning -OutputString "Failed to connect to Azure."
    Exit
}

# Clear previous errors
Clear-variable -name errCounter, errCollector -ErrorAction SilentlyContinue

#######################################################################################################################
# Step 1: Get all subscriptions in the tenant
#######################################################################################################################
try {
    #$subscriptions = Get-AzSubscription | where-object { $_.Name -eq "p-security-sub" } # used for testing purposes
    #$subscriptions = Get-AzSubscription | where-object { $_.Name -eq "p-security-sub" -and $_.Tags["AMBAenabled"] -ne "yes" } # used for testing purposes
    $subscriptions = Get-AzSubscription | where-object { $_.Tags -and $_.Tags["AMBAenabled"] -ne "yes" } # used for testing purposes
    Write-OutPutStream -Info -OutputString "Retrieved $($subscriptions.Count) subscriptions from the tenant."
    if ($subscriptions.Count -eq 0) {
        Write-OutPutStream -Info -OutputString "No subscriptions found that require registration of 'Microsoft.AlertsManagement'. Exiting runbook."
        Exit
    }
    if ($subscriptions.Count -gt 0) {
        Write-OutPutStream -Info -OutputString "Found $($subscriptions.Count) subscriptions that require registration of 'Microsoft.AlertsManagement' in order to enable AMBA onboarding. Proceeding with registration."
    }
}
catch {
    Write-OutPutStream -Warning -OutputString "Failed to retrieve subscriptions."
    Exit
}

#######################################################################################################################
# Step 2: Check and register 'Microsoft.AlertsManagement' provider for each subscription
#######################################################################################################################
foreach ($sub in $subscriptions) {
    try {
        Write-OutPutStream -Info -OutputString "Processing subscription '$($sub.Name)' ($($sub.Id))"
        Set-AzContext -SubscriptionId $sub.Id | Out-Null

        # Check provider registration
        $provider = Get-AzResourceProvider -ProviderNamespace "Microsoft.AlertsManagement" -ErrorAction SilentlyContinue

        if ($null -eq $provider -or $provider.RegistrationState -ne "Registered") {
            Write-OutPutStream -Info -OutputString "Registering resource provider 'Microsoft.AlertsManagement' in subscription '$($sub.Name)'."
            Register-AzResourceProvider -ProviderNamespace "Microsoft.AlertsManagement" #| Out-Null
            Start-Sleep -Seconds 12 # Wait for registration to propagate
            Get-AzResourceProvider -ProviderNamespace "Microsoft.AlertsManagement" #| Out-Null

            # Register provider and wait for completion
            $maxRetries = 8
            $retryCount = 0
            $registrationCompleted = $false
            while (-not $registrationCompleted -and $retryCount -lt $maxRetries) {
                Start-Sleep -Seconds 10
                $provider = Get-AzResourceProvider -ProviderNamespace "Microsoft.AlertsManagement" -ErrorAction SilentlyContinue
                if ($provider.RegistrationState -eq "Registered") {
                    $registrationCompleted = $true
                } else {
                    $retryCount++
                    Write-OutPutStream -Info -OutputString "Waiting for registration to complete... (Attempt $($retryCount) of $($maxRetries))"
                }
            }

            # Verify registration
            $provider = Get-AzResourceProvider -ProviderNamespace "Microsoft.AlertsManagement"
            if ($provider.RegistrationState -eq "Registered") {
                Write-OutPutStream -Info -OutputString "Successfully registered 'Microsoft.AlertsManagement' in subscription '$($sub.Name)'."
                # Verify tag presence on newly processed subscriptions
                $tags = Get-AzTag -ResourceId "\subscriptions\$($sub.Id)" -ErrorAction SilentlyContinue
                if ($tags.properties.tagsproperty.keys -contains "AMBAenabled" -and $tags.properties.tagsproperty.values -contains "yes") {
                    Write-OutPutStream -Info -OutputString "Subscription '$($sub.Name)' already has the 'AMBAenabled' tag set to 'yes'."
                } else {
                    Write-OutPutStream -Info -OutputString "Adding 'AMBAenabled' tag with value 'yes' to subscription '$($sub.Name)'."
                    Update-AzTag -ResourceId "\subscriptions\$($sub.Id)" -Tag @{ AMBAenabled = "yes" } -Operation Merge | Out-Null
                    Write-OutPutStream -Info -OutputString "Successfully added 'AMBAenabled' tag to subscription '$($sub.Name)'."
                }
            } else {
                Write-OutPutStream -Warning -CollectErrorsSilently -OutputString "Registration attempted for 'Microsoft.AlertsManagement' but verification failed in subscription '$($sub.Name)'."
            }
        } else {
            Write-OutPutStream -Info -OutputString "'Microsoft.AlertsManagement' already registered in subscription '$($sub.Name)'."
            # Verify tag presence on already registered subscriptions
            $tags = Get-AzTag -ResourceId "\subscriptions\$($sub.Id)" -ErrorAction SilentlyContinue
            if ($tags.properties.tagsproperty.keys -contains "AMBAenabled" -and $tags.properties.tagsproperty.values -contains "yes") {
                Write-OutPutStream -Info -OutputString "Subscription '$($sub.Name)' already has the 'AMBAenabled' tag set to 'yes'."
            } else {
                Write-OutPutStream -Info -OutputString "Adding 'AMBAenabled' tag with value 'yes' to subscription '$($sub.Name)'."
                Update-AzTag -ResourceId "\subscriptions\$($sub.Id)" -Tag @{ AMBAenabled = "yes" } -Operation Merge | Out-Null
                Write-OutPutStream -Info -OutputString "Successfully added 'AMBAenabled' tag to subscription '$($sub.Name)'."
            }
        }
    }
    catch {
        Write-OutPutStream -Warning -CollectErrorsSilently -OutputString "Failed to process subscription '$($sub.Name)' due to an error."
    }
clear-variable -name tags -ErrorAction SilentlyContinue
}
#######################################################################################################################
# Step 2.1: Check status of 'Microsoft.AlertsManagement' provider for each subscription and update tag if missing
#######################################################################################################################
foreach ($sub in $subscriptions) {
    try {
        Write-OutPutStream -Info -OutputString "Verifying registration and tag for subscription '$($sub.Name)' ($($sub.Id))"
        Set-AzContext -SubscriptionId $sub.Id | Out-Null

        # Check provider registration
        $provider = Get-AzResourceProvider -ProviderNamespace "Microsoft.AlertsManagement" -ErrorAction SilentlyContinue

        if ($null -ne $provider -and $provider.RegistrationState -eq "Registered") {
            Write-OutPutStream -Info -OutputString "'Microsoft.AlertsManagement' is registered in subscription '$($sub.Name)'."
            # Verify tag presence on already registered subscriptions
            $tags = Get-AzTag -ResourceId "\subscriptions\$($sub.Id)" -ErrorAction SilentlyContinue
            if ($tags.properties.tagsproperty.keys -contains "AMBAenabled" -and $tags.properties.tagsproperty.values -contains "yes") {
                Write-OutPutStream -Info -OutputString "Subscription '$($sub.Name)' already has the 'AMBAenabled' tag set to 'yes'."
            } else {
                Write-OutPutStream -Info -OutputString "Adding 'AMBAenabled' tag with value 'yes' to subscription '$($sub.Name)'."
                Update-AzTag -ResourceId "\subscriptions\$($sub.Id)" -Tag @{ AMBAenabled = "yes" } -Operation Merge | Out-Null
                Write-OutPutStream -Info -OutputString "Successfully added 'AMBAenabled' tag to subscription '$($sub.Name)'."
            }
        } else {
            Write-OutPutStream -Warning -CollectErrorsSilently -OutputString "'Microsoft.AlertsManagement' is NOT registered in subscription '$($sub.Name)'. Please investigate."
        }
    }
    catch {
        Write-OutPutStream -Warning -CollectErrorsSilently -OutputString "Failed to verify subscription '$($sub.Name)' due to an error."
    }
}
#######################################################################################################################
# Step 3: Summary
#######################################################################################################################
if ($script:errCounter -gt 0) {
    Write-OutPutStream -Warning -OutputString "Runbook completed with $($script:errCounter) warnings or errors: <br><br>$($script:errCollector)"
} else {
    Write-OutPutStream -Info -OutputString "Runbook completed successfully with no issues."
}

Clear-variable -name errCounter, errCollector -ErrorAction SilentlyContinue
Write-OutPutStream -Info -OutputString "End of runbook."
