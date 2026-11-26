Class extends Entity

// Localised label of the stored status key (e.g. "In Progress" -> "進行中").
Function get statusLabel() : Text
	return StatusLabel(This:C1470.status)
	
// Sorting on statusLabel sorts on the stored key, without calling the getter per entity.
Function orderBy statusLabel($event : Object) : Text
	return "status "+$event.operator