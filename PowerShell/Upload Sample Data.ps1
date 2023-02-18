$items = Import-CSV "15000.csv" 
$SiteUrl = "https://contoso.sharepoint.com/sites/sandbox"
$ListTitle = "Courses"

# In this code, a new batch is created before the loop starts and the items are added to the batch inside the loop. 
# If the number of items added to the batch reaches 100, the batch is invoked and a new batch is created. 
# At the end of the loop, if there are still unprocessed items in the batch, they are added by invoking the batch again.

Connect-PnPOnline -Url $SiteUrl -UseWebLogin

$batch = New-PnPBatch
$count = 0
foreach($item in $items){
    $count++
    $hashTable = @{}
    $item.psobject.properties | ForEach-Object { $hashTable[$_.Name] = $_.Value }
    Add-PnPListItem -List $ListTitle -Values $hashTable -Batch $batch

    if ($count % 100 -eq 0) {
        Invoke-PnPBatch -Batch $batch
        $batch = New-PnPBatch
    }
}

# Execute the last batch that is less than 100 items:
if ($batch.Actions.Count -gt 0) {
    Invoke-PnPBatch -Batch $batch
}



