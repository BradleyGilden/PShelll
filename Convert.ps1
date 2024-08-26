# There are 3 methods of conversion
$num = 32

# Explicit casting
# There are no safety measures
Write-Host (([String]$num).GetType())

# Use -as operator, which returns null if it cannot convert

Write-Host (($num -as [String]).GetType())
$str = 's.d.f'
Write-Host ($null -eq ($str -as [Int]))

# Use .NET methods
Write-Host ($num.ToString().GetType())
