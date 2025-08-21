extends Node


func _on_ui_new_game(size: int, moves: int) -> void:
	%World.clear()
	%World.generate(size)
	%World.scramble(moves)
