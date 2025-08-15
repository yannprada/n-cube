extends Node


func _on_ui_new_game(size: int, moves: int, tween_duration: float) -> void:
	%Pivot.tween_duration = tween_duration
	%World.clear()
	%World.generate(size)
	%World.scramble(moves)
