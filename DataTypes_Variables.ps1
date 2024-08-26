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

# The culuture will effect how the date and currency is processed
Set-Culture 'en-ZA'

$price = 1234.567
Write-Host ("The price is {0:C}" -f $price)

$date = Get-Date -Date "06/02/2002 13:00:00"


Write-Host $date.DayOfWeek

# API requests

Write-Host -ForegroundColor Blue "`n************************ Making API Requests *************************`n"

$response = Invoke-RestMethod -Method Get -Uri 'https://jsonplaceholder.typicode.com/todos/1'


Write-Host -ForegroundColor Magenta $response

$response = $response | ConvertTo-Json

Write-Host -ForegroundColor Yellow $response

#################################################################################
Write-Host -ForegroundColor Blue "`nALL PROVIDER DRIVES ON THE SYSTEM" 

Get-PSDrive
Write-Host ''
# Provider Drive variables
Write-Host "Alias for ls: ${Alias:ls}"
# Provider drive for environment
Write-Host $Env:LANG

# Static built-in variable

$radius = 2.45
$circumference = 2 * ([Math]::PI) * $radius

Write-Host ([Math]::Round($circumference, 2))

# ******************************** TYPES ************************************
Write-Host -ForegroundColor Blue "`n ******************** TYPES ***********************`n"
# Powershell is built ontop of .NET, so shares same types with properties and methods as C#
Write-Host ([Float]::isNaN([Float]::NaN))
Write-Host ([Short]::MaxValue) # there is also Int, Long, Uint, Ulong, Byte, Sbyte
$num = 32
Write-Host ($num.ToString(32).GetType())

# Hash Table (similar to obj)

Write-Host -ForegroundColor Blue "`n****************** Hash Tables ********************`n"

$hash1 = @{ FirstName = "James"; LastName = "Anderson" }

Write-Host $hash1

Write-Host "`$hash1['FirstName'] or `$hash1.FirstName: " $hash1.FirstName
