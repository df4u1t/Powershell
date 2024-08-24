## Disable Active Response Windows Firewall Rule
Set-NetFirewallRule -DisplayName "@@Inbound_ActiveResponse" -Enabled False
Set-NetFirewallRule -DisplayName "@@Outbound_ActiveResponse" -Enabled False
