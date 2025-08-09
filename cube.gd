extends Node3D

const mouse_sensitivity: float = 0.01
const size: int = 4
const box_size: float = 0.2
const margin: float = 0.005
const box_real_size: Vector3 = (box_size - margin) * Vector3i.ONE
const box_scene: PackedScene = preload("res://box.tscn")


func _ready() -> void:
	## Create cube regions according to configuration
	const start = (size / 2.0 - 0.5) * -1
	for i in size:
		for j in size:
			for k in size:
				add_cube(Vector3(i + start, j + start, k + start))


func add_cube(at: Vector3) -> void:
	var box = box_scene.instantiate()
	box.coordinates = at
	box.position = at * box_size
	box.scale = box_real_size
	add_child(box)
	box.drag.connect(on_box_drag)


func on_box_drag(box: Node3D, square: Node3D, direction: Vector2) -> void:
	## Find the closest basis axis to direction
	#var direction_global = Vector3(direction.x, direction.y, 0)
	#var direction_local = to_local(direction_global)
	##FIXME when rotated around X axis: local Z should be global Y
	#var direction_axis = find_closest_basis_axis(direction_local)
	# Find the perpendicular which is the axis for rotation
	var axis = Vector3(1, 0, 0)
	var angle = direction.y
	if abs(direction.x) > abs(direction.y):
		axis = Vector3(0, 1, 0)
		angle = direction.x
	print(axis, ' ', angle)
	


func find_closest_basis_axis(vector: Vector3) -> Vector3:
	var angle_min = PI * 10
	var closest_axis: Vector3
	for axis in [basis.x, basis.y, basis.z, -basis.x, -basis.y, -basis.z]:
		var angle = axis.angle_to(vector)
		if angle < angle_min:
			angle_min = angle
			closest_axis = axis
	return closest_axis


func _unhandled_input(event: InputEvent) -> void:
	if not event is InputEventMouseMotion:
		return
	
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_RIGHT):
		## Rotate the cube according to mouse movements
		var axis = Vector3(event.relative.y, event.relative.x, 0)
		var angle = axis.distance_to(Vector3.ZERO) * mouse_sensitivity
		rotate(axis.normalized(), angle)
	else:
		pass
