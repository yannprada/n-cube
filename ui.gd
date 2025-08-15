extends VBoxContainer


func disable() -> void:
	%ScrambleButton.disabled = true
	%NewButton.disabled = true
	%SizeSlider.editable = false


func enable() -> void:
	%ScrambleButton.disabled = false
	%NewButton.disabled = false
	%SizeSlider.editable = true


func _on_size_slider_value_changed(value: int) -> void:
	%SizeLabel.text = 'Size: ' + str(value)
