extends Node


func _on_scramble_button_pressed() -> void:
	%UI.disable()
	%World.scramble()
	await get_tree().create_timer(0.25*50).timeout
	%UI.enable()


func _on_new_button_pressed() -> void:
	%World.clear()
	%World.generate(%SizeSlider.value)
