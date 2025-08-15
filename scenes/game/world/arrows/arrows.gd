extends Node3D

const ARROW_SCENE: PackedScene = preload("res://scenes/game/world/arrows/arrow.tscn")
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


func clear() -> void:
	for arrow in get_children():
		arrow.queue_free()


func _process(_delta: float) -> void:
	## Hide arrows that are on the other side of the origin, relative to the camera
	var cam_dist_origin = %Camera.global_position.distance_to(Vector3.ZERO)
	for arrow in get_children():
		var pos = %Camera.to_local(arrow.global_position)
		var diff = cam_dist_origin + pos.z
		arrow.visible = diff > 0
