
Case of 
	: (Form event code:C388=On Load:K2:1)
		
		Form:C1466.updateWindowTitle()
		Form:C1466.initDropDown()
		
		// Update button states
		Form:C1466.updateNavigationButtons()
		
	: (Form event code:C388=On Printing Detail:K2:18)
		OBJECT SET VISIBLE:C603(*; "ToolbarBg1"; False:C215)
		OBJECT SET RGB COLORS:C628(*; "@"; 0x0000)
		OBJECT SET BORDER STYLE:C1262(*; "inp@"; None:K36:11)
		
End case 