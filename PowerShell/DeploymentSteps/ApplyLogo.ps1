$logoUrl = $web.Url + "/SiteAssets/Learning/images/react.png"
Write-host $logoUrl
Set-PnpWeb -Web $web.Id -SiteLogoUrl $logoUrl