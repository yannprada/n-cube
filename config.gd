@export_range(2, 10) var cube_size: int = 3
@export_range(0, 100) var scrambling_moves: int = 25
@export_range(0, 2) var animation_length: float = 0.25


func _init(c = 3, m = 25, d = 0.25) -> void:
	cube_size = c
	scrambling_moves = m
	animation_length = d


func get_scramble_time() -> float:
	return scrambling_moves * animation_length
