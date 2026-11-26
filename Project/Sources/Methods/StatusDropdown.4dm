//%attributes = {"invisible":true}
// Dropdown object (values/index/currentValue) showing localised status labels.
// Map the selection back to the stored key with StatusKeys()[$dropdown.index].
#DECLARE($key : Text) : Object

var $keys:=StatusKeys()
var $index:=$keys.indexOf($key)
If ($index<0)
	$index:=0
End if 

var $labels:=[]
var $each : Text
For each ($each; $keys)
	$labels.push(StatusLabel($each))
End for each 

return {values: $labels; index: $index; currentValue: $labels[$index]}