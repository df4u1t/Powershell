$GROUPS = 'Administrators', 'Enterprise Admins', 'Schema Admins', 'SMSMSE Admins', 'Domain Admins'
$PATH = 'c:\audit'
$HOSTNAME = gc env:computername
$PATH = Join-Path -Path $PATH -ChildPath $HOSTNAME
$FILE = Join-Path -Path $PATH -ChildPath 'admin-lastlogon.csv'

if (!(test-path $PATH)) {
    New-Item $PATH -ItemType Directory
    }
foreach ($group in $groups) {
    $users = Get-ADGroupMember -Identity $group -Recursive | Sort-Object -Unique | Select -ExpandProperty SamAccountName
}
foreach ($user in $users) {
    Get-ADUser -Identity $user -Properties SamAccountName, LastLogonDate | select SamAccountName, LastLogonDate | Export-Csv $FILE -Append
}
