// Project list properties
property projects : cs:C1710.ProjectSelection  // All projects from database, ordered by name
property selection : cs:C1710.ProjectSelection  // Filtered projects based on search or criteria
property selectedProject : cs:C1710.ProjectEntity  // Currently selected project

property delaySearch : Integer
property search : Text

Class constructor
	
	This:C1470.projects:=Null:C1517
	This:C1470.selection:=Null:C1517
	This:C1470.selectedProject:=Null:C1517
	
	This:C1470.delaySearch:=100
	This:C1470.search:=""
	
	// Load all projects
	This:C1470.loadProjects()
	
	
Function loadProjects()
	This:C1470.projects:=ds:C1482.Project.load(This:C1470.search)
	This:C1470.selection:=This:C1470.projects
	This:C1470.selectedProject:=This:C1470.selection.first()
	
	
Function onEditProject
	
	If (This:C1470.selectedProject#Null:C1517)
		
		// Initialize Detail Form with the selection for navigation
		var $formData:=cs:C1710.ProjectDetailForm.new(This:C1470.selectedProject; This:C1470.projects.length)
		
		// Modal on purpose: the list refreshes after the dialog returns
		var $window:=Open form window:C675("ProjectDetail"; Movable form dialog box; Horizontally centered:K39:1; Vertically centered:K39:4)
		DIALOG:C40("ProjectDetail"; $formData)
		CLOSE WINDOW:C154($window)
		This:C1470.projects.refresh()
	End if 
	
	
Function onNewProject
	
	// Initialize Detail Form
	var $formData:=cs:C1710.ProjectDetailForm.new(Null:C1517)
	
	// Modal on purpose: the new project is added to the list after the dialog returns
	var $window:=Open form window:C675("ProjectDetail"; Movable form dialog box; Horizontally centered:K39:1; Vertically centered:K39:4)
	DIALOG:C40("ProjectDetail"; $formData)
	CLOSE WINDOW:C154($window)
	
	// Cancelled or not saved: nothing to add
	If ($formData.project#Null:C1517) && (Not($formData.project.isNew()))
		This:C1470.projects.add($formData.project)
		This:C1470.projects.refresh()
	End if 
	
Function onRemoveProject
	
	If (This:C1470.selectedProject#Null:C1517)
		var $status : Object
		var $deleteDialogData : Object
		var $winRef : Integer
		
		$deleteDialogData:=New object:C1471
		$deleteDialogData.confirmed:=False:C215
		$deleteDialogData.title:=LocalizedFormat("DeleteProject_Title"; [This:C1470.selectedProject.name])
		$deleteDialogData.message:=Localized string("DeleteProject_Message")
		
		$winRef:=Open form window:C675("DeleteProjectConfirm"; Movable form dialog box no title:K39:20; Horizontally centered:K39:1; Vertically centered:K39:4; *)
		DIALOG:C40("DeleteProjectConfirm"; $deleteDialogData)
		CLOSE WINDOW:C154($winRef)
		
		If ($deleteDialogData.confirmed)
			$status:=This:C1470.selectedProject.removeProject()
			If ($status.success=False:C215)
				ALERT:C41($status.statusText)
			End if 
		End if 
		
		This:C1470.projects:=This:C1470.projects.clean()
		
	End if 
	