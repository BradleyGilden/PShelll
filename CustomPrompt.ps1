$CWD = $PWD.Path

Write-Host $CWD

if($CWD -cmatch "C:\\Users\\$($Env:USERNAME)") {
    $CWD = $CWD -creplace "C:\\Users\\$($Env:USERNAME)", ""
    $CWD = $CWD -split '\\'
    $CWD1 = $CWD[0..($CWD.Length - 3)]
    $i = $CWD1.Length - 1
    while($i -ge 0) {
        if (-not $CWD1[$i]) {
            Remove-Variable -Name $CWD1[$i]
            $i--
        }
        else {
            $CWD1[$i] = $CWD1[$i][0]
        }
        $i--
    }
    Write-Host $CWD1[0]
    $CWD2 = $CWD[-2..-1]
    $CWD = $CWD1 + $CWD2
    Write-Host $CWD, $CWD1, $CWD2
    Write-Host ('~' + $CWD)
}