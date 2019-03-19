$ErrorActionPreference = "Stop";

<#
.DESCRIPTION
    Connects to a specified site collection, but also returns a second connection 
    to the SharePoint tenant site
.EXAMPLE
    Connect-SharePoint -Url https://Contoso.sharepoint.com -Account admin@contoso.onmicrosoft.com -Password "P@ssword"
.EXAMPLE
    $AdminConnection = Connect-SharePoint "https://Contoso.sharepoint.com" "admin@contoso.onmicrosoft.com" "P@ssword"
.EXAMPLE
    $AdminConnection = Connect-SharePoint "https://Contoso.sharepoint.com" -WebLogin
.PARAMETER TARGET_SITE_URL
    URL of a site collection you want connect to
.PARAMETER Account
    admin@contoso.onmicrosoft.com
.PARAMETER Password
    password as a string
.NOTES
    Also populates $global:tenantUrl variable
#>
function Connect-SharePoint() {
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory = $true, Position = 0)]
		[ValidateNotNullOrEmpty()]
        [String]$TARGET_SITE_URL,

        [Parameter(Mandatory = $true, Position = 1)]
		[ValidateNotNullOrEmpty()]
        [String]$Account,

        [Parameter(Mandatory = $true, Position = 2)]
		[ValidateNotNullOrEmpty()]
        [String]$Password,

        [switch] $WebLogin
    )

    $global:tenantUrl = "https://" + (([System.Uri]$TARGET_SITE_URL).Host -replace '.sharepoint.com') + "-admin.sharepoint.com"
    $TARGET_SITE_URL = $TARGET_SITE_URL.TrimEnd('/')
    Log-Info "Connecting to $TARGET_SITE_URL"
    $credentials = $null
    $AdminConnection = $null;
    if ($WebLogin) {
        Log-Info "Using Web login to access $TARGET_SITE_URL"
        $AdminConnection = Connect-PnPOnline -Url $global:tenantUrl -UseWebLogin -ReturnConnection
        Connect-PnPOnline -Url $Url -UseWebLogin
    }
    else {
        if ($Account -eq "") {
            $credentials = Get-Credential -Message "SharePoint tenant administrator account"
        }
        else {
            $securePass = ConvertTo-SecureString -String $Password -AsPlainText -Force
            $credentials = new-object -typename System.Management.Automation.PSCredential -argumentlist $Account, $securePass
        }
        $AdminConnection = Connect-PnPOnline -Url $global:tenantUrl -Credentials $credentials -ReturnConnection
        Connect-PnPOnline -Url $Url -Credentials $credentials
    }

    return $AdminConnection

}
