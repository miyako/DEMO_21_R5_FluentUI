//%attributes = {"invisible":true}
// Project forms demo (ORDA + form classes): opens the project list in its own window,
// next to the start screen, or brings it to the front if it is already open.

var $title:=Localized string("ProjectList_WindowTitle")
var $window : Integer
var $left; $top; $right; $bottom : Integer

ARRAY LONGINT($windows; 0)
WINDOW LIST:C442($windows)
var $i : Integer
For ($i; 1; Size of array:C274($windows))
	$window:=$windows{$i}
	If (Window process($window)=Current process) && (Get window title($window)=$title)
		GET WINDOW RECT($left; $top; $right; $bottom; $window)
		CALL FORM($window; Formula(SET WINDOW RECT($left; $top; $right; $bottom; $window)))
		return 
	End if 
End for 

$window:=Open form window:C675("ProjectList"; Plain form window:K39:10; Horizontally centered:K39:1; Vertically centered:K39:4)
SET WINDOW TITLE:C213($title; $window)
DIALOG:C40("ProjectList"; cs:C1710.ProjectListForm.new(); *)