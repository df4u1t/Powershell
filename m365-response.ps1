param (
	[switch] $MaliciousDomain,
	[switch] $MaliciousURL,
	[switch] $MaliciousHash,
	[switch] $SpoofedSender
)

Set-ExecutionPolicy RemoteSigned

##Must have ExchangeOnlineManagement module already installed
Import-Module ExchangeOnlineManagement
Connect-ExchangeOnline -ShowProgress $true

##Creates new entry for a blocked sender or domain
if ($MaliciousDomain) {
	$senderdomain = Read-Host "Please enter the malicious sender or domain."
	New-TenantAllowBlockListItems -ListType Sender -Entries $senderdomain -Block -NoExpiration
}

##Creates new entry for a blocked URL
if ($MaliciousURL) {
	$url = Read-Host "Please enter the malicious url."
	New-TenantAllowBlockListItems -ListType Url -Entries $url -Block -NoExpiration
}

##Creates new entry for a blocked file hash
if ($MaliciousHash) {
	$hash = Read-Host "Please enter the malicious file hash."
	New-TenantAllowBlockListItems -ListType FileHash -Entries $hash -Block -NoExpiration
}

##Creates new entry for a spoofed sender
if ($SpoofedSender) {
	$spoofeduser = Read-Host "Enter the spoofed user's email address."
	$sourcesubnet = Read-Host "Enter the source malicious subnet."
	New-TenantAllowBlockListSpoofItems -Identity Default -Action Block -SendingInfrastructure $sourcesubnet -SpoofedUser $spoofeduser -SpoofType External
}

##Disconnect from powershell session
Disconnect-ExchangeOnline
