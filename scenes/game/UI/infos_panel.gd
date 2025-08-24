extends PanelContainer

signal button_clicked


func _on_close_button_pressed() -> void:
	button_clicked.emit()
	hide()
