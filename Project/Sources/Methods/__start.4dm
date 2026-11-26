//%attributes = {}
// Start method: opens the start screen, or brings it to the front if it is already open.
// Called without parameters by On Startup and the File menu; calls itself with {}
// in the application process (worker 1), which opens the window non-blocking.
#DECLARE($params : Object)

var $title : Text
var $window : Integer
var $left; $top; $right; $bottom : Integer
$title:=Localized string("Start_WindowTitle")

If (Count parameters=0)
	
	ARRAY LONGINT($windows; 0)
	WINDOW LIST:C442($windows)
	var $i : Integer
	For ($i; 1; Size of array:C274($windows))
		$window:=$windows{$i}
		If (Window process($window)=1) && (Get window title($window)=$title)
			GET WINDOW RECT($left; $top; $right; $bottom; $window)
			CALL FORM($window; Formula(SET WINDOW RECT($left; $top; $right; $bottom; $window)))
			return 
		End if 
	End for 
	
	CALL WORKER(1; Current method name; {})
	
Else 
	
	SET MENU BAR(1)
	$window:=Open form window:C675("StartScreen"; Plain form window:K39:10; Horizontally centered:K39:1; Vertically centered:K39:4)
	SET WINDOW TITLE:C213($title; $window)
	DIALOG:C40("StartScreen"; $params; *)
	
End if 