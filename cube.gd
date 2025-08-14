extends Node3D

const MOUSE_SENSITIVITY: float = 0.03
const SIZE: int = 3
const OFFSET = (SIZE / 2.0 - 0.5) * -1
const POS_CHECK_MARGIN: float = 0.1
const BOX_SCENE: PackedScene = preload("res://box.tscn")
var boxes: Dictionary[Vector3, Node3D] = {}
var first_intersect: Intersect
var rot_axis: Vector3i
var rot_total: float
var rot_boxes:Array[Node3D]
var is_dragging: bool = false


class Intersect:
	var square: Node3D
	var box: Node3D
	var normal: Vector3
	var pos: Vector3
	
	func _init(result):
		square = result.collider.get_parent().get_parent()
		box = square.get_parent()
		normal = result.normal
		pos = result.position
	
	func direction_to(other: Intersect) -> Vector3:
		return pos.direction_to(other.pos)
	
	func length(other: Intersect) -> float:
		return (pos - other.pos).length()


func _ready() -> void:
	## Create cube regions according to configuration
	for i in SIZE:
		for j in SIZE:
			for k in SIZE:
				add_box(i, j, k)


func add_box(i: int, j: int, k: int) -> void:
	var faces_normals: Array[Vector3i] = []
	var numbers = [0, SIZE-1]
	var values = [-1, 1]
	for a in 2:
		if i == numbers[a]:
			faces_normals.append(Vector3i(values[a], 0, 0))
		if j == numbers[a]:
			faces_normals.append(Vector3i(0, values[a], 0))
		if k == numbers[a]:
			faces_normals.append(Vector3i(0, 0, values[a]))
	var pos = Vector3(i + OFFSET, j + OFFSET, k + OFFSET)
	var box = BOX_SCENE.instantiate()
	box.post_init(pos, faces_normals)
	add_child(box)
	boxes[pos] = box


func reset():
	rot_total = 0
	is_dragging = false
	first_intersect = null
	rot_axis = Vector3i.ZERO
	for box in rot_boxes:
		box.reparent(self)
	%Pivot.transform.basis = Basis()
	boxes = {}
	for box in get_children():
		boxes[box.position] = box


#func _unhandled_input(event: InputEvent) -> void:
	#if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		#if event.is_pressed():
			#var intersect = get_intersect()
			#if intersect:
				#first_intersect = intersect
			#return
		#
		#if event.is_released():
			## align Pivot
			#if rot_total > 3*PI/4:
				#%Pivot.transform.basis = Basis().rotated(rot_axis, PI)
			#elif rot_total > PI/4:
				#%Pivot.transform.basis = Basis().rotated(rot_axis, PI/2)
			#else:
				#%Pivot.transform.basis = Basis()
			#reset()
			#return
#
	#if event is InputEventMouseMotion:
		#if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) and first_intersect:
			#if is_dragging:
				#%Pivot.rotate(rot_axis, MOUSE_SENSITIVITY)
				#rot_total += MOUSE_SENSITIVITY
				#return
			#
			#var intersect = get_intersect()
			#if intersect:
				#if first_intersect.length(intersect) < 1:
					## distance between first click and this event < cube size
					#return
				#
				#var direction = first_intersect.direction_to(intersect)
				#var axis = Utils.get_closest_axis(to_local(direction))
				#if axis == Vector3i.ZERO:
					#return
				#rot_axis = Vector3(axis).cross(-to_local(intersect.normal))
				#rot_boxes = get_boxes(rot_axis, intersect.box)
				## reparent boxes
				#for box in rot_boxes:
					#box.reparent(%Pivot)
				#is_dragging = true
				#return


func get_intersect() -> Intersect:
	var space_state = get_world_3d().direct_space_state
	var mousepos = get_viewport().get_mouse_position()
	
	var origin = %Camera.project_ray_origin(mousepos)
	var end = origin + %Camera.project_ray_normal(mousepos) * %Camera.position.z
	var query = PhysicsRayQueryParameters3D.create(origin, end)
	query.collide_with_areas = true
	
	var result = space_state.intersect_ray(query)
	return Intersect.new(result) if result else null


func get_boxes(axis: Vector3i, box: Node3D) -> Array[Node3D]:
	var pos = box.position
	var result: Array[Node3D] = []
	for vec in boxes:
		# are vec and pos on the same plane, defined by axis as the normal
		if (
			(abs(axis.x) > 0 and abs(vec.x - pos.x) < POS_CHECK_MARGIN) or 
			(abs(axis.y) > 0 and abs(vec.y - pos.y) < POS_CHECK_MARGIN) or 
			(abs(axis.z) > 0 and abs(vec.z - pos.z) < POS_CHECK_MARGIN)
		):
			result.append(boxes[vec])
	return result
