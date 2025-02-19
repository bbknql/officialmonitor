<#
.SYNOPSIS
    PowerShell automation script
.DESCRIPTION
    This script performs automated tasks
.PARAMETER Path
    Target path for operation
.EXAMPLE
    .\script.ps1 -Path "C:\Data"
#>

[CmdletBinding()]
param(
    [Parameter(Mandatory=$false)]
    [string]$Path = ".",
    
    [Parameter(Mandatory=$false)]
    [switch]$Verbose
)

function Get-ProcessedData {
    [CmdletBinding()]
    param(
        [Parameter(ValueFromPipeline=$true)]
        [string[]]$InputData
    )
    
    process {
        foreach ($item in $InputData) {
            Write-Verbose "Processing: $item"
            [PSCustomObject]@{
                Item = $item
                Processed = $true
                Timestamp = Get-Date
            }
        }
    }
}

function Invoke-MainProcess {
    [CmdletBinding()]
    param()
    
    Write-Host "Starting process..." -ForegroundColor Green
    
    try {
        $results = @("Item1", "Item2", "Item3") | Get-ProcessedData
        
        $results | Format-Table -AutoSize
        
        Write-Host "Process completed successfully" -ForegroundColor Green
    }
    catch {
        Write-Error "Error occurred: $_"
        throw
    }
}

# Main execution
if ($MyInvocation.InvocationName -ne '.') {
    Invoke-MainProcess
}
