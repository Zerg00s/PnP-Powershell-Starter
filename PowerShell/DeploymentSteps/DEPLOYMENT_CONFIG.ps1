$ErrorActionPreference = "Stop";

Clear-Host

if ($path -ne $null){
	Set-Location $path
	Write-Host $path
}


if($null -eq $TARGET_SITE_URL -or [String]::IsNullOrEmpty($TARGET_SITE_URL)){
    $TARGET_SITE_URL = Read-Host "Enter full site URL"
    $TARGET_SITE_URL = $TARGET_SITE_URL.Trim('/');

    if ($null -eq $TARGET_SITE_URL-or $TARGET_SITE_URL -eq ""){
	    exit
	    Throw "no URL supplied. Exiting the script"
    }
}

$done = $false
do{
    try{
        $credentials = Get-Credential -Message "Please enter Office 365 credentials"
        if ($null -ne $credentials){
            If ($CREATE_SITE_COLLECTION -eq $true) {
                Connect-PnPOnline -Url $("https://"+([uri]$TARGET_SITE_URL).Host) -Credentials $credentials
            }else{
                Connect-PnPOnline $TARGET_SITE_URL -Credentials $credentials
            }
            
        }else{
            Write-host "You've canceled the deployment process"
            break;
        }
    }
    catch [System.Net.WebException]{
        $ErrorMessage = $_.Exception.Message
        if($ErrorMessage -like "*SSL*"){
            Write-host "You've entered the wrong URL. cannot continue"
            break
        }else{
            Write-host "Credentials supplied didn't work. See the error below for more details" -ForegroundColor Yellow
            Write-Host $ErrorMessage -ForegroundColor Cyan
        }
    }
    Catch{
        # Write-host Deployment process was canceled -ForegroundColor Yellow
        $done = $true
        break
    }
    $done = $true;
} while($done -ne $true)

$web = Get-PnPWeb
$web.ServerRelativeUrl

Write-Host "Connected to the site:" $web.ServerRelativeUrl