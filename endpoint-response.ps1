param (
	[switch] $MaliciousRegKey,
	[switch] $MaliciousIP,
	[switch] $MaliciousItem,
	[switch] $MaliciousTask,
	[switch] $MaliciousService,
	[switch] $AddNullRoute,
	[switch] $AddFirewallRule
)


## Deletes malicious Registery Key
if ($MaliciousRegKey) {
	$malicious_key = Read-Host "Enter the malicious registery key you want to delete."
	$registery_path = Read-Host "Enter the registery path the malicious key is located."
	Remove-ItemProperty -Path "$registery_path" -Name "$malicious_key"
}

## Adds entry to Windows Firewall rule
if ($MaliciousIP) {
	$ips = (Get-NetFirewallRule -DisplayName "@@_Inbound_ActiveResponse" | Get-NetFirewallAddressFilter).remoteaddress
	$new_ips = @(Read-Host "Please enter the malicious IP you want to block.")
	$merge = $ips + $new_ips
	$merge = $merge | select -Unique | sort
	Set-NetFirewallRule -DisplayName "@@Inbound_ActiveResponse" -RemoteAddress "$merge"
	Set-NetFirewallRule -DisplayName "@@Outbound_ActiveResponse" -RemoteAddress "$merge"
}

if ($MaliciousItem) {
	
}

if ($MaliciousTask) {
	
}

if ($MaliciousService) {
	
}

## Creates a null route for the specified IP.
if ($AddNullRoute) {
	$nullroute = Read-Host "Please enter the IP you want to create a null route for."
	route add $nullroute 255.255.255.255 169.169.169.169 if 1
}

## Creates ingress and egress Windows Firewall rules, use this option if the Firewall rules do not exist.
if ($AddFirewallRule) {
	$malicious_IP = Read-Host "Please enter the malicious IP you wish to block."
	New-NetFirewallRule -DisplayName "@@_Inbound_ActiveResponse" -Direction Inbound -Action Block -RemoteAddress "$malicious_IP"
	New-NetFirewallRule -DisplayName "@@_Outbound_ActiveResponse" -Direction Outbound -Action Block -RemoteAddress "$malicious_IP"
}
