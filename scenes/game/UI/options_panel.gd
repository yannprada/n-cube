extends PanelContainer

signal ok(animation_length: float, volume: float)
signal cancel
signal volume_changed


func init(animation_length: float) -> void:
	%Length.value = animation_length
	%VolumeSlider.init(AudioServer.get_bus_volume_linear(0))


func _on_ok_pressed() -> void:
	ok.emit(%Length.value, %VolumeSlider.value)
	hide()


func _on_cancel_pressed() -> void:
	cancel.emit()
	hide()


func _on_volume_slider_value_changed(_value: float) -> void:
	AudioServer.set_bus_volume_linear(0, _value)
	volume_changed.emit()
