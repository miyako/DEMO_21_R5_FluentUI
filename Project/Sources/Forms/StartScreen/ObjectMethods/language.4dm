// Display language: endonyms are not localised, so each language is always recognisable
If (Form event code:C388=On Data Change)
	SwitchLanguage(Form:C1466.language.codes[Form:C1466.language.index])
End if 