# PREPARE THE TEST SITES. THIS SCRIPT IS ONLY USED FOR THE DEV AND TESTING PURPOSES
$credentials = Get-Credential -Message "Please enter Office 365 credentials"
Connect-PnPOnline  -Url https://tests.sharepoint.com       -Credentials $credentials
Connect-SPOService -Url https://zergs-admin.sharepoint.com -Credential $credentials

# Removing all junk sites:
$sites =  Get-PnPTenantSite
$junkSites = $sites | Where-Object Url -Like "*Delete*"
for($i = 0; $i -lt $junkSites.Count; $i++){
    Remove-PnPTenantSite -Url $junkSites[$i].Url -Force
    Remove-SPODeletedSite -Identity $junkSites[$i].Url -NoWait -Confirm:$false
}

# Creating site collections:
$testSites = @(
    "https://tests.sharepoint.com/teams/DeleteA",
    "https://tests.sharepoint.com/teams/DeleteB",
    "https://tests.sharepoint.com/teams/DeleteC",
    "https://tests.sharepoint.com/teams/DeleteD"
    "https://tests.sharepoint.com/teams/DeleteE",
    "https://tests.sharepoint.com/teams/DeleteF",
    "https://tests.sharepoint.com/teams/DeleteG",
    "https://tests.sharepoint.com/teams/DeleteH"
)

for($i=0;$i -lt $testSites.Count; $i++){
    $TARGET_SITE_URL = $testSites[$i]
    Write-Host Please wait. Creating site collection $TARGET_SITE_URL -ForegroundColor Cyan
    New-PnPTenantSite -Title "Test Site" -TimeZone 10 -Url $TARGET_SITE_URL -Owner $($credentials.UserName) -Template "STS#0"
}