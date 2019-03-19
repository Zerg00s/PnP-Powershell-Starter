$WebPartTitle = "CEWP"
$ErrorActionPreference = "Stop";

function Add-CewpToWikiPage(){
	Param(
		[Parameter(Mandatory=$true)] $ServerRelativePageUrl,
		[Parameter(Mandatory=$true)] $RowIndex,
		[Parameter(Mandatory=$true)] $ColumnIndex,
		[Parameter(Mandatory=$true)] $WebPartTitle,
		[Parameter(Mandatory=$true)] $FullCewpHtmlUrl
	)

	$webpart = "<?xml version='1.0' encoding='utf-8'?>
	<WebPart xmlns:xsd='http://www.w3.org/2001/XMLSchema' xmlns:xsi='http://www.w3.org/2001/XMLSchema-instance' xmlns='http://schemas.microsoft.com/WebPart/v2'>
	  <Title>" + $WebPartTitle + "</Title>
	  <FrameType>None</FrameType>
	  <Description />
	  <IsIncluded>true</IsIncluded>
	  <PartOrder>0</PartOrder>
	  <FrameState>Normal</FrameState>s
	  <Height />
	  <Width />
	  <ChromeType>None</ChromeType>
	  <AllowRemove>true</AllowRemove>
	  <AllowZoneChange>true</AllowZoneChange>
	  <AllowMinimize>true</AllowMinimize>
	  <AllowConnect>true</AllowConnect>
	  <AllowEdit>true</AllowEdit>
	  <AllowHide>true</AllowHide>
	  <IsVisible>true</IsVisible>
	  <DetailLink />
	  <HelpLink />
	  <HelpMode>Modeless</HelpMode>
	  <Dir>Default</Dir>
	  <PartImageSmall />
	  <MissingAssembly>Cannot import this Web Part.</MissingAssembly>
	  <PartImageLarge>/_layouts/15/images/mscontl.gif</PartImageLarge>
	  <IsIncludedFilter />
	  <ContentLink>" + $FullCewpHtmlUrl + "</ContentLink>
	  <Assembly>Microsoft.SharePoint, Version=16.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c</Assembly>
	  <TypeName>Microsoft.SharePoint.WebPartPages.ContentEditorWebPart</TypeName>
	  <ContentLink xmlns='http://schemas.microsoft.com/WebPart/v2/ContentEditor'>" + $FullCewpHtmlUrl + "</ContentLink>
	  <Content xmlns='http://schemas.microsoft.com/WebPart/v2/ContentEditor' />
	  <PartStorage xmlns='http://schemas.microsoft.com/WebPart/v2/ContentEditor' />
	</WebPart>"

	Add-PnPWebPartToWikiPage -ServerRelativePageUrl $ServerRelativePageUrl -XML $webpart -Row $RowIndex -Column $ColumnIndex
}

function Add-CewpToWebPartPage(){
	Param(
		[Parameter(Mandatory=$true)] $ServerRelativePageUrl,
		[Parameter(Mandatory=$true)] $ZoneId,
		[Parameter(Mandatory=$true)] $ZoneIndex,
		[Parameter(Mandatory=$true)] $WebPartTitle,
		[Parameter(Mandatory=$true)] $FullCewpHtmlUrl
	)

	$webpart = "<?xml version='1.0' encoding='utf-8'?>
	<WebPart xmlns:xsd='http://www.w3.org/2001/XMLSchema' xmlns:xsi='http://www.w3.org/2001/XMLSchema-instance' xmlns='http://schemas.microsoft.com/WebPart/v2'>
	  <Title>" + $WebPartTitle + "</Title>
	  <FrameType>None</FrameType>
	  <Description />
	  <IsIncluded>true</IsIncluded>
	  <PartOrder>0</PartOrder>
	  <FrameState>Normal</FrameState>s
	  <Height />
	  <Width />
	  <ChromeType>None</ChromeType>
	  <AllowRemove>true</AllowRemove>
	  <AllowZoneChange>true</AllowZoneChange>
	  <AllowMinimize>true</AllowMinimize>
	  <AllowConnect>true</AllowConnect>
	  <AllowEdit>true</AllowEdit>
	  <AllowHide>true</AllowHide>
	  <IsVisible>true</IsVisible>
	  <DetailLink />
	  <HelpLink />
	  <HelpMode>Modeless</HelpMode>
	  <Dir>Default</Dir>
	  <PartImageSmall />
	  <MissingAssembly>Cannot import this Web Part.</MissingAssembly>
	  <PartImageLarge>/_layouts/15/images/mscontl.gif</PartImageLarge>
	  <IsIncludedFilter />
	  <ContentLink>" + $FullCewpHtmlUrl + "</ContentLink>
	  <Assembly>Microsoft.SharePoint, Version=16.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c</Assembly>
	  <TypeName>Microsoft.SharePoint.WebPartPages.ContentEditorWebPart</TypeName>
	  <ContentLink xmlns='http://schemas.microsoft.com/WebPart/v2/ContentEditor'>" + $FullCewpHtmlUrl + "</ContentLink>
	  <Content xmlns='http://schemas.microsoft.com/WebPart/v2/ContentEditor' />
	  <PartStorage xmlns='http://schemas.microsoft.com/WebPart/v2/ContentEditor' />
	</WebPart>"
	Add-PnPWebPartToWebPartPage -ServerRelativePageUrl $ServerRelativePageUrl -XML $webpart -ZoneId $ZoneId -ZoneIndex $ZoneIndex
}

