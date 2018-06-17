$ErrorActionPreference = "Stop";

# USAGE:  LoadPnPModule(2013) or LoadPnPModule(Online)
Function LoadPnPModule($version) {
  $PnPModuleRootPath = "C:\PnPPowershell\SharePointPnPPowerShell" + $version
  $dir = Get-Item -Path $PnPModuleRootPath
  $dirName = (Get-ChildItem $dir)[0].FullName
  $FullModulePath = (Get-ChildItem $dirName -Filter "*.psd1").FullName
  Import-Module $FullModulePath
}

if ($path -ne $null) {
  Set-Location $path
  Write-Host $path
}
Import-Module $PSScriptRoot\..\Utils\PasswordVault.psm1
Clear-Host
if (Test-Path $PSScriptRoot\..\..\config\private.json) {
  $privateConfig = Get-Content -Raw -Path $PSScriptRoot\..\..\config\private.json | ConvertFrom-Json
  $TARGET_SITE_URL = $privateConfig.siteUrl
  $uri = [System.Uri]$TARGET_SITE_URL
  $SERVER_RELATIVE_WEB = $uri.AbsolutePath

  if ($TARGET_SITE_URL.Contains(".sharepoint.com") ) {
    $USER_LOGIN = $privateConfig.username
  }
  else {
    $USER_LOGIN = $privateConfig.domain + "\" + $privateConfig.username
  }
}
else {
  Write-host -ForegroundColor red "private.json is missing. run 'gulp config'" to configure connection to SharePoint
  return
}

Write-host -ForegroundColor Yellow User login: $USER_LOGIN

Try {
  $credential = Get-VaultCredential $USER_LOGIN -Resolve
}
catch {}

if ($credential -eq $null) {
  Add-VaultCredential -Resource $USER_LOGIN -UserName $USER_LOGIN
}

$credential = Get-VaultCredential $USER_LOGIN -Resolve
$USER_PASSWORD = $credential.password

if ($USER_PASSWORD -ne $null -and $USER_PASSWORD -ne "") {
  $USER_PASSWORD = $USER_PASSWORD  | ConvertTo-SecureString -asPlainText -Force
  $credentials = New-Object System.Management.Automation.PSCredential ($USER_LOGIN, $USER_PASSWORD)
  LoadPnPModule("Online")
  Connect-PnPOnline $TARGET_SITE_URL -Credentials $credentials
}
else {
  if ($TARGET_SITE_URL.Contains("2016") ) {
    LoadPnPModule("2016")
  }
  else {
    LoadPnPModule("2013")
  }

  Connect-PnPOnline $TARGET_SITE_URL -CurrentCredentials
}

$web = Get-PnPWeb

Write-Host -ForegroundColor Green "Connected to the site:" $web.Url