#Profile Transfer by JP Russell
#08/15/2019
#Runs elevated PowerShell to copy all user profile data using Robocopy

#Checks to see if PowerShell is running as Administrator; if not, starts elevated PowerShell process.
if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) { Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs; exit }

#Specifies Source, Destination, and Working Directory Paths
$source = Read-Host "Please enter the source directory for the Users data: (ex. d:\users\jdoe)"
$destination = Read-Host "Please enter the destination directory to store the Users data: (ex. c:\usr\jdoe)"
$user = Read-Host "Please enter the username you're copying data from: (ex. jdoe)"
$drive = Read-Host "Please enter the drive letter the source OS is installed on: (ex. D:\)"
$pwd = 'c:\temp'
#$regHKLM = 'HKLM\TempHive'
mkdir $pwd

#Starts Robocopy to transfer all attributes, copies timestamps to destination, and outputs a log to the working directory.
robocopy $source $destination /XD 'AppData' 'Application Data' /E /ZB /DCOPY:T /COPYALL /MT:128 /R:0 /W:0 /V /TEE /LOG:$pwd\Robocopy.log
wait-process -name "robocopy.exe"
robocopy $source + '\AppData\Local\Google' $destination + '\AppData\Local\Google' /E /ZB /DCOPY:T /COPYALL /MT:128 /R:0 /W:0 /V /TEE /LOG:$pwd\Robocopy.log
wait-process -name "robocopy.exe"
robocopy $source + '\AppData\Local\Microsoft\Office' $destination + '\AppData\Local\Microsoft\Office' /E /ZB /DCOPY:T /COPYALL /MT:128 /R:0 /W:0 /V /TEE /LOG:$pwd\Robocopy.log
wait-process -name "robocopy.exe"
robocopy $source + '\AppData\Local\Microsoft\Outlook' $destination + '\AppData\Local\Microsoft\Outlook' /E /ZB /DCOPY:T /COPYALL /MT:128 /R:0 /W:0 /V /TEE /LOG:$pwd\Robocopy.log
wait-process -name "robocopy.exe"
robocopy $source + '\AppData\Roaming\Microsoft\Windows\Themes' $destination + '\AppData\Roaming\Microsoft\Windows\Themes' /E /ZB /DCOPY:T /COPYALL /MT:128 /R:0 /W:0 /V /TEE /LOG:$pwd\Robocopy.log
wait-process -name "robocopy.exe"

$SID = Get-WmiObject -Class win32_userAccount -Filter "name = '$user'" | foreach { $_.SID }
#reg load $regHKLM $drive + 'Windows\System32\config\SOFTWARE'
reg export $regHKLM + '\Microsoft\Windows NT\CurrentVersion\ProfileList\' + $SID $destination + '\user.reg'
#reg import $destination + '\user.reg'
