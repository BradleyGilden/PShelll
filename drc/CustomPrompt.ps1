param(
    [string]$ArgPath
)

$CWD = $ArgPath

if($CWD -cmatch "C:\\Users\\$($Env:USERNAME)") {
    Write-Host 'conditonal 1'
    $CWD = $CWD -creplace "C:\\Users\\$($Env:USERNAME)\\?", ""
    $CWD = $CWD -split '\\'
    $CWD1 = $CWD[0..($CWD.Length - 3)]
    $i = $CWD1.Length - 1
    while($i -ge 2) {
        $CWD1[$i--] = $CWD1[$i][0]
    }
    Write-Host $CWD1
    $CWD2 = $CWD[-2..-1]
    if ($CWD1.Length - 1 -gt 2) {
        $CWD = $CWD1 + $CWD2
    } else {
        $CWD = $CWD2
    }
    $CWD = $CWD -join '\'
    if ($CWD) {
        $CWD = '~\' + $CWD
    } else {
        $CWD = '~'
    }

    $Env:CWD = $CWD
    Write-Host $CWD
} elseif ($CWD.StartsWith("[A-Z]:\\Users")){
    Write-Host 'conditonal 1'
    $CWD = $CWD -creplace "C:\\", ""
    $CWD = $CWD -split '\\'
    $CWD = $CWD -join '\'
    $CWD = '\' + $CWD
    $Env:CWD = $CWD
    Write-Host $CWD
} else {
    Write-Host 'conditonal 1'
    $Env:CWD = $CWD
    Write-Host $CWD
}

# Invokes method before prompt
# Register-EngineEvent -SourceIdentifier PowerShell.OnIdle -Action {CustomPrompt}