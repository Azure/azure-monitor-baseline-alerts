# Script to fix EditorConfig issues in JSON files
param(
    [Parameter(Mandatory = $false)]
    [string[]]$FilePaths
)

function Fix-JsonFile {
    param(
        [string]$FilePath
    )

    Write-Host "Fixing: $FilePath"

    # Read file as bytes to preserve encoding
    $content = Get-Content -Path $FilePath -Raw

    # Determine correct line ending based on path
    $isServiceFile = $FilePath -match '[\\/]services[\\/].*\.json$' -and $FilePath -notmatch '[\\/]templates[\\/]'

    if ($isServiceFile) {
        # Services files use CRLF
        $lineEnding = "`r`n"
    } else {
        # All other files use LF
        $lineEnding = "`n"
    }

    # Normalize line endings
    $content = $content -replace "`r`n", "`n"  # Convert CRLF to LF
    $content = $content -replace "`r", "`n"    # Convert CR to LF

    if ($lineEnding -eq "`r`n") {
        $content = $content -replace "`n", "`r`n"  # Convert back to CRLF if needed
    }

    # Ensure final newline (except for patterns/alz/policyDefinitions/*.json)
    $skipFinalNewline = $FilePath -match '[\\/]patterns[\\/]alz[\\/]policyDefinitions[\\/].*\.json$' -or
                        $FilePath -match '[\\/]patterns[\\/]alz4Subs[\\/]policyDefinitions[\\/].*\.json$'

    if (-not $skipFinalNewline) {
        if (-not $content.EndsWith($lineEnding)) {
            $content += $lineEnding
        }
    } else {
        # Remove final newline for policy definitions
        $content = $content.TrimEnd("`r`n")
    }

    # Write back with UTF8 encoding without BOM
    $utf8NoBom = New-Object System.Text.UTF8Encoding $false
    [System.IO.File]::WriteAllText($FilePath, $content, $utf8NoBom)
}

# Get list of files to fix
if ($FilePaths) {
    $files = $FilePaths | ForEach-Object { Get-Item $_ }
} else {
    # Find all JSON files that commonly have issues
    $files = @()
    $files += Get-ChildItem -Path ".\patterns\alz\policyDefinitions" -Filter "*.json" -File
    $files += Get-ChildItem -Path ".\patterns\alz4Subs\policyDefinitions" -Filter "*.json" -File -ErrorAction SilentlyContinue
    $files += Get-ChildItem -Path ".\services" -Filter "*.json" -Recurse -File | Where-Object { $_.FullName -notlike "*\templates\*" }
}

Write-Host "Found $($files.Count) files to process"

foreach ($file in $files) {
    Fix-JsonFile -FilePath $file.FullName
}

Write-Host "Done! Fixed $($files.Count) files."
