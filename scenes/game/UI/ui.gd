extends Control

@export var new_game_panel: PanelContainer
@export var options_panel: PanelContainer
@export var infos_panel: PanelContainer

signal new_game(size: int, moves: int)
signal button_click
signal cube_clicked


func on_button_click():
	button_click.emit()


func toggle_panel(target_panel: PanelContainer) -> void:
	for panel in [new_game_panel, options_panel, infos_panel]:
		if panel == target_panel:
			panel.visible = not panel.visible
		else:
			panel.hide()


# NEW GAME
func _on_new_game_ok_pressed() -> void:
	new_game.emit(Config.cube_size, Config.scrambling_moves)
	%NewGame.disabled = true


func on_rotating_done() -> void:
	%NewGame.disabled = false


func _on_new_game_pressed() -> void:
	toggle_panel(new_game_panel)
	button_click.emit()


# OPTIONS
func _on_options_pressed() -> void:
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


func _on_cube_clicked() -> void:
	cube_clicked.emit()
