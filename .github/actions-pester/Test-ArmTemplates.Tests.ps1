<# Script to validate ARM templates using the Test-AzTemplate cmdlet #>

# Define a function to get the list of changed files in a pull request
function Get-ChangedFile {
    [CmdletBinding(SupportsShouldProcess)]
    param (
        # Parameter to filter files by path
        [Parameter()]
        [String]$pathFilter,

        # Parameter to filter files by extension
        [Parameter()]
        [String]$extensionFilter,

        # Parameter to specify the pull request branch, defaulting to the GitHub head reference
        [Parameter()]
        [String]$PRBranch = "$($env:GITHUB_HEAD_REF)"
    )
    # Get the list of changed files between the main branch and the pull request branch
    Write-Output "Checking for changed files in the pull request branch: $PRBranch"
    $changedFiles = git diff --name-only main $PRBranch --

    # Create a regex pattern to filter files based on the provided path and extension
    $regex = "$pathFilter.*\.$extensionFilter"

    # Filter the changed files using the regex pattern
    $resultFiles = $changedFiles | Where-Object { $PSItem -match $regex }

    # Return the filtered files
    $resultFiles | ForEach-Object {
        return $_
    }
}

# Get the list of modified ARM template files
$ModifiedFiles = @(Get-ChangedFile -pathFilter 'templates/arm' -extensionFilter 'json')

# Check if there are any modified ARM template files
if ($null -ne $ModifiedFiles) {
    Write-Output "These are the modified ARM templates: $($ModifiedFiles)"
} else {
    Write-Output "There are no modified ARM templates"
}

# Initialize a counter for the number of failed tests
$NumberOfFailedTests = 0

# Iterate over each modified ARM template file
$ModifiedFiles | ForEach-Object {
    $TemplatePath = $PSItem
    Write-Output "Test $TemplatePath"

    # Run the Test-AzTemplate cmdlet to test the ARM template
    $testResults = Test-AzTemplate -TemplatePath $TemplatePath -Test deploymentTemplate -ErrorAction Continue

    # Filter the test results to find any failed tests
    $failedTests = $testResults | Where-Object { $PSItem.Passed -ne $True }

    # If there are failed tests, log a warning and increment the failed tests counter
    if ($failedTests -ne $null) {
        $failedTests | ForEach-Object {
            Write-Warning "$($PSItem | Out-String)"
            $NumberOfFailedTests++
        }
    }
}

# If there are any failed tests, log an error and exit with a non-zero status
If ($NumberOfFailedTests -gt 0) {
    Write-Error "There are $NumberOfFailedTests failed tests"
    exit 1
}

