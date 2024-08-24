## Create new active response windows firewall rule
New-NetFirewallRule -DisplayName "@@_Inbound_ActiveResponse" -Direction Inbound -Action Block -RemoteAddress "$malicious_IP"
New-NetFirewallRule -DisplayName "@@_Outbound_ActiveResponse" -Direction Outbound -Action Block -RemoteAddress "$malicious_IP"
