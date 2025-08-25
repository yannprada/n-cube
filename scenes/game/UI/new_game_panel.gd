extends PanelContainer

signal button_clicked
signal ok


func _ready() -> void:
	%Size.value = Config.cube_size


func _on_size_value_changed(value: int) -> void:
	if is_node_ready():
		Config.cube_size = value
		Config.save()
		button_clicked.emit()


func _on_go_button_pressed() -> void:
	button_clicked.emit()
	hide()
	await get_tree().create_timer(0.25).timeout
	ok.emit()


func _on_close_button_pressed() -> void:
	button_clicked.emit()
	hide()
