// Search button - Execute search with current search text
var $event:=FORM Event:C1606

Case of 
	: ($event.code=On Clicked:K2:4)
		// Update visibility of clear button based on search text
		OBJECT SET VISIBLE:C603(*; "btnDel"; Form:C1466.search#"")
		
		var $search : Text:="@"+Form:C1466.search+"@"
		
		// Statuses are stored as keys: also match the localised labels
		var $keys:=[]
		var $key : Text
		For each ($key; StatusKeys())
			If (StatusLabel($key)=$search) || ($key=$search)
				$keys.push($key)
			End if 
		End for each 
		
		QUERY:C277([Project:3]; [Project:3]name:2=$search; *)
		For each ($key; $keys)
			QUERY:C277([Project:3];  | ; [Project:3]status:4=$key; *)
		End for each 
		QUERY:C277([Project:3];  | ; [Project:3]manager:3=$search)
		
End case 
