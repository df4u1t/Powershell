$groups = 'Administrators', 'Enterprise Admins', 'Schema Admins', 'SMSMSE Admins', 'Domain Admins'

function Get-RandomCharacters($length, $characters) { 
    $random = 1..$length | ForEach-Object { Get-Random -Maximum $characters.length } 
    $private:ofs="" 
    return [String]$characters[$random]
}
foreach ($group in $groups) {
    $users = Get-ADGroupMember -Identity $group -Recursive | Sort-Object -Unique | Select -ExpandProperty SamAccountName
}
foreach ($user in $users) {
    if ($user -eq 'CHANGEME') {
        $password = 'CHANGEME'
        Add-Content -Path C:\TempPath\creds.txt -value "$user new password is $password"
        Set-ADAccountPassword -Identity $users -Reset -NewPassword (ConvertTo-SecureString -AsPlainText $password -Force)
    }
    else {
        $password = Get-RandomCharacters -length 16 -characters 'abcdefghiklmnoprstuvwxyzABCDEFGHKLMNOPRSTUVWXYZ1234567890!"§$%&/()=?}][{@#*+'
        Add-Content -Path C:\TempPath\creds.txt -Value "$user new password is $password"
        Set-ADAccountPassword -Identity 'agjadmin' -Reset -NewPassword (ConvertTo-SecureString -AsPlainText $password -Force)
    }
}
