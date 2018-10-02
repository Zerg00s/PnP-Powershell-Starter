# THIS SCRIPT IS NOT USED SINCE SITE COLLECTION SHOULD ALREADY EXIST
$PmPortalSiteCollection = Get-PnPTenantSite -Url $TARGET_SITE_URL -ErrorAction SilentlyContinue
if($null -eq $PmPortalSiteCollection){
    Write-Host $TARGET_SITE_URL Does not exist. Creating...
    Write-Host Please wait. Creating site collection $TARGET_SITE_URL -ForegroundColor Cyan
    New-PnPTenantSite -Title "PM Portal" -TimeZone 10 -Url $TARGET_SITE_URL -Owner $($credentials.UserName) -Template STS#0 -Wait    
    $PmPortalSiteCollection = Get-PnPTenantSite -Url $TARGET_SITE_URL -ErrorAction SilentlyContinue
}else{
    Write-Host $PmPortalSiteCollection is null
}

Connect-PnPOnline -Url $TARGET_SITE_URL -Credentials $credentials