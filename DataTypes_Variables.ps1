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
# Or use a seperator
Write-Host -Separator ', ' $array


Write-Host $array2
[System.Array]::Reverse($array)
Write-Host 'reversed array:' $array

$date = Get-Date -Date "06/02/2002 13:00:00"

Write-Host $date.DayOfWeek

# API requests

Write-Host "`n************************ Making API Requests *************************`n"

$response = Invoke-RestMethod -Method Get -Uri 'https://jsonplaceholder.typicode.com/todos/1'


Write-Host $response

$response = $response | ConvertTo-Json

Write-Host $response