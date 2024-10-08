param(
    [string]$ArgPath
)

$CWD = $ArgPath

if($CWD -cmatch "C:\\Users\\$($Env:USERNAME)") {
    $CWD = $CWD -creplace "C:\\Users\\$($Env:USERNAME)\\?", ""
    $CWD = $CWD -split '\\'

    $CWD1 = $CWD.Length -gt 2 ? $CWD[0..($CWD.Length - 3)] : @()

    $i = $CWD1.Length

    while($i -gt 0) {
        $CWD1[$i - 1] = $CWD1[$i - 1][0]
        $i--
    }

    $CWD2 = $CWD[-2..-1]
    $CWD = $CWD1 + $CWD2
    $CWD = $CWD -join '\'

    if ($CWD) {
        $CWD = '~\' + $CWD
    } else {
        $CWD = '~'
    }

    $Env:CWD = $CWD
} elseif ($CWD.StartsWith("[A-Z]:\\Users")){
    $CWD = $CWD -creplace "C:\\", ""
    $CWD = $CWD -split '\\'
    $CWD = $CWD -join '\'
    $CWD = '\' + $CWD
    $Env:CWD = $CWD
} else {
    $Env:CWD = $CWD
}

# Invokes method before prompt
# Register-EngineEvent -SourceIdentifier PowerShell.OnIdle -Action {CustomPrompt}
