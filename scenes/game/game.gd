extends Node


func _on_ui_new_game(size: int, moves: int) -> void:
	%World.clear()
	%World.generate(size)
	%World.scramble(moves)


func _on_ui_tween_duration_changed(value: float) -> void:
	%World.set_tween_duration(value)
