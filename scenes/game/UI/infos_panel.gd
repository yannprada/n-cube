extends PanelContainer

signal ok


func _on_ok_pressed() -> void:
	ok.emit()
	hide()
