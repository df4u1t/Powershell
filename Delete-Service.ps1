## Stops and Deletes a malicious service
Stop-Service -Name "$malicious_service"
Remove-Service -Name "$malicious_service"
