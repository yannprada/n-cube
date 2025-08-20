extends Node3D

const ARROW_SCENE: PackedScene = preload("res://scenes/game/world/arrows/arrow.tscn")
const VISIBILITY_ANGLE: float = PI/2.5

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
	for arrow in get_children():
		var normal = %CameraPivot.to_local(arrow.normal)
		arrow.visible = normal.angle_to(Vector3.BACK) < VISIBILITY_ANGLE
