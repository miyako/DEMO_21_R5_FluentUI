// Store the key of the selected label (see StatusKeys / StatusDropdown)
If (Form event code:C388=On Data Change)
	[Task:4]status:3:=StatusKeys()[Form:C1466.statusDrop.index]
End if 