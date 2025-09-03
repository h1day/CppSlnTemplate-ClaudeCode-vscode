# SARIF to VS Code Problems format converter
param(
    [Parameter(Mandatory=$true)]
    [string]$InputFile
)

if (!(Test-Path $InputFile)) {
    Write-Error "Input file not found: $InputFile"
    exit 1
}

try {
    $sarif = Get-Content $InputFile -Encoding UTF8 | ConvertFrom-Json
    
    foreach ($run in $sarif.runs) {
        foreach ($result in $run.results) {
            $ruleId = $result.ruleId
            $level = $result.level
            $message = $result.message.text
            
            # Convert SARIF level to VS Code severity
            $severity = switch ($level) {
                "error" { "error" }
                "warning" { "warning" }
                "note" { "info" }
                "info" { "info" }
                default { "warning" }
            }
            
            foreach ($location in $result.locations) {
                $physicalLocation = $location.physicalLocation
                if ($physicalLocation) {
                    $file = $physicalLocation.artifactLocation.uri
                    $region = $physicalLocation.region
                    $line = $region.startLine
                    $column = if ($region.startColumn) { $region.startColumn } else { 1 }
                    
                    # Output in VS Code problem format: file:line:column: severity: message [ruleId]
                    Write-Output "$file`:$line`:$column`: $severity`: $message [$ruleId]"
                }
            }
        }
    }
} catch {
    Write-Error "Failed to parse SARIF: $($_.Exception.Message)"
    exit 1
}