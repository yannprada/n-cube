extends Control

@export var new_game_panel: PanelContainer
@export var options_panel: PanelContainer
@export var infos_panel: PanelContainer
@export var config: Resource

signal new_game(size: int, moves: int)
signal button_click


func _ready() -> void:
	config.load()
	new_game_panel.init(config.cube_size, config.scrambling_moves)
	%AnimationLength.value = config.animation_length


# NEW GAME
func _on_new_game_ok_pressed(cube_size: int, scrambling_moves: int) -> void:
	config.cube_size = cube_size
	config.scrambling_moves = scrambling_moves
	config.save()
	new_game.emit(cube_size, scrambling_moves)
	%NewGame.disabled = true


func on_rotating_done() -> void:
	%NewGame.disabled = false


func _on_new_game_cancel_pressed() -> void:
	button_click.emit()


func _on_new_game_pressed() -> void:
	new_game_panel.init(config.cube_size, config.scrambling_moves)
	options_panel.hide()
	infos_panel.hide()
	new_game_panel.visible = not new_game_panel.visible
	button_click.emit()


# OPTIONS
func _on_options_ok_pressed() -> void:
	options_panel.hide()
	config.animation_length = %AnimationLength.value
	config.save()
	button_click.emit()


func _on_options_cancel_pressed() -> void:
	options_panel.hide()
	%AnimationLength.value = config.animation_length
	button_click.emit()


func _on_options_pressed() -> void:
	new_game_panel.hide()
	infos_panel.hide()
	options_panel.visible = not options_panel.visible
	button_click.emit()


# INFOS
func _on_infos_pressed() -> void:
	new_game_panel.hide()
	options_panel.hide()
	infos_panel.visible = not infos_panel.visible
	button_click.emit()


func _on_infos_ok_pressed() -> void:
	infos_panel.hide()
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
