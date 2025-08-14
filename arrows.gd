extends Node3D

const ARROW_SCENE: PackedScene = preload("res://arrow.tscn")
const size: int = 3

signal clicked(layer: Vector3, rotation_axis: Vector3)


func add_arrows(block_pos: Vector3, faces_normals: Array[Vector3i]) -> void:
	for normal in faces_normals:
		for direction in faces_normals:
			if normal == direction:
				continue
			var arrow = ARROW_SCENE.instantiate()
			add_child(arrow)
			arrow.post_init(block_pos, normal, direction)
			arrow.clicked.connect(on_clicked)


func on_clicked(layer: Vector3, rotation_axis: Vector3):
	clicked.emit(layer, rotation_axis)
