extends Control

var _tween_duration: float = 0.25

signal new_game(size: int, moves: int)
signal tween_duration_changed(value: float)


# NEW GAME
func _on_new_game_ok_pressed() -> void:
	var moves = %ScramblingSlider.value
	_tween_duration = %TweenSlider.value
	tween_duration_changed.emit(_tween_duration)
	new_game.emit(%SizeSlider.value, moves)
	
	%NewGamePanel.hide()
	%NewGame.disabled = true
	await get_tree().create_timer(moves * _tween_duration).timeout
	%NewGame.disabled = false


func _on_new_game_cancel_pressed() -> void:
	%NewGamePanel.hide()


func _on_new_game_pressed() -> void:
	%OptionsPanel.hide()
	%TweenSlider.value = _tween_duration
	%NewGamePanel.visible = not %NewGamePanel.visible

# OPTIONS
func _on_options_ok_pressed() -> void:
	%OptionsPanel.hide()
	_tween_duration = %TweenSliderOpt.value
	tween_duration_changed.emit(_tween_duration)


func _on_options_cancel_pressed() -> void:
	%OptionsPanel.hide()


func _on_options_pressed() -> void:
	%NewGamePanel.hide()
	%TweenSliderOpt.value = _tween_duration
	%OptionsPanel.visible = not %OptionsPanel.visible
