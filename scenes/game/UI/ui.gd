extends Control

@export var new_game_panel: PanelContainer
@export var options_panel: PanelContainer
@export var infos_panel: PanelContainer

signal new_game(size: int, moves: int)
signal button_click


func _ready() -> void:
	new_game_panel.init(Config.cube_size, Config.scrambling_moves)
	AudioServer.set_bus_volume_linear(AudioServer.get_bus_index("Cube"), Config.cube_volume)
	AudioServer.set_bus_volume_linear(AudioServer.get_bus_index("UI"), Config.UI_volume)
	options_panel.init(Config.animation_length, Config.cube_volume, Config.UI_volume)


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
	Config.cube_size = cube_size
	Config.scrambling_moves = scrambling_moves
	Config.save()
	new_game.emit(cube_size, scrambling_moves)
	%NewGame.disabled = true


func on_rotating_done() -> void:
	%NewGame.disabled = false


func _on_new_game_pressed() -> void:
	new_game_panel.init(Config.cube_size, Config.scrambling_moves)
	toggle_panel(new_game_panel)
	button_click.emit()


# OPTIONS
func _on_options_ok_pressed(animation_length: float) -> void:
	Config.animation_length = animation_length
	Config.save()
	button_click.emit()


func _on_options_pressed() -> void:
	options_panel.init(Config.animation_length, Config.cube_volume, Config.UI_volume)
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


func _on_options_panel_cube_volume_changed(value: float) -> void:
	AudioServer.set_bus_volume_linear(AudioServer.get_bus_index("Cube"), value)
	Config.cube_volume = value
	Config.save()


func _on_options_panel_ui_volume_changed(value: float) -> void:
	AudioServer.set_bus_volume_linear(AudioServer.get_bus_index("UI"), value)
	Config.UI_volume = value
	Config.save()
