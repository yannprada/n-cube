extends Node


func _on_ui_new_game(size: int, moves: int) -> void:
	%World.clear()
	%World.generate(size)
	%World.scramble(moves)


func _on_ui_button_click() -> void:
	%ClickPlayer.play()


func _on_world_rotating() -> void:
	%ScratchPlayer.play()


func _on_world_rotating_done() -> void:
	%UI.on_rotating_done()
