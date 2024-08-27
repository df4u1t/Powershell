param (
	[switch] $MaliciousDomain,
	[switch] $MaliciousURL,
	[switch] $MaliciousHash
)

Set-ExecutionPolicy RemoteSigned

##Must have ExchangeOnlineManagement module already installed
Import-Module ExchangeOnlineManagement
Connect-ExchangeOnline -ShowProgress $true

if ($MaliciousDomain) {
##Creates new entry for a blocked sender or domain
	$senderdomain = Read-Host "Please enter the malicious sender or domain with quotations. You may enter more that one entry using a ','"
	New-TenantAllowBlockListItems -ListType Sender -Entries"$senderdomain" -Block -NoExpiration
}

if ($MaliciousURL) {
##Creates new entry for a blocked URL
	$url = Read-Host "Please enter the malicious url with quotations. You may enter more that one entry using a ','"
	New-TenantAllowBlockListItems -ListType Url -Entries"$url" -Block -NoExpiration
}

if ($MaliciousHash) {
	$hash = Read-Host "Please enter the malicious file hash with quotations. You may enter more that one entry using a ','"
##Creates new entry for a blocked file hash
	New-TenantAllowBlockListItems -ListType FileHash -Entries"$hash" -Block -NoExpiration
}

##Disconnect from powershell session
Disconnect-ExchangeOnline
