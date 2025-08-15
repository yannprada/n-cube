extends Node3D

const BOX_SCENE: PackedScene = preload("res://box.tscn")
const POS_ACCURACY: float = 0.1

var is_rotating: bool = false


func add_box(pos: Vector3, faces_normals: Array[Vector3i]) -> void:
	var box = BOX_SCENE.instantiate()
	%Boxes.add_child(box)
	box.post_init(pos, faces_normals)


func rotate_layer(layer: Vector3, axis: Vector3) -> Tween:
	if is_rotating:
		return
	
	# Prevent other rotations at the same time
	is_rotating = true
	
	# Move the layer of boxes to Pivot
	for box in %Boxes.get_children():
		if (
			(abs(axis.x) > 0 and abs(box.position.x - layer.x) < POS_ACCURACY) or 
			(abs(axis.y) > 0 and abs(box.position.y - layer.y) < POS_ACCURACY) or 
			(abs(axis.z) > 0 and abs(box.position.z - layer.z) < POS_ACCURACY)
		):
			box.reparent(%Pivot)
	
	# Animate the rotation
	var tween = %Pivot.tween_rotate(axis)
	tween.tween_callback(rotation_callback)
	return tween


func rotation_callback() -> void:
	# Move the boxes back
	for box in %Pivot.get_children():
		box.reparent(%Boxes)
	
	# Reset
	%Pivot.reset()
	is_rotating = false


func clear() -> void:
	for box in %Boxes.get_children():
		box.queue_free()
	for box in %Pivot.get_children():
		box.queue_free()


func _on_arrows_clicked(layer: Vector3, rotation_axis: Vector3) -> void:
	rotate_layer(layer, rotation_axis)
