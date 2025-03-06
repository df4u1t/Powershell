param (
	[switch] $MaliciousDomain,
	[switch] $MaliciousURL,
	[switch] $MaliciousHash,
	[string] $SpoofedSender,
 	[string] $SpoofedSubnet
)

Set-ExecutionPolicy RemoteSigned

##Must have ExchangeOnlineManagement module already installed
Import-Module ExchangeOnlineManagement
Connect-ExchangeOnline -ShowProgress $true

##Creates new entry for a blocked sender or domain
if ($MaliciousDomain) {
    $content = Get-Content -Path C:\Temp\domains.txt
    foreach ($domain in $content) {
	    New-TenantAllowBlockListItems -ListType Sender -Entries $domain -Block -NoExpiration
    }
}

##Creates new entry for a blocked URL
if ($MaliciousURL) {
    $content = Get-Content -Path C:\Temp\urls.txt
    foreach ($url in $content) {
    	New-TenantAllowBlockListItems -ListType Url -Entries $url -Block -NoExpiration
    }
}

##Creates new entry for a blocked file hash
if ($MaliciousHash) {
    $content = Get-Content -Path C:\Temp\hashes.txt
    foreach ($hash in $content) {
    	New-TenantAllowBlockListItems -ListType FileHash -Entries $hash -Block -NoExpiration
    }
}

##Creates new entry for a spoofed sender
if ($SpoofedSender) {
	New-TenantAllowBlockListSpoofItems -Identity Default -Action Block -SendingInfrastructure $SpoofedSubnet -SpoofedUser $SpoofedSender -SpoofType External
}

##Disconnect from powershell session
Disconnect-ExchangeOnline -Confirm $false
