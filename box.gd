extends Node3D

const SQUARE_SCENE: PackedScene = preload("res://square.tscn")


func post_init(at: Vector3, faces_coords: Array[Vector3i]) -> void:
	position = at
	for coords in faces_coords:
		var square = SQUARE_SCENE.instantiate()
		add_child(square)
		square.post_init(coords)


func add_side(coords: Vector3, rot: Vector3, color: Resource) -> void:
	var square = SQUARE_SCENE.instantiate()
	add_child(square)
	square.post_init(coords, rot, color)
