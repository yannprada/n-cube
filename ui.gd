extends VBoxContainer


func disable() -> void:
	%ScrambleButton.disabled = true
	%NewButton.disabled = true
	%SizeSlider.editable = false


func enable() -> void:
	%ScrambleButton.disabled = false
	%NewButton.disabled = false
	%SizeSlider.editable = true
