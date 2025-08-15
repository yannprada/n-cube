extends Node3D

const SQUARE_SCENE: PackedScene = preload("res://scenes/game/world/box/square/square.tscn")


func post_init(at: Vector3, faces_normals: Array[Vector3i]) -> void:
	position = at
	for normals in faces_normals:
		var square = SQUARE_SCENE.instantiate()
		add_child(square)
		square.post_init(normals)
