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
	options_panel.init(config.animation_length)


func on_button_click():
	button_click.emit()


func toggle_panel(target_panel: PanelContainer) -> void:
	for panel in [new_game_panel, options_panel, infos_panel]:
		if panel == target_panel:
			panel.visible = not panel.visible
		else:
			panel.hide()


# NEW GAME
func _on_new_game_ok_pressed(cube_size: int, scrambling_moves: int) -> void:
	config.cube_size = cube_size
	config.scrambling_moves = scrambling_moves
	config.save()
	new_game.emit(cube_size, scrambling_moves)
	%NewGame.disabled = true


func on_rotating_done() -> void:
	%NewGame.disabled = false


func _on_new_game_pressed() -> void:
	new_game_panel.init(config.cube_size, config.scrambling_moves)
	toggle_panel(new_game_panel)
	button_click.emit()


# OPTIONS
func _on_options_ok_pressed(animation_length: float) -> void:
	config.animation_length = animation_length
	config.save()
	button_click.emit()


func _on_options_pressed() -> void:
	options_panel.init(config.animation_length)
	toggle_panel(options_panel)
	button_click.emit()


# INFOS
func _on_infos_pressed() -> void:
	toggle_panel(infos_panel)
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
