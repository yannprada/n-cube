extends PanelContainer

signal ok(animation_length: float)
signal cancel
signal cube_volume_changed(value: float)
signal UI_volume_changed(value: float)


func init(animation_length: float, cube_volume: float, UI_volume: float) -> void:
	%Length.value = animation_length
	%CubeSounds.init(cube_volume)
	%UISounds.init(UI_volume)


func _on_ok_pressed() -> void:
	ok.emit(%Length.value)
	hide()


func _on_cancel_pressed() -> void:
	cancel.emit()
	hide()


func _on_cube_sounds_value_changed(_value: float) -> void:
	cube_volume_changed.emit(_value)


func _on_ui_sounds_value_changed(_value: float) -> void:
	UI_volume_changed.emit(_value)
