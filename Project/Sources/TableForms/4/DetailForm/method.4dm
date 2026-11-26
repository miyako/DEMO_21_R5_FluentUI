Case of 
	: (Form event code:C388=On Load:K2:1)
		SET WINDOW TITLE:C213(LocalizedFormat("TaskDetail_WindowTitle"; [[Task:4]title:2]))
		// Status dropdown shows localised labels; the field keeps the stored key
		Form:C1466.statusDrop:=StatusDropdown([Task:4]status:3)
		
End case 