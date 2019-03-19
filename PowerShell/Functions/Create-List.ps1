function Create-List($ListProps) {
  $NewList = Get-PnPList -Identity $ListProps.Title -Includes Fields
  if ($null -eq $NewList ) {
    Write-host Creating list $ListProps.Title
    New-PnPList -Title $ListProps.Title -Template GenericList -Url "Lists/$($ListProps.Name)"
    $NewList = Get-PnPList -Identity $ListProps.Title -Includes Fields
  }
  $NewList
}

function Create-Library($ListProps) {
  $NewList = Get-PnPList -Identity $ListProps.Title -Includes Fields
  if ($null -eq $NewList) {
    Write-host Creating list $ListProps.Title
    New-PnPList -Title $ListProps.Title -Template DocumentLibrary -Url "$($ListProps.Name)"
    $NewList = Get-PnPList -Identity $ListProps.Title -Includes Fields
  }
  $NewList
}

function Create-Field($NewFieldProps) {
  $NewField = ($NewFieldProps.List.Fields) | Where-Object {$_.InternalName -eq $NewFieldProps.Name}
  if ($null -eq $NewField) {
    Write-host Adding field $NewFieldProps.Name
    if ($NewFieldProps.Type -eq "Choice") {
      $NewField = Add-PnPField -List $ListProps.Title -DisplayName $NewFieldProps.Title -InternalName $NewFieldProps.Name -Type $NewFieldProps.Type -Choices $NewFieldProps.Choices -AddToDefaultView
    }
	elseif ($NewFieldProps.Type -like "User*"){
      Write-host Type: $($NewFieldProps.Type)
      if($NewFieldProps.Type -eq "UserMulti"){
        Add-PnPFieldFromXml -List $NewFieldProps.List -FieldXml "<Field Id='{$([guid]::NewGuid())}' Name='$($NewFieldProps.Name)' BaseType='Text' DisplayName='$($NewFieldProps.Title)' Type='$($NewFieldProps.Type)' Mult='TRUE' Sealed='FALSE' ShowInDisplayForm='TRUE' ShowInEditForm='TRUE' ShowInNewForm='TRUE' ShowInListSettings='TRUE' List='UserInfo' UserSelectionMode='PeopleOnly' SourceID='http://schemas.microsoft.com/sharepoint/v3'/>"
      }else{
        Add-PnPFieldFromXml -List $NewFieldProps.List -FieldXml "<Field Id='{$([guid]::NewGuid())}' Name='$($NewFieldProps.Name)' BaseType='Text' DisplayName='$($NewFieldProps.Title)' Type='$($NewFieldProps.Type)' Sealed='FALSE' ShowInDisplayForm='TRUE' ShowInEditForm='TRUE' ShowInNewForm='TRUE' ShowInListSettings='TRUE' List='UserInfo' UserSelectionMode='PeopleOnly' SourceID='http://schemas.microsoft.com/sharepoint/v3'/>"
      }
      
	}
    else {
      $NewField = Add-PnPField -List $ListProps.Title -DisplayName $NewFieldProps.Title -InternalName $NewFieldProps.Name -Type $NewFieldProps.Type -AddToDefaultView
    }

    $NewField = ($NewFieldProps.List.Fields) | Where-Object {$_.InternalName -eq $NewFieldProps.Name}
  }
}

function Create-UserField($NewFieldProps) {
  $NewField = ($NewFieldProps.List.Fields) | Where-Object {$_.InternalName -eq $NewFieldProps.Name}
  if ($null -eq $NewField) {
    Write-host Adding field $NewFieldProps.Name
    Write-host blabla: $NewFieldProps
    Write-host List: $NewFieldProps.List
    Add-PnPFieldFromXml -List $NewFieldProps.List -FieldXml "<Field Id='{$([guid]::NewGuid())}' Name='$($NewFieldProps.Name)' BaseType='Text' DisplayName='$($NewFieldProps.Title)' Type='User' Sealed='FALSE' ShowInDisplayForm='TRUE' ShowInEditForm='TRUE' ShowInNewForm='TRUE' ShowInListSettings='TRUE' List='UserInfo' UserSelectionMode='PeopleOnly' SourceID='http://schemas.microsoft.com/sharepoint/v3'/>"
  }
}

function Rename-Field ($List, $InternalName, $DisplayName){
    $field = Get-PnPField -List $List | Where-Object InternalName -eq $InternalName
    $field.Title = $DisplayName
    $field.Update()
    $List.Context.ExecuteQuery()
}
 
function Delete-Field($list, $fieldName)
{
  if ($null -ne $list) {
    $field = Get-PnPField -List $list -Identity $fieldName -ErrorAction SilentlyContinue
    if($null -ne $field){
        Write-host "Removing redundant field..."
        $suppress = Remove-PnPField -List $list -Identity $fieldName -Force
    }
  }
}
