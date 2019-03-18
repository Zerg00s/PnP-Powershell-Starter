# MIGRATE JSON TO SHAREPOINT
$list = Get-PnPList -Identity "Courses" -Include ItemCount
if ($list.ItemCount -eq 0) {
  Write-host Creating list items. Please, wait
  # schema: https://www.mockaroo.com/schemas/115529
  $courses = Get-Content -Raw -Path "DeploymentSteps\SeedData\Courses.json" | ConvertFrom-Json
  foreach ($course in $courses) {
    $hashTable = @{}
    $course.psobject.properties | ForEach-Object { $hashTable[$_.Name] = $_.Value }
    Add-PnPListItem -List "Courses" -Values $hashTable
  }
}

# REMOVE EXISTING ITEMS FROM SHAREPOINT LIST BEFORE DATA MIGRATION
$items = Get-PnPListItem -List "Migrated List" 
Write-host Cleaning Artefact Class Mapping list. Removing all old values if there are any
foreach($item in $items){
    Remove-PnPListItem -List "Migrated List" -Identity $item -Force
}

# MIGRATE CSV TO SHAREPOINT
$items = Import-CSV "SeedData\Migrated.csv" 
Write-host Creating list items. Please, wait
foreach($item in $items){
    $hashTable = @{}
    $item.psobject.properties | ForEach-Object { $hashTable[$_.Name] = $_.Value }
    $suppress = Add-PnPListItem -List "Migrated List"  -Values $hashTable 
}