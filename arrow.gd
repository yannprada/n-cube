extends Area3D

const ARROW_ON: Resource = preload("res://material/arrow_on.tres")
const ARROW_OFF: Resource = preload("res://material/arrow_off.tres")


func _on_mouse_entered() -> void:
	%Mesh.mesh.material = ARROW_ON


func _on_mouse_exited() -> void:
	%Mesh.mesh.material = ARROW_OFF


func _on_input_event(camera: Node, event: InputEvent, event_position: Vector3, normal: Vector3, shape_idx: int) -> void:
	print(event)
