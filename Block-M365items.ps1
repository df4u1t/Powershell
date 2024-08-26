Set-ExecutionPolicy RemoteSigned

$senderdomain = ""
$url = ""
$hash = ""

##Must have ExchangeOnlineManagement module already installed
Import-Module ExchangeOnlineManagement
Connect-ExchangeOnline -ShowProgress $true

##Creates new entry for a blocked sender or domain
New-TenantAllowBlockListItems -ListType Sender -Entries "$senderdomain" -Block -NoExpiration

##Creates new entry for a blocked URL
New-TenantAllowBlockListItems -ListType URL -Entries "$url" -Block -NoExpiration

##Creates new entry for a blocked file hash
New-TenantAllowBlockListItems -ListType FileHash -Entries "$hash" -Block -NoExpiration
