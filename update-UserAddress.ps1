#Sets variables for the street address and state.
$StreetAddress = "CHANGEME"
$state = "CHANGEME"

#Sets variable for the zip code and formats the string to an EDM String.
$zipCode = "CHANGEME"
$edmZipCode = "'$zipCode'"

#Sets variable for the file containing the UPNs for all the users.
$content = Get-Content -Path C:\Temp\upn.txt

#Connects to the MS Graph API with read/write access for users.
Connect-MgGraph -Scopes "User.ReadWrite.All"

#Loops thru the UPN.txt file and updates the address and zip code for each entry.
foreach ($upn in $content) {
	Update-MgUser -UserID $upn -StreetAddress $StreetAddress -PostalCode $edmZipCode -State $state
}

#Disconnects from the MS Graph API
Disconnect-MgGraph
