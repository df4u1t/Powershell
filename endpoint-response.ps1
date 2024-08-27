param (
	[switch] $MaliciousRegKey,
	[switch] $MaliciousIP,
	[switch] $MaliciousItem,
	[switch] $MaliciousTask,
	[switch] $MaliciousService,
	[switch] $AddNullRoute,
	[switch] $DeleteNullRoute,
	[switch] $AddFirewallRule,
	[switch] $DisableFirewallRule
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
	$new_ips = @(Read-Host "Enter the malicious IP you want to block.")
	$merge = $ips + $new_ips
	$merge = $merge | select -Unique | sort
	Set-NetFirewallRule -DisplayName "@@Inbound_ActiveResponse" -RemoteAddress "$merge"
	Set-NetFirewallRule -DisplayName "@@Outbound_ActiveResponse" -RemoteAddress "$merge"
}

## Forcefully deletes path and all recursive items.
if ($MaliciousItem) {
	$path = Read-Host "Enter the path or item you wish to delete."
	Remove-Item -recurse -force $path
}

## Deletes a malicious Scheduled Task.
if ($MaliciousTask) {
	$malicious_task = Read-Host "Enter the malicious task name you wish to delete."
	Unregister-ScheduledTask -TaskName $malicious_task -Confirm:$false
}

## Stops and deletes a malicious service.
if ($MaliciousService) {
	$malicious_service = Read-Host "Enter the name of the malicious service you wish to delete."
	Stop-Service -Name "$malicious_service"
	Remove-Service -Name "$malicious_service"
}

## Creates a null route for the specified IP.
if ($AddNullRoute) {
	$nullroute = Read-Host "Enter the IP you want to create a null route for."
	route add $nullroute 255.255.255.255 169.169.169.169 if 1
}

## Deletes the IP from the null route.
if ($DeleteNullRoute) {
	$nullroute = Read-Host "Enter the IP you want to delete from the null route."
	route delete $nullroute 255.255.255.255 169.169.169.169 if 1
}

## Creates ingress and egress Windows Firewall rules, use this option if the Firewall rules do not exist.
if ($AddFirewallRule) {
	$malicious_IP = Read-Host "Enter the malicious IP you wish to block."
	New-NetFirewallRule -DisplayName "@@_Inbound_ActiveResponse" -Direction Inbound -Action Block -RemoteAddress "$malicious_IP"
	New-NetFirewallRule -DisplayName "@@_Outbound_ActiveResponse" -Direction Outbound -Action Block -RemoteAddress "$malicious_IP"
}

## Disables the ingress and egress Windows Firewall rules for active response.
if ($DisableFirewallRule) {
	Set-NetFirewallRule -DisplayName "@@Inbound_ActiveResponse" -Enabled False
	Set-NetFirewallRule -DisplayName "@@Outbound_ActiveResponse" -Enabled False
}
