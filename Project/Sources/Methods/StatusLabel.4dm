//%attributes = {"invisible":true}
// Display label of a stored status key in the current language (XLIFF IDs Status_*).
// Unknown keys are shown as stored.
#DECLARE($key : Text) : Text

If (StatusKeys().indexOf($key)<0)
	return $key
End if 

var $label:=Localized string("Status_"+Replace string($key; " "; ""))
return ($label="") ? $key : $label