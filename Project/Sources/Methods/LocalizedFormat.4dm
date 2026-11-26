//%attributes = {"invisible":true}
// Localized string with numbered placeholders {1}, {2}, ... replaced by $values.
// Falls back to the ID itself when the XLIFF entry is missing, so gaps are visible.
#DECLARE($id : Text; $values : Collection) : Text

var $text:=Localized string($id)
If ($text="")
	$text:=$id
End if 

If ($values#Null)
	var $i : Integer
	For ($i; 1; $values.length)
		$text:=Replace string($text; "{"+String($i)+"}"; String($values[$i-1]))
	End for 
End if 

return $text