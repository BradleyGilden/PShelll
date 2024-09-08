param(
    # File Path (to be hard coded)
    [String]$FilePath,

    # Date of log file
    [Parameter(Mandatory = $true)]
    [String]$LogDate,

    # Last N lines of a log file
    [Int]$Lines=1000
)

<#
Function: Write-ErrorMessage
Purpose: Writes Error Message
Returns: $null
#>
function Write-ErrorMessage {
    Write-Host -ForegroundColor Red "Please ensure your date argument format is as follows:"
    Write-Host -ForegroundColor Magenta 'dd-mm-yyyy' -NoNewline
    Write-Host " OR " -NoNewline
    Write-Host -ForegroundColor Magenta 'dd/mm/yyyy' -NoNewline
    Write-Host " OR " -NoNewline
    Write-Host -ForegroundColor Magenta 'dd\mm\yyyy'
    exit 1
}

$dateParams = $LogDate -csplit "[-\\/]"

$dateParams = $dateParams | Where-Object {$_}

# check for correct date format
if ($dateParams.Length -lt 3) {
    Write-ErrorMessage
} elseif ($dateParams[0].Length -ne 2 -or $dateParams[1].Length -ne 2 -or $dateParams[2].Length -ne 4) {
    Write-ErrorMessage
} elseif ($dateParams[0] -notmatch "^\d+$" -or $dateParams[1] -notmatch "^\d+$" -or $dateParams[2] -notmatch "^\d+$") {
    Write-ErrorMessage
}

$day = $dateParams[0]
$month = $dateParams[1]
$year = $dateParams[2]

# Match regex file pattern to text content in file
$filePattern = "$day/$month/$year\s\d\d:\d\d:\d\d:\sExecuting\s<[a-zA-Z]:\\MrpSports\\scripts\\(pre)?stock\\ld_(res|pre)_stock.bat>\s\.\.\."

try {
    if ($Lines -gt -1) {
        $matched = Get-Content -LiteralPath $FilePath -Tail $Lines -ErrorAction Stop | Select-String -Pattern $filePattern -Context 0,1 -CaseSensitive
    } else {
        $matched = Get-Content -LiteralPath $FilePath -ErrorAction Stop | Select-String -Pattern $filePattern -Context 0,1 -CaseSensitive
    }
    
    if (-not $matched) {
        Write-Host -ForegroundColor Red "No log entries found for the given date $day/$month/$year"
        exit 1
    }

    foreach($match in $matched) {
        Write-Host -ForegroundColor Green $match.Line
        Write-Host $match.Context.PostContext
    }
} catch {
    if ($_.CategoryInfo.Reason -eq 'ItemNotFoundException') {
        Write-Host -ForegroundColor Red "Error: The file path " -NoNewline
        Write-Host $FilePath -NoNewline
        Write-Host -ForegroundColor Red " is invalid or cannot be found"
    } else {
        Write-Host -ForegroundColor Red $_.Exception.Message
    }
    exit 1
}
