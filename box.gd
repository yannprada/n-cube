extends Node3D

const SQUARE_SCENE: PackedScene = preload("res://square.tscn")

signal drag(box: Node3D, square: Node3D, direction: Vector2)


func post_init(at: Vector3, size: Vector3, faces_coords: Array[Vector3i]) -> void:
	position = at
	scale = size
	for coords in faces_coords:
		var square = SQUARE_SCENE.instantiate()
		add_child(square)
		square.post_init(coords)
		square.drag.connect(on_square_drag)


func add_side(coords: Vector3, rot: Vector3, color: Resource) -> void:
	var square = SQUARE_SCENE.instantiate()
	add_child(square)
	square.post_init(coords, rot, color)
	square.drag.connect(on_square_drag)


func on_square_drag(square: Node3D, direction: Vector2i):
	drag.emit(self, square, direction)
