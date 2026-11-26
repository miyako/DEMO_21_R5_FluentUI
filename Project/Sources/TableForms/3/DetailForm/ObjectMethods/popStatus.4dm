// Store the key of the selected label (see StatusKeys / StatusDropdown)
If (Form event code:C388=On Data Change)
	[Project:3]status:4:=StatusKeys()[Form:C1466.statusDrop.index]
End if 