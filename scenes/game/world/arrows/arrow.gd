extends Area3D

const ARROW_ON: Resource = preload("res://material/arrow_on.tres")
const ARROW_OFF: Resource = preload("res://material/arrow_off.tres")
const DIRECTION_MULT: float = .3
const NORMAL_MULT: float = .55
const SCALE_MULT: float = .4

var layer: Vector3
var normal: Vector3
var rotation_axis: Vector3

signal clicked(layer: Vector3, rotation_axis: Vector3)


func post_init(block_pos: Vector3, _normal: Vector3, direction: Vector3) -> void:
	normal = _normal
	rotation_axis = direction.cross(normal)
	layer = block_pos * rotation_axis.abs()
	position = block_pos + (direction * DIRECTION_MULT) + (normal * NORMAL_MULT)
	basis = Basis(direction, rotation_axis, normal)
	scale *= SCALE_MULT


func _on_input_event(_camera: Node, event: InputEvent, _event_position: Vector3, 
		_normal: Vector3, _shape_idx: int) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			clicked.emit(layer, rotation_axis)
			%Mesh.mesh.material = ARROW_ON
		else:
			%Mesh.mesh.material = ARROW_OFF


func _on_mouse_exited() -> void:
	%Mesh.mesh.material = ARROW_OFF
