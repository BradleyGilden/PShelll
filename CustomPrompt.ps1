param(
    [string]$Argument1
)

$CWD = $PWD.Path

if($CWD -cmatch "C:\\Users\\$($Env:USERNAME)") {
    $CWD = $CWD -creplace "C:\\Users\\$($Env:USERNAME)", ""
    $CWD = $CWD -split '\\'
    $CWD1 = $CWD[0..($CWD.Length - 3)]
    $i = $CWD1.Length - 1
    while($i -ge 0) {
        $CWD1[$i--] = $CWD1[$i][0]
    }
    $CWD1 = Write-Output $CWD1 | Where-Object {$_}
    if ($CWD1 -isnot [array]) {
        $CWD1 = @($CWD1)
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