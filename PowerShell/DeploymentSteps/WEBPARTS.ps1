

$ItemNewFormUrl = $SERVER_RELATIVE_WEB + "/Lists/DutyInspectorReports/NewForm.aspx"
$ItemEditFormUrl = $SERVER_RELATIVE_WEB + "/Lists/DutyInspectorReports/EditForm.aspx"
$ItemDispFormUrl = $SERVER_RELATIVE_WEB + "/Lists/DutyInspectorReports/DispForm.aspx"
$ItemFormCewpLink = $TARGET_SITE_URL + "/_catalogs/masterpage/DutyInspectorList/webparts/newform.cewp.html"

$MontlyReportPageUrl = $SERVER_RELATIVE_WEB + "/SitePages/MonthlyReport.aspx"
$MonthlyReportCewpLink = $TARGET_SITE_URL + "/_catalogs/masterpage/DutyInspectorList/webparts/monthlyreport.cewp.html"


Remove-PnPWebPart -Title $WebPartTitle -ServerRelativePageUrl $ItemNewFormUrl
Remove-PnPWebPart -Title $WebPartTitle -ServerRelativePageUrl $ItemEditFormUrl
Remove-PnPWebPart -Title $WebPartTitle -ServerRelativePageUrl $ItemDispFormUrl

Add-CewpToWebPartPage -ServerRelativePageUrl $ItemNewFormUrl  -ZoneId Main -ZoneIndex 0 -WebPartTitle $WebPartTitle -FullCewpHtmlUrl $ItemFormCewpLink
Add-CewpToWebPartPage -ServerRelativePageUrl $ItemEditFormUrl -ZoneId Main -ZoneIndex 0 -WebPartTitle $WebPartTitle -FullCewpHtmlUrl $ItemFormCewpLink
Add-CewpToWebPartPage -ServerRelativePageUrl $ItemDispFormUrl -ZoneId Main -ZoneIndex 0 -WebPartTitle $WebPartTitle -FullCewpHtmlUrl $ItemFormCewpLink

#Hide OOB Form web parts
$webparts = Get-PnPWebPart -ServerRelativePageUrl $ItemNewFormUrl
$OOB_Form_Webpart = $webparts | Where-Object {$_.WebPart.Title -eq ""}
Set-PnPWebPartProperty -ServerRelativePageUrl $ItemNewFormUrl -Identity $OOB_Form_Webpart.Id -Key Hidden -Value $TRUE

$webparts = Get-PnPWebPart -ServerRelativePageUrl $ItemEditFormUrl
$OOB_Form_Webpart = $webparts | Where-Object {$_.WebPart.Title -eq ""}
Set-PnPWebPartProperty -ServerRelativePageUrl $ItemEditFormUrl -Identity $OOB_Form_Webpart.Id -Key Hidden -Value $TRUE

$webparts = Get-PnPWebPart -ServerRelativePageUrl $ItemDispFormUrl
$OOB_Form_Webpart = $webparts | Where-Object {$_.WebPart.Title -eq ""}
Set-PnPWebPartProperty -ServerRelativePageUrl $ItemDispFormUrl -Identity $OOB_Form_Webpart.Id -Key Hidden -Value $TRUE

Add-PnPWikiPage -PageUrl $MontlyReportPageUrl -Layout 3 -ErrorAction Ignore
Add-CewpToWikiPage -ServerRelativePageUrl $MontlyReportPageUrl -RowIndex 1 -ColumnIndex 1 -WebPartTitle $WebPartTitle -FullCewpHtmlUrl $MonthlyReportCewpLink
