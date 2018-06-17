# param (
#     [string]$LookupFieldXml
# )

# $content = Get-Content $LookupFieldXml
# $content = [string]$content

# $xmlDoc = New-Object System.Xml.XmlDocument
# $xmlDoc.LoadXml($content)

# [System.Xml.XmlElement]$root = $xmlDoc.DocumentElement

# $listName = $root.List

# if ($listName -ne $null -and $listName -ne "")
# {
#     $list = Get-PnpList -Identity $listName
#     $listId = $list.Id
#     $root.List = "{$listid}"
#     Write-Output $xmlDoc.InnerXml
# }
# else
# {
#     Write-Output $null
# }