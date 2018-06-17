function UploadFolder ([string]$sourceFolderPath, [string]$destinationFolder) {
  $destinationFolder = $destinationFolder.TrimEnd("/")
  $sourceFolderPath = (Get-Item $sourceFolderPath).FullName

  foreach ($file in Get-ChildItem $sourceFolderPath) {
    if ($file.PSIsContainer) {
      $folder = Resolve-PnPFolder -SiteRelativePath $destinationFolder"/"$file
      Write-host $folder.Name " folder created" -ForegroundColor Magenta
      UploadFolder $sourceFolderPath"\"$file $destinationFolder"/"$file

    }
    else {
      $file = Add-PnPFile -Path $file.FullName -Folder $destinationFolder
      Write-host $file.Name "uploaded" -ForegroundColor Green
    }
  }
}

$destFolder = "SiteAssets\Learning"
Write-Host $destFolder -ForegroundColor DarkMagenta
$sourceFolder = [System.IO.Path]::GetFullPath((Join-Path (pwd) "..\dist\"))
Write-Host $sourceFolder -ForegroundColor DarkMagenta
UploadFolder $sourceFolder $destFolder