param (
	[switch] $MaliciousDomain,
	[switch] $MaliciousURL,
	[switch] $MaliciousHash
)

Set-ExecutionPolicy RemoteSigned

##Must have ExchangeOnlineManagement module already installed
Import-Module ExchangeOnlineManagement
Connect-ExchangeOnline -ShowProgress $true

##Sets items to be blocked. If more than one start each successive entry with a ,
$senderdomain = ""
$url = ""
$hash = ""

if ($MaliciousDomain) {
##Creates new entry for a blocked sender or domain
	New-TenantAllowBlockListItems -ListType Sender -Entries "$senderdomain" -Block -NoExpiration
}

if ($MaliciousURL) {
##Creates new entry for a blocked URL
	New-TenantAllowBlockListItems -ListType Url -Entries "$url" -Block -NoExpiration
}

if ($MaliciousHash) {
##Creates new entry for a blocked file hash
	New-TenantAllowBlockListItems -ListType FileHash -Entries "$hash" -Block -NoExpiration
}

##Disconnect from powershell session
Disconnect-ExchangeOnline
