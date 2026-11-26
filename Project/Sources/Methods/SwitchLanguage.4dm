//%attributes = {"invisible":true}
// Switches the display language (en / ja) and reopens the start screen,
// because forms that are already open keep the labels they were loaded with.
#DECLARE($language : Text)

If ($language=Get database localization(Current localization))
	return 
End if 

SET DATABASE LOCALIZATION($language)
CANCEL
CALL WORKER(1; "__start"; {})