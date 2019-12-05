#Create by JP Russell
#Repairs Windows 10 Built-in apps
#Created 12/5/2019

Get-AppxPackage -allusers | foreach {Add-AppxPackage -register "$($_.InstallLocation)\appxmanifest.xml" -DisableDevelopmentMode}
