$list = Get-PnPList -Identity "Courses" -Include ItemCount
if ($list.ItemCount -eq 0) {
  # schema: https://www.mockaroo.com/schemas/115529
  $courses = Get-Content -Raw -Path "DeploymentSteps\TestData\Dental Courses.json" | ConvertFrom-Json
  foreach ($course in $courses) {
    $hashTable = @{}
    $course.psobject.properties | ForEach-Object { $hashTable[$_.Name] = $_.Value }
    Add-PnPListItem -List "Courses" -Values $hashTable
  }
}


$list = Get-PnPList -Identity "Comments" -Include ItemCount
if ($list.ItemCount -eq 0) {
  # schema: https://www.mockaroo.com/schemas/115531
  $comments = Get-Content -Raw -Path "DeploymentSteps\TestData\Course Comments.json" | ConvertFrom-Json
  foreach ($comment in $comments) {
    $hashTable = @{}
    $comment.psobject.properties | ForEach-Object { $hashTable[$_.Name] = $_.Value }
    Add-PnPListItem -List "Comments" -Values $hashTable
  }
}
