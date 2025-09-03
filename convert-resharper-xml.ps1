# ReSharper XML Report to VS Code Problems format converter
param(
    [Parameter(Mandatory=$true)]
    [string]$InputFile
)

if (!(Test-Path $InputFile)) {
    Write-Error "Input file not found: $InputFile"
    exit 1
}

try {
    [xml]$xml = Get-Content $InputFile -Encoding UTF8
    
    foreach ($issue in $xml.Report.Issues.Project.Issue) {
        $file = $issue.File
        $line = $issue.Line
        $message = $issue.Message
        $typeId = $issue.TypeId
        
        # Determine severity based on IssueType
        $severity = "warning"  # default
        $issueType = $xml.Report.IssueTypes.IssueType | Where-Object { $_.Id -eq $typeId }
        if ($issueType) {
            switch ($issueType.Severity) {
                "ERROR" { $severity = "error" }
                "WARNING" { $severity = "warning" }
                "SUGGESTION" { $severity = "info" }
                default { $severity = "warning" }
            }
        }
        
        # Output in VS Code problem format: file:line:column: severity: message
        Write-Output "$file`:$line`:1`: $severity`: $message"
    }
} catch {
    Write-Error "Failed to parse XML: $($_.Exception.Message)"
    exit 1
}