## Add entry to Windows Firewall rule
$ips = (Get-NetFirewallRule -DisplayName "@@_Inbound_ActiveResponse" | Get-NetFirewallAddressFilter).remoteaddress
$new_ips = @("change_me")
$merge = $ips + $new_ips
$merge = $merge | select -Unique | sort
Set-NetFirewallRule -DisplayName "@@Inbound_ActiveResponse" -RemoteAddress "$merge"
Set-NetFirewallRule -DisplayName "@@Outbound_ActiveResponse" -RemoteAddress "$merge"
