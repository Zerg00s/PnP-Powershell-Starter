function Create-Group($GroupName, $Description){
  $Group= Get-PnPGroup  $GroupName -ErrorAction Ignore
  if($Group -eq $null){
      $Group = New-PnPGroup -Title $GroupName -Owner $credentials.UserName -Description $Description
  }
}