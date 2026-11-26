//%attributes = {"invisible":true}
// Table forms demo (classic input/output forms): runs MODIFY SELECTION on [Project]
// in its own process, so it has its own window and current selection.
// Called without parameters by the start screen; calls itself with {} in the new process.
#DECLARE($params : Object)

If (Count parameters=0)
	
	// "*": a second click finds the running process instead of starting another one
	New process(Current method name; 0; Current method name; {}; *)
	
Else 
	
	SET MENU BAR(1)
	var $window:=Open form window:C675([Project:3]; "OutputForm"; Plain form window:K39:10; Horizontally centered:K39:1; Vertically centered:K39:4)
	ALL RECORDS:C47([Project:3])
	FORM SET INPUT:C55([Project:3]; "DetailForm")
	FORM SET OUTPUT:C54([Project:3]; "OutputForm")
	MODIFY SELECTION:C204([Project:3]; 1; True:C214)
	CLOSE WINDOW:C154($window)
	
End if 