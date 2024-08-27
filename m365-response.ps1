param (
	[string] $MaliciousDomain,
	[string] $MaliciousURL,
	[string] $MaliciousHash,
	[string] $SpoofedSender,
 	[string] $SpoofedSubnet
)

Set-ExecutionPolicy RemoteSigned

##Must have ExchangeOnlineManagement module already installed
Import-Module ExchangeOnlineManagement
Connect-ExchangeOnline -ShowProgress $true

##Creates new entry for a blocked sender or domain
if ($MaliciousDomain) {
	New-TenantAllowBlockListItems -ListType Sender -Entries $MaliciousDomain -Block -NoExpiration
}

##Creates new entry for a blocked URL
if ($MaliciousURL) {
	New-TenantAllowBlockListItems -ListType Url -Entries $MaliciousURL -Block -NoExpiration
}

##Creates new entry for a blocked file hash
if ($MaliciousHash) {
	New-TenantAllowBlockListItems -ListType FileHash -Entries $MaliciousHash -Block -NoExpiration
}

##Creates new entry for a spoofed sender
if ($SpoofedSender) {
	New-TenantAllowBlockListSpoofItems -Identity Default -Action Block -SendingInfrastructure $SpoofedSubnet -SpoofedUser $SpoofedSender -SpoofType External
}

##Disconnect from powershell session
Disconnect-ExchangeOnline
