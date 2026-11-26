var $left; $top; $right; $bottom; $width; $height; $tileWidth; $tileHeight : Integer

Case of 
	: (Form event code:C388=On Load:K2:1)
		
		Form:C1466.language:={values: ["English"; "日本語"]; codes: ["en"; "ja"]}
		Form:C1466.language.index:=Form:C1466.language.codes.indexOf(Get database localization(Current localization))
		If (Form:C1466.language.index<0)
			Form:C1466.language.index:=0
		End if 
		
	: (Form event code:C388=On Resize:K2:27)
		
		// Two tiles side by side on top, one full-width tile below
		GET WINDOW RECT:C443($left; $top; $right; $bottom; Current form window)
		
		$width:=$right-$left
		$height:=$bottom-$top
		$tileWidth:=($width-60)/2
		$tileHeight:=($height-120)/2
		
		OBJECT SET COORDINATES:C1248(*; "project_btn"; 20; 80; 20+$tileWidth; 80+$tileHeight)
		OBJECT SET COORDINATES:C1248(*; "list_btn"; 40+$tileWidth; 80; $width-20; 80+$tileHeight)
		OBJECT SET COORDINATES:C1248(*; "generate_btn"; 20; 100+$tileHeight; $width-20; $height-20)
		
End case 