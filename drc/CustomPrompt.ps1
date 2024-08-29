$CWD = $PWD.Path

Write-Host $CWD

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

    Write-Host $CWD
} else {
    $CWD = $CWD -creplace "[A-Z]:\\", ""
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
        $CWD = '\' + $CWD
    } else {
        $CWD = '\'
    }

    Write-Host $CWD
}