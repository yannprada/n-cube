extends Control

signal new_game(size: int, moves: int, duration: float)


func disable() -> void:
	%NewGame.disabled = true


func enable() -> void:
	%NewGame.disabled = false


func _on_size_slider_value_changed(value: int) -> void:
	%SizeLabel.text = 'Cube Size: ' + str(value)


func _on_scrambling_slider_value_changed(value: int) -> void:
	%ScramblingLabel.text = 'Scrambling Moves: ' + str(value)


func _on_tween_slider_value_changed(value: float) -> void:
	%TweenLabel.text = 'Animation Length: %.2fs' % value


func _on_new_game_ok_pressed() -> void:
	new_game.emit(%SizeSlider.value, %ScramblingSlider.value, %TweenSlider.value)
	%NewGamePanel.hide()
	%NewGame.disabled = true
	await get_tree().create_timer(%ScramblingSlider.value * %TweenSlider.value).timeout
	%NewGame.disabled = false


func _on_new_game_cancel_pressed() -> void:
	%NewGamePanel.hide()


func _on_new_game_pressed() -> void:
	%NewGamePanel.show()
