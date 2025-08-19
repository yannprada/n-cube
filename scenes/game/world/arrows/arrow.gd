extends Area3D

const ARROW_ON: Resource = preload("res://material/arrow_on.tres")
const ARROW_OFF: Resource = preload("res://material/arrow_off.tres")

var layer: Vector3
var normal: Vector3
var rotation_axis: Vector3

signal clicked(layer: Vector3, rotation_axis: Vector3)


func post_init(block_pos: Vector3, _normal: Vector3, direction: Vector3) -> void:
	normal = _normal
	position = block_pos + (direction * 0.9) + (normal * 0.5)
	rotation_axis = direction.cross(normal)
	layer = block_pos * rotation_axis.abs()
	basis = Basis(direction, rotation_axis, normal)


func _on_mouse_entered() -> void:
	%Mesh.mesh.material = ARROW_ON


func _on_mouse_exited() -> void:
	%Mesh.mesh.material = ARROW_OFF


func _on_input_event(_camera: Node, event: InputEvent, _event_position: Vector3, 
		_normal: Vector3, _shape_idx: int) -> void:
	if (event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and 
			event.pressed == true):
		clicked.emit(layer, rotation_axis)
