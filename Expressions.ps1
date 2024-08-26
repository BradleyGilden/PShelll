# Initializing and appending arrays

# defining an empty array
$x = @()
$x = 10,20,30
$a = $($x; 99)                     # $a.Length is 4

Write-Host $a

$x = New-Object 'int[]' 3
$a = $($x; 99)                     # equivalent, $a.Length is 4

Write-Host $a

$a = $(New-Object 'int[]' 3; 99)   # $a.Length is 2

Write-Host $a

# splitting strings

Write-Host -ForegroundColor Blue "`n*********** SPLITTING STRINGS **************`n"
# does not work with a delimeter longer than 1 char
Write-Host ("1,2,3,4" -split ",")
# works with multiple chars
Write-Host ("1...2...3...4".Split("..."))
# repeating strings
Write-Host -ForegroundColor Blue "`n*********** REPEATING *************`n"
Write-Host ("red" * "3")
$a = ((1,2,3,4) * "3")
Write-Host $a.Length
# 2D array
$a = @((3, 4), (5, 6))
Write-Host $a.Length
