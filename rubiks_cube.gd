extends Node3D

const BOX_SCENE: PackedScene = preload("res://box.tscn")
const POS_ACCURACY: float = 0.1
const ROTATION_ANGLE: float = -PI/2
const TWEEN_DURATION: float = 0.25
var previous_angle: float = 0


func add_box(pos: Vector3, faces_normals: Array[Vector3i]) -> void:
	var box = BOX_SCENE.instantiate()
	%Boxes.add_child(box)
	box.post_init(pos, faces_normals)


func rotate_layer(layer: Vector3, axis: Vector3) -> void:
	# Move the layer of boxes to Pivot
	for box in %Boxes.get_children():
		if (
			(abs(axis.x) > 0 and abs(box.position.x - layer.x) < POS_ACCURACY) or 
			(abs(axis.y) > 0 and abs(box.position.y - layer.y) < POS_ACCURACY) or 
			(abs(axis.z) > 0 and abs(box.position.z - layer.z) < POS_ACCURACY)
		):
			box.reparent(%Pivot)
	
	# Animate the rotation
	var tween = create_tween()
	tween.tween_method(rotate_pivot.bind(axis), 0.0, ROTATION_ANGLE, TWEEN_DURATION)
	#TODO disable Arrows
	await tween.finished
	previous_angle = 0
	
	# Move the boxes back
	for box in %Pivot.get_children():
		box.reparent(%Boxes)
	
	# Reset Pivot
	%Pivot.transform.basis = Basis()


func rotate_pivot(new_angle: float, axis: Vector3) -> void:
	%Pivot.rotate(axis, new_angle - previous_angle)
	previous_angle = new_angle


func _on_arrows_clicked(layer: Vector3, rotation_axis: Vector3) -> void:
	rotate_layer(layer, rotation_axis)
