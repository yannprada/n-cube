extends Node3D

const MOUSE_SENSITIVITY: float = 0.01


func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		if Input.is_mouse_button_pressed(MOUSE_BUTTON_RIGHT):
			# Rotate the cube according to mouse movements
			var axis = Vector3(-event.relative.y, -event.relative.x, 0)
			var angle = axis.distance_to(Vector3.ZERO) * MOUSE_SENSITIVITY
			rotate_object_local(axis.normalized(), angle)
