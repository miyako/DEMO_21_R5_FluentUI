
Case of 
	: (Form event code:C388=On Load:K2:1)
		SET WINDOW TITLE:C213(Localized string("DeleteProject_WindowTitle"))
		If (Form:C1466.title="")
			Form:C1466.title:=Localized string("DeleteProject_TitleDefault")
		End if 
		If (Form:C1466.message="")
			Form:C1466.message:=Localized string("DeleteProject_Message")
		End if 
		
	: (Form event code:C388=On Validate:K2:3)
		Form:C1466.confirmed:=True:C215
		
End case 