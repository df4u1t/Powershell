Import-Module ActiveDirectory
# No of days - Get AD users who are no logged in last 90 days
$DaysInactive = 180  
$time = (Get-Date).Adddays(-($DaysInactive)) 
Get-ADUser -Filter { LastLogonTimeStamp -lt $time -and enabled -eq $true -and userPrincipalName -ne '*' } -Properties * | 
 
Select-Object Name,UserPrincipalName, @{Name="LastLogonTimeStamp"; 
Expression={[DateTime]::FromFileTime($_.lastLogonTimestamp).ToString()}} |
# Export Inactive Users Report to CSV file 
Export-CSV "C:\InactiveADUsers.csv" -NoTypeInformation -Encoding UTF8