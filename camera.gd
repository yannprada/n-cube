extends Camera3D

const zoom_sensitivity: float = 0.05
const camera_clamp: Vector2 = Vector2(1, 10)


func _unhandled_input(_event: InputEvent) -> void:
	## Handle zoom
	if Input.is_action_just_pressed("MWU"):
		position.z -= zoom_sensitivity
	if Input.is_action_just_pressed("MWD"):
		position.z += zoom_sensitivity
	# Prevent zooming past the cube
	position.z = clamp(position.z, camera_clamp.x, camera_clamp.y)
