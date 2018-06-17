function CreateGroup($GroupName, $Description){
  $Group= Get-PnPGroup  $GroupName -ErrorAction Ignore
  if($Group -eq $null){
      $Group = New-PnPGroup -Title $GroupName -Owner $credentials.UserName -Description $Description
  }
}

CreateGroup "Learning Centre Admins" "Members of this group have full control to the Learning Centre"
CreateGroup "Learning Centre Content Managers" "Members of this group can create and delete courses"
CreateGroup "Learning Centre Visitors" "Members of this group can request view courses and request learning opportunities"