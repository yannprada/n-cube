extends Control

@export var config: Resource

signal new_game(size: int, moves: int)
signal button_click


func _ready() -> void:
	config.load()
	%SizeSlider.value = config.cube_size
	%ScramblingSlider.value = config.scrambling_moves
	%AnimationLength.value = config.animation_length


# NEW GAME
func _on_new_game_ok_pressed() -> void:
	config.cube_size = %SizeSlider.value
	config.scrambling_moves = %ScramblingSlider.value
	config.save()
	new_game.emit(config.cube_size, config.scrambling_moves)
	
	%NewGamePanel.hide()
	%NewGame.disabled = true
	await get_tree().create_timer(config.get_scramble_time()).timeout
	%NewGame.disabled = false


func _on_new_game_cancel_pressed() -> void:
	%NewGamePanel.hide()
	%SizeSlider.value = config.cube_size
	%ScramblingSlider.value = config.scrambling_moves
	button_click.emit()


func _on_new_game_pressed() -> void:
	%OptionsPanel.hide()
	%InfosPanel.hide()
	%NewGamePanel.visible = not %NewGamePanel.visible
	button_click.emit()


# OPTIONS
func _on_options_ok_pressed() -> void:
	%OptionsPanel.hide()
	config.animation_length = %AnimationLength.value
	config.save()
	button_click.emit()


func _on_options_cancel_pressed() -> void:
	%OptionsPanel.hide()
	%AnimationLength.value = config.animation_length
	button_click.emit()


func _on_options_pressed() -> void:
	%NewGamePanel.hide()
	%InfosPanel.hide()
	%OptionsPanel.visible = not %OptionsPanel.visible
	button_click.emit()


# INFOS
func _on_infos_pressed() -> void:
	%NewGamePanel.hide()
	%OptionsPanel.hide()
	%InfosPanel.visible = not %InfosPanel.visible
	button_click.emit()


# ZOOM
func _fire_action(action_name: String, pressed: bool) -> void:
	var event = InputEventAction.new()
	event.action = action_name
	event.pressed = pressed
	Input.parse_input_event(event)
	button_click.emit()


func _on_zoom_in_button_down() -> void:
	_fire_action('Zoom In', true)


func _on_zoom_in_button_up() -> void:
	_fire_action('Zoom In', false)


func _on_zoom_out_button_down() -> void:
	_fire_action('Zoom Out', true)


func _on_zoom_out_button_up() -> void:
	_fire_action('Zoom Out', false)
