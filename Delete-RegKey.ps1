## Deletes malicious Registery Key
Remove-ItemProperty -Path "$registery_path" -Name "$malicious_key"
