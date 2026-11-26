//%attributes = {}
// Replaces all projects and tasks with random sample data in the current display language.
// Names and comments come from Resources/<language>.lproj/sampleData.json (en, ja).
// Statuses are always stored as keys (see StatusKeys) and displayed with StatusLabel.
#DECLARE() : Object  // {projects: Integer; tasks: Integer}

var $i; $j; $taskCount : Integer
var $project : cs:C1710.ProjectEntity
var $task : cs:C1710.TaskEntity
var $status : Text

// Sample texts in the current language (fallback: English)
var $path:=Localized document path("sampleData.json")
var $file : 4D.File
If ($path#"")
	$file:=File($path; fk platform path)
End if 
If ($file=Null) || (Not($file.exists))
	$file:=Folder(fk resources folder).file("en.lproj/sampleData.json")
End if 
var $data : Object:=JSON Parse($file.getText())
var $sep : Text:=$data.separator  // between sentences: " " in English, "" in Japanese
var $statuses:=StatusKeys()

// Clean existing data
ds:C1482.Task.all().drop()
ds:C1482.Project.all().drop()
SET DATABASE PARAMETER:C642([Project:3]; Table sequence number:K37:31; 0)
SET DATABASE PARAMETER:C642([Task:4]; Table sequence number:K37:31; 0)

// One project per sample name, so names are unique
For ($i; 0; $data.projectNames.length-1)
	
	$project:=ds:C1482.Project.new()
	
	$project.name:=$data.projectNames[$i]
	$project.manager:=$data.managers[Random:C100%$data.managers.length]
	
	$status:=$statuses[Random:C100%$statuses.length]
	$project.status:=$status
	
	$project.notificationsEnabled:=((Random:C100%2)=1)
	$project.clientValidationRequired:=((Random:C100%2)=1)
	
	Case of 
		: ($status="Completed")
			$project.progress:=100
		: ($status="To Do")
			$project.progress:=0
		Else 
			$project.progress:=Random:C100%90
	End case 
	
	$project.comments:=$data.commentStarts[Random:C100%$data.commentStarts.length]+$sep+$data.commentNextSteps[Random:C100%$data.commentNextSteps.length]
	If ((Random:C100%3)=1)
		$project.comments:=$project.comments+$sep+$data.commentRisks[Random:C100%$data.commentRisks.length]
	End if 
	$project.comments:=$project.comments+$sep+$data.projectStatusComments[$status]
	
	$project.save()
	
	// Create tasks
	For ($j; 1; (Random:C100%5)+2)
		
		$task:=ds:C1482.Task.new()
		
		$task.title:=$data.taskNames[Random:C100%$data.taskNames.length]
		$task.assignee:=$data.managers[Random:C100%$data.managers.length]
		
		$status:=$statuses[Random:C100%$statuses.length]
		$task.status:=$status
		
		If ($status="Completed")
			$task.progress:=100
		Else 
			$task.progress:=Random:C100%100
		End if 
		
		$task.comments:=$data.commentStarts[Random:C100%$data.commentStarts.length]+$sep+$data.commentNextSteps[Random:C100%$data.commentNextSteps.length]
		If ((Random:C100%4)=1)
			$task.comments:=$task.comments+$sep+$data.commentRisks[Random:C100%$data.commentRisks.length]
		End if 
		$task.comments:=$task.comments+$sep+$data.taskStatusComments[$status]
		
		// relation
		$task.IDproject:=$project.ID
		
		$task.save()
		$taskCount+=1
		
	End for 
	
End for 

return {projects: $data.projectNames.length; tasks: $taskCount}