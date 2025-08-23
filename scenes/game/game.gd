extends Node


func _on_ui_new_game() -> void:
	%World.clear()
	%World.generate(Config.cube_size)
	%World.scramble(Config.scrambling_moves)


func _on_ui_button_click() -> void:
	%ClickPlayer.play()


func _on_world_rotating() -> void:
	%ScratchPlayer.play()


func _on_world_rotating_done() -> void:
	%UI.on_rotating_done()
