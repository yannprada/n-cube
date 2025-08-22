extends PanelContainer

signal ok(animation_length: float)
signal cancel


func init(animation_length: float) -> void:
	%Length.value = animation_length


func _on_ok_pressed() -> void:
	ok.emit(%Length.value)
	hide()


func _on_cancel_pressed() -> void:
	cancel.emit()
	hide()
