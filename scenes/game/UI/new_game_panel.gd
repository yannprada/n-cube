extends PanelContainer

signal ok(cube_size: int, scrambling_moves: int)
signal cancel


func init(cube_size: int, scrambling_moves: int) -> void:
	%Size.value = cube_size
	%Scrambles.value = scrambling_moves


func _on_ok_pressed() -> void:
	ok.emit(%Size.value, %Scrambles.value)
	hide()


func _on_cancel_pressed() -> void:
	cancel.emit()
	hide()
