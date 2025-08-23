extends PanelContainer

signal ok(animation_length: float)
signal cancel


func _ready() -> void:
	%Length.value = Config.animation_length
	%CubeSounds.init(Config.cube_volume)
	%UISounds.init(Config.UI_volume)
	AudioServer.set_bus_volume_linear(AudioServer.get_bus_index("Cube"), Config.cube_volume)
	AudioServer.set_bus_volume_linear(AudioServer.get_bus_index("UI"), Config.UI_volume)


func _on_ok_pressed() -> void:
	ok.emit(%Length.value)
	hide()


func _on_cancel_pressed() -> void:
	cancel.emit()
	hide()


func _on_cube_sounds_value_changed(_value: float) -> void:
	if is_node_ready():
		# this prevents an on_change trigger before widget value has been set to config value
		AudioServer.set_bus_volume_linear(AudioServer.get_bus_index("Cube"), _value)
		Config.cube_volume = _value
		Config.save()


func _on_ui_sounds_value_changed(_value: float) -> void:
	if is_node_ready():
		# this prevents an on_change trigger before widget value has been set to config value
		AudioServer.set_bus_volume_linear(AudioServer.get_bus_index("UI"), _value)
		Config.UI_volume = _value
		Config.save()
