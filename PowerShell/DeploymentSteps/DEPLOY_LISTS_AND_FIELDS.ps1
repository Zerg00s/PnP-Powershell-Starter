function CreateList($ListProps) {
  $NewList = Get-PnPList -Identity $ListProps.Title -Includes Fields
  if ($NewList -eq $null) {
    Write-host Creating list $ListProps.Title
    $NewList = New-PnPList -Title $ListProps.Title -Template GenericList -Url "Lists/$($ListProps.Name)"
    $NewList = Get-PnPList -Identity $ListProps.Name -Includes Fields
  }
  return $NewList
}

function CreateField($NewFieldProps) {
  $NewField = ($NewFieldProps.List.Fields) | Where-Object {$_.InternalName -eq $NewFieldProps.Name}
  if ($NewField -eq $null) {
    Write-host Adding field $NewFieldProps.Name
    if ($NewFieldProps.Type -eq "Choice") {
      $NewField = Add-PnPField -List $ListProps.Title -DisplayName $NewFieldProps.Title -InternalName $NewFieldProps.Name -Type $NewFieldProps.Type -Choices $NewFieldProps.Choices -AddToDefaultView
    }
    else {
      $NewField = Add-PnPField -List $ListProps.Title -DisplayName $NewFieldProps.Title -InternalName $NewFieldProps.Name -Type $NewFieldProps.Type -AddToDefaultView
    }

    $NewField = ($NewFieldProps.List.Fields) | Where-Object {$_.InternalName -eq $NewFieldProps.Name}
  }
}

$ListProps = @{Name = "Courses"; Title = "Courses"}
$NewList = CreateList $ListProps
CreateField @{List = $NewList; Name = "Description"; Title = "Description"; Type = "Note"}
CreateField @{List = $NewList; Name = "CourseType"; Title = "Course Type"; Type = "Choice"; Choices = "Webinar", "Seminar", "Other"}
CreateField @{List = $NewList; Name = "Price"; Title = "Price"; Type = "Text"; }
CreateField @{List = $NewList; Name = "Level"; Title = "Level"; Type = "Text"; }
CreateField @{List = $NewList; Name = "Active"; Title = "Active"; Type = "Boolean"; }

$ListProps = @{Name = "Comments"; Title = "Comments"}
$NewList = CreateList $ListProps
CreateField @{List = $NewList; Name = "Comment"; Title = "Comment"; Type = "Note"}
CreateField @{List = $NewList; Name = "Like"; Title = "Like"; Type = "Boolean"}
CreateField @{List = $NewList; Name = "Rating"; Title = "Rating"; Type = "Number"}
CreateField @{List = $NewList; Name = "CourseId"; Title = "Course ID"; Type = "Number"}


$ListProps = @{Name = "Opportunities"; Title = "Learning opportunities"}
$NewList = CreateList $ListProps
CreateField @{List = $NewList; Name = "CourseId"; Title = "Course ID"; Type = "Text"}
CreateField @{List = $NewList; Name = "Status"; Title = "Status"; Type = "Choice"; Choices = "Pending", "Approved", "Declined", "Canceled", "Completed"}
CreateField @{List = $NewList; Name = "DateRequested"; Title = "Date Requested"; Type = "DateTime"}
CreateField @{List = $NewList; Name = "DateCompleted"; Title = "Date Completed"; Type = "DateTime"}
CreateField @{List = $NewList; Name = "DateAnticipated"; Title = "Anticipated Completion"; Type = "DateTime"}
CreateField @{List = $NewList; Name = "TimeAway"; Title = "Time Away"; Type = "Choice"; Choices = "Less than 1 day", "1 day", "2 days", "3 days", "4 days", "5 days"}
CreateField @{List = $NewList; Name = "CourseName"; Title = "CourseName"; Type = "Text"}
CreateField @{List = $NewList; Name = "Price"; Title = "Price"; Type = "Text"}
CreateField @{List = $NewList; Name = "Level"; Title = "Level"; Type = "Text"; }
CreateField @{List = $NewList; Name = "CourseInfoUrl"; Title = "Course Information URL"; Type = "Text"}
CreateField @{List = $NewList; Name = "CourseType"; Title = "Course Type"; Type = "Choice"; Choices = "Webinar", "Seminar", "Other"}
CreateField @{List = $NewList; Name = "HowHelpsToGrow"; Title = "How it will help to grow"; Type = "Note"}
CreateField @{List = $NewList; Name = "WhyRightTime"; Title = "Why is it the right time"; Type = "Note"}
CreateField @{List = $NewList; Name = "HowWilUse"; Title = "How it will be used"; Type = "Note"}
CreateField @{List = $NewList; Name = "Manager"; Title = "Supervisor or Manager"; Type = "User"}
CreateField @{List = $NewList; Name = "HeadOfDepartment"; Title = "Head of Department"; Type = "User"}
CreateField @{List = $NewList; Name = "Like"; Title = "Like"; Type = "Boolean"}
CreateField @{List = $NewList; Name = "WhyCancel"; Title = "Why Cancelled"; Type = "Note"}
CreateField @{List = $NewList; Name = "Comment"; Title = "Comment"; Type = "Note"}
CreateField @{List = $NewList; Name = "ApproverComment"; Title = "Approver Comment"; Type = "Note"}
CreateField @{List = $NewList; Name = "Competencies"; Title = "Competencies Addressed"; Type = "Note"}