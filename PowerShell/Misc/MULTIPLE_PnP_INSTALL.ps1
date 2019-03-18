# Set-ExecutionPolicy Unrestricted
# Check if Package manage is installed

Uninstall-Module -Name SharePointPnPPowerShell2013 -ErrorAction SilentlyContinue
Uninstall-Module -Name SharePointPnPPowerShell2016 -ErrorAction SilentlyContinue
Uninstall-Module -Name SharePointPnPPowerShellOnline -ErrorAction SilentlyContinue
New-Item -ItemType Directory -Path C:\PnPPowershell -ErrorAction SilentlyContinue
Save-Module -Name SharePointPnPPowerShell2013 -Path C:\PnPPowershell
Save-Module -Name SharePointPnPPowerShell2016 -Path C:\PnPPowershell
Save-Module -Name SharePointPnPPowerShellOnline -Path C:\PnPPowershell

