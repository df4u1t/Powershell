#Profile Transfer by JP Russell
#08/15/2019
#Runs elevated PowerShell to copy all user profile data using Robocopy

#Checks to see if PowerShell is running as Administrator; if not, starts elevated PowerShell process.
if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) { Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs; exit }

#Specifies Source, Destination, and Working Directory Paths
$source = Read-Host "Please enter the source directory for the Users data: (ex. d:\users\jdoe)"
$destination = Read-Host "Please enter the destination directory to store the Users data: (ex. c:\usr\jdoe)"
$pwd = 'c:\temp'
mkdir $pwd

#Starts Robocopy to transfer all attributes, copies timestamps to destination, and outputs a log to the working directory.
robocopy $source $destination /XD 'AppData' 'Application Data' /E /ZB /DCOPY:T /COPYALL /MT:128 /R:0 /W:0 /V /TEE /LOG:$pwd\Robocopy.log
