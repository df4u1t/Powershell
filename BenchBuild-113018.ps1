If (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator))
{
  # Relaunch as an elevated process:
  Start-Process powershell.exe "-File",('"{0}"' -f $MyInvocation.MyCommand.Path) -Verb RunAs
  exit
}

$WorkDir = "C:\usr"
$AdobeUrl = 'https://admdownload.adobe.com/bin/live/readerdc_en_xa_crd_install.exe'
$ChromeUrl = "http://dl.google.com/chrome/install/375.126/chrome_installer.exe"
$ODTUrl = "\\agj-bnap\ODT"
$Creds = Get-Credential

mkdir $WorkDir
Set-ItemProperty -Path HKLM:\SYSTEM\CurrentControlSet\Services\LanmanWorkstation\Parameters -Name AllowInsecureGuestAuth -Value 1

#build file name
$AdobeSetup = "readerdc_en_xa_crd_install.exe"
$ChromeSetup = "chrome_installer.exe"
$ODTSetup = "setup.exe"
$ODTConfig = $ODTUrl + "\configuration-Office365-x64.xml"
$ODTArgs = "/configure " + $ODTConfig
$ODTPath = Join-Path -Path $ODTUrl -ChildPath $ODTSetup

#download file
Invoke-WebRequest -Uri $AdobeUrl -OutFile $WorkDir\$AdobeSetup
Invoke-WebRequest -Uri $ChromeUrl -OutFile $WorkDir\$ChromeSetup

#install file
Start-Process -FilePath "$WorkDir\$AdobeSetup"
Wait-Process -Name "reader*"
Start-Process -FilePath "$WorkDir\$ChromeSetup"
Wait-Process -Name "chrome*"
Start-Process -WorkingDirectory "$WorkDir" -FilePath "$ODTPath" -ArgumentList "$ODTArgs"
Wait-Process -Name "setup.exe"

#disables power management on all NICs and sets power options to never sleep on battery and while plugged in
Disable-NetAdapterPowerManagement -Name '*'
powercfg /change standby-timeout-ac 0
powercfg /change standby-timeout-dc 0
powercfg /change hibernate-timeout-ac 0
powercfg /change hibernate-timeout-dc 0

$PCName = Read-Host "Enter new PC name: "
Rename-Computer -NewName $PCName
sleep 5
shutdown /r /t 0
