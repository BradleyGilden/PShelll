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
} elseif ($dateParams[0].Length -ne 2 -or $dateParams[1].Length -ne 2 -or $dateParams[2].Length -ne 4) {
    DisplayError
    exit
} elseif ($dateParams[0] -notmatch "^\d+$" -or $dateParams[1] -notmatch "^\d+$" -or $dateParams[2] -notmatch "^\d+$") {
    DisplayError
    exit
}

$day = $dateParams[0]
$month = $dateParams[1]
$year = $dateParams[2]

try {
    $matched = Select-String -LiteralPath $ArgPath  -Pattern "$day/$month/$year \d\d:\d\d:\d\d:\sExecuting\s<[a-zA-Z]:\\MrpSports\\scripts\\(pre)?stock\\ld_(res|pre)_stock.bat>\s\.\.\." -Context 0,1 -CaseSensitive
    
    if (-not $matched) {
        Write-Host -ForegroundColor Red "No log entries found with the given date $day/$month/$year"
        exit
    }

    foreach($match in $matched) {
        Write-Host -ForegroundColor Green $match.Line
        Write-Host $match.Context.PostContext
    }
} catch {
    Write-Host -ForegroundColor Red "Error: The file path " -NoNewline
    Write-Host $ArgPath -NoNewline
    Write-Host -ForegroundColor Red " is invalid or cannot be found"
}
