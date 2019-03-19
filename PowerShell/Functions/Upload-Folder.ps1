<#
.DESCRIPTION
  Uploads an entire folder recursively from SourceFolderPath to a SharePoint destination
.EXAMPLE
  PS C:\> Upload-Folder -SourceFolderPath C:\dist -DestinationFolder SiteAssets
  Uploads a dist folder from C: drive to the SharePoint's Site Assets library

    PS C:\> Upload-Folder C:\dist SiteAssets
  Uploads a dist folder from C: drive to the SharePoint's Site Assets library

#>
function Upload-Folder () {
  Param(
		[Parameter(Mandatory=$true,Position=1)] [String]$SourceFolderPath,
		[Parameter(Mandatory=$true,Position=2)] [String]$DestinationFolder
	)
  $DestinationFolder = $DestinationFolder.TrimEnd("/")
  $SourceFolderPath = (Get-Item $SourceFolderPath).FullName

  foreach ($file in Get-ChildItem $SourceFolderPath) {
    if ($file.PSIsContainer) {
      $folder = Resolve-PnPFolder -SiteRelativePath $DestinationFolder"/"$file
      Write-host $folder.Name " folder created" -ForegroundColor Magenta
      Upload-Folder $SourceFolderPath"\"$file $DestinationFolder"/"$file

    }
    else {
      $file = Add-PnPFile -Path $file.FullName -Folder $DestinationFolder
      Write-host $file.Name "uploaded" -ForegroundColor Green
    }
  }
}