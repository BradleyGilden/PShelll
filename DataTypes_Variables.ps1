# variable
$a = 2
Write-Output $a

# array
$array = 1,2,3,4,5
# defining and/or concatenating arrays
$array2 = @(1..10), @("hey", "there")
$count = 0

# foreach array example
foreach ($item in $array) {
    if ($count -ne $array.Count - 1) {
        # string concatenation
        $output = $item.ToString() + ', '
    } else {
        $output = $item
    }
    Write-Host -NoNewline $output
    $count++
}

Write-Host ''

Write-Host $array2