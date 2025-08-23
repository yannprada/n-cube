extends PanelContainer

signal cube_clicked
signal button_clicked


func _ready() -> void:
	%Length.value = Config.animation_length
	%CubeSounds.init(Config.cube_volume)
	%UISounds.init(Config.UI_volume)
	AudioServer.set_bus_volume_linear(AudioServer.get_bus_index("Cube"), Config.cube_volume)
	AudioServer.set_bus_volume_linear(AudioServer.get_bus_index("UI"), Config.UI_volume)


func _on_cube_sounds_value_changed(_value: float) -> void:
	if is_node_ready():
		# this prevents an on_change trigger before _ready
		AudioServer.set_bus_volume_linear(AudioServer.get_bus_index("Cube"), _value)
		Config.cube_volume = _value
		Config.save()
		cube_clicked.emit()


func _on_ui_sounds_value_changed(_value: float) -> void:
	if is_node_ready():
		# this prevents an on_change trigger before _ready
		AudioServer.set_bus_volume_linear(AudioServer.get_bus_index("UI"), _value)
		Config.UI_volume = _value
		Config.save()
		button_clicked.emit()


func _on_length_button_clicked() -> void:
	button_clicked.emit()


func _on_length_value_changed(value: float) -> void:
	if is_node_ready():
		# this prevents an on_change trigger before _ready
		Config.animation_length = value
		Config.save()
