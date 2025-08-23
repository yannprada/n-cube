extends PanelContainer

signal button_clicked
signal ok


func _ready() -> void:
	%Size.value = Config.cube_size
	%Scrambles.value = Config.scrambling_moves


func _on_ok_pressed() -> void:
	button_clicked.emit()
	hide()
	await get_tree().create_timer(0.25).timeout
	ok.emit()


func _on_cancel_pressed() -> void:
	button_clicked.emit()
	hide()


func _on_size_value_changed(value: int) -> void:
	if is_node_ready():
		Config.cube_size = value
		Config.save()
		button_clicked.emit()


func _on_scrambles_value_changed(value: int) -> void:
	if is_node_ready():
		Config.scrambling_moves = value
		Config.save()
		button_clicked.emit()
