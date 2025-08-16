extends Camera3D

@export var zoom_in_button: Button
const MOUSE_SENSITIVITY: float = 0.5
const BUTTON_SENSITIVITY: float = 2
const Z_CLAMP: Vector2 = Vector2(3, 20)


func _unhandled_input(_event: InputEvent) -> void:
	## Handle zoom
	if Input.is_action_just_pressed("MWU"):
		position.z -= MOUSE_SENSITIVITY
	if Input.is_action_just_pressed("MWD"):
		position.z += MOUSE_SENSITIVITY
	# Prevent zooming past the cube
	position.z = clamp(position.z, Z_CLAMP.x, Z_CLAMP.y)


func zoom(direction: int) -> void:
	position.z += direction * BUTTON_SENSITIVITY
