extends Node


func _on_ui_new_game(size: int, moves: int, tween_duration: float) -> void:
	%World.clear()
	%World.set_tween_duration(tween_duration)
	%World.generate(size)
	%World.scramble(moves)
