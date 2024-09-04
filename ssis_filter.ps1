param(
    [String]$ArgPath,
    [String]$ArgDate
)

function DisplayError {
    Write-Host -ForegroundColor Red "Please ensure your date argument format is as follows:"
    Write-Host -ForegroundColor Magenta 'dd-mm-yyyy' -NoNewline
    Write-Host " OR " -NoNewline
    Write-Host -ForegroundColor Magenta 'dd/mm/yyyy' -NoNewline
    Write-Host " OR " -NoNewline
    Write-Host -ForegroundColor Magenta 'dd\mm\yyyy'
}

$dateParams = $ArgDate -csplit "[-\\/]"

$dateParams = $dateParams | Where-Object {$_}

if ($dateParams.Length -lt 3) {
    DisplayError
    exit
} elseif ($dateParams[0].Length -lt 2 -or $dateParams[1].Length -lt 2 -or $dateParams[2].Length -lt 4) {
    DisplayError
    exit
} elseif ($dateParams[0] -notmatch "^\d+$" -or $dateParams[1] -notmatch "^\d+$" -or $dateParams[2] -notmatch "^\d+$") {
    DisplayError
    exit
}

Write-Host $dateParams

# Get-Content $ArgPath | Select-String -CaseSensitive -Context 0,1 -Pattern ""
