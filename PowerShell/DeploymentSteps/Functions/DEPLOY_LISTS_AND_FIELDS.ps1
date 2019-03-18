function CreateList($ListProps) {
  $NewList = Get-PnPList -Identity $ListProps.Title -Includes Fields
  if ($null -eq $NewList ) {
    Write-host Creating list $ListProps.Title
    New-PnPList -Title $ListProps.Title -Template GenericList -Url "Lists/$($ListProps.Name)"
    $NewList = Get-PnPList -Identity $ListProps.Title -Includes Fields
  }
  $NewList
}

function CreateLibrary($ListProps) {
  $NewList = Get-PnPList -Identity $ListProps.Title -Includes Fields
  if ($null -eq $NewList) {
    Write-host Creating list $ListProps.Title
    New-PnPList -Title $ListProps.Title -Template DocumentLibrary -Url "$($ListProps.Name)"
    $NewList = Get-PnPList -Identity $ListProps.Title -Includes Fields
  }
  $NewList
}

function CreateField($NewFieldProps) {
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

function CreateUserField($NewFieldProps) {
  $NewField = ($NewFieldProps.List.Fields) | Where-Object {$_.InternalName -eq $NewFieldProps.Name}
  if ($null -eq $NewField) {
    Write-host Adding field $NewFieldProps.Name
    Write-host blabla: $NewFieldProps
    Write-host List: $NewFieldProps.List
    Add-PnPFieldFromXml -List $NewFieldProps.List -FieldXml "<Field Id='{$([guid]::NewGuid())}' Name='$($NewFieldProps.Name)' BaseType='Text' DisplayName='$($NewFieldProps.Title)' Type='User' Sealed='FALSE' ShowInDisplayForm='TRUE' ShowInEditForm='TRUE' ShowInNewForm='TRUE' ShowInListSettings='TRUE' List='UserInfo' UserSelectionMode='PeopleOnly' SourceID='http://schemas.microsoft.com/sharepoint/v3'/>"
  }
}

function RenameField ($List, $InternalName, $DisplayName){
    $field = Get-PnPField -List $List | Where-Object InternalName -eq $InternalName
    $field.Title = $DisplayName
    $field.Update()
    $List.Context.ExecuteQuery()
}
 
function DeleteField($list, $fieldName)
{
  if ($null -ne $list) {
    $field = Get-PnPField -List $list -Identity $fieldName -ErrorAction SilentlyContinue
    if($null -ne $field){
        Write-host "Removing redundant field..."
        $suppress = Remove-PnPField -List $list -Identity $fieldName -Force
    }
  }
}

################## ADD YOUR LISTS AND FIELDS HERE: ##############################

# List 1:
$ListProps = @{Name = "Courses"; Title = "Courses"}
$NewList = CreateList $ListProps
RenameField $NewList "Title" "Course Name"
CreateField @{List = $NewList; Name = "Level"; Title = "Level"; Type = "Text"; }
CreateField @{List = $NewList; Name = "Description"; Title = "Description"; Type = "Note"}
CreateField @{List = $NewList; Name = "Rating"; Title = "Rating"; Type = "Number"}
CreateField @{List = $NewList; Name = "Price"; Title = "Price"; Type = "Text"}
CreateField @{List = $NewList; Name = "CourseType"; Title = "Course Type"; Type = "Choice"; Choices = "Webinar", "Seminar", "Other"}
CreateField @{List = $NewList; Name = "Active"; Title = "Active"; Type = "Boolean"; }
CreateField @{List = $NewList; Name = "Approvers"; Title = "Approvers"; Type = "UserMulti"}
CreateField @{List = $NewList; Name = "HeadOfDepartment"; Title = "Head of Department"; Type = "User"}

# List 2:
$ListProps = @{Name = "Comments"; Title = "Comments"}
$NewList = CreateList $ListProps
CreateField @{List = $NewList; Name = "Comment"; Title = "Comment"; Type = "Note"}
CreateField @{List = $NewList; Name = "Like"; Title = "Like"; Type = "Boolean"}
CreateField @{List = $NewList; Name = "CourseId"; Title = "Course ID"; Type = "Number"}

# List 3:
$ListProps = @{Name = "Opportunities"; Title = "Learning opportunities"}
$NewList = CreateList $ListProps
CreateField @{List = $NewList; Name = "CourseId"; Title = "Course ID"; Type = "Text"}
CreateField @{List = $NewList; Name = "Manager"; Title = "Supervisor or Manager"; Type = "User"}
CreateField @{List = $NewList; Name = "TimeAway"; Title = "Time Away"; Type = "Choice"; Choices = "Less than 1 day", "1 day", "2 days", "3 days", "4 days", "5 days"}
CreateField @{List = $NewList; Name = "CourseType"; Title = "Course Type"; Type = "Choice"; Choices = "Webinar", "Seminar", "Other"}
CreateField @{List = $NewList; Name = "Status"; Title = "Status"; Type = "Choice"; Choices = "Pending", "Approved", "Declined", "Canceled", "Completed"}
CreateField @{List = $NewList; Name = "CourseName"; Title = "CourseName"; Type = "Text"}
CreateField @{List = $NewList; Name = "CourseInfoUrl"; Title = "Course Information URL"; Type = "Text"}
CreateField @{List = $NewList; Name = "HowHelpsToGrow"; Title = "How it will help to grow"; Type = "Note"}
CreateField @{List = $NewList; Name = "Like"; Title = "Like"; Type = "Boolean"}
CreateField @{List = $NewList; Name = "DateRequested"; Title = "Date Requested"; Type = "DateTime"}

# Library:
$ListProps = @{Name = "ProjectRepositories"; Title = "Project Repositories"}
$NewList = CreateLibrary $ListProps
# CreateField @{List = $NewList; Name = "AppID"; Title = "App ID"; Type = "Text"}

$NewList.EnableVersioning = $true
$NewList.Update()
$NewList.Context.ExecuteQuery()

# List 4:
$ListProps = @{Name = "Migrated"; Title = "Migrated List"}
$NewList = CreateList $ListProps

CreateField @{List = $NewList; Name = "ProjectClasses"; Title = "Project Classes"; Type = "Text"}
RenameField $NewList "Title" "Migrated Item"
CreateField @{List = $NewList; Name = "ProjectPhase"; Title = "Project Phase"; Type = "Text"}
CreateField @{List = $NewList; Name = "PhaseOrder"; Title = "Phase Order"; Type = "Number"}
CreateField @{List = $NewList; Name = "Order"; Title = "Order"; Type = "Text"}
CreateField @{List = $NewList; Name = "ArtefactRequired"; Title = "Required"; Type = "Boolean"}
CreateField @{List = $NewList; Name = "ApproverRoles"; Title = "ApproverRoles"; Type = "Text"}

$NewList.EnableVersioning = $true
$NewList.Update()
$NewList.Context.ExecuteQuery()
