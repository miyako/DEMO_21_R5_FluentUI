Case of 
	: (Form event code:C388=On Load:K2:1)
		SET WINDOW TITLE:C213(LocalizedFormat("ProjectDetail_WindowTitle"; [[Project:3]name:2]))
		// Status dropdown shows localised labels; the field keeps the stored key
		Form:C1466.statusDrop:=StatusDropdown([Project:3]status:4)
		RELATE MANY:C262([Project:3])
		
	: (Form event code:C388=On Close Detail:K2:24)
		SET WINDOW TITLE:C213(Localized string("ProjectList_WindowTitle"))
		
End case 