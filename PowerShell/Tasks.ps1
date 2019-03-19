 param (
    [string]$Path
 )

 Write-Host $Path -ForegroundColor Green
. .\DeploymentSteps\DEPLOYMENT_CONFIG.ps1
If ($CREATE_SITE_COLLECTION -eq $true) {    
    . .\DeploymentSteps\ENSURE_SITE_COLLECTION_EXISTS.ps1
}


#-----------------------------------------------------------------------
# Every *.ps1 file contained in the Functions folder
#-----------------------------------------------------------------------
Get-ChildItem -Path "Functions\*.ps1" -Recurse | ForEach-Object {
    . $_.FullName 
}


. .\DeploymentSteps\DEPLOY_LISTS_AND_FIELDS.ps1
. .\DeploymentSteps\ADD_TEST_DATA.ps1
# . .\DeploymentSteps\DEPLOY_GROUPS.ps1
# . .\DeploymentSteps\DEPLOY_WEBPARTS.ps1
# . .\DeploymentSteps\UploadFolder.ps1
# . .\DeploymentSteps\ApplyLogo.ps1

Write-Host [Success] All scripts finished with no errors -ForegroundColor Green