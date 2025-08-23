extends Node

@export_range(2, 10) var cube_size: int = 3
@export_range(0, 100) var scrambling_moves: int = 25
@export_range(0, 2) var animation_length: float = 0.1
@export_range(0, 10) var cube_volume: float = 5
@export_range(0, 10) var UI_volume: float = 5

var save_file_path: String = OS.get_user_data_dir() + '/config.json'


func _ready() -> void:
	_load()


func get_scramble_time() -> float:
	return scrambling_moves * animation_length


func save() -> void:
	var json_string = JSON.stringify({
		'cube_size': cube_size,
		'scrambling_moves': scrambling_moves,
		'animation_length': animation_length,
		'cube_volume': cube_volume,
		'UI_volume': UI_volume,
	})
	var save_file = FileAccess.open(save_file_path, FileAccess.WRITE)
	save_file.store_string(json_string)


func _load() -> void:
	if not FileAccess.file_exists(save_file_path):
		return
	
	var save_file = FileAccess.open(save_file_path, FileAccess.READ)
	var json_string = save_file.get_as_text()
	if json_string is not String or json_string.length() <= 0:
		return
	
	var data = JSON.parse_string(json_string)
	if not data:
		return
	
	cube_size = data['cube_size']
	scrambling_moves = data['scrambling_moves']
	animation_length = data['animation_length']
	cube_volume = data['cube_volume']
	UI_volume = data['UI_volume']
