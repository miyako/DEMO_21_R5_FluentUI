// Replace the data with sample data in the current display language, after confirmation
CONFIRM(Localized string("ConfirmGenerateData"); Localized string("AlertButtonGenerate"); Localized string("Button_Cancel"))
If (OK=1)
	var $result:=GenerateData
	ALERT:C41(LocalizedFormat("AlertSampleDataGenerated"; [$result.projects; $result.tasks]))
End if 