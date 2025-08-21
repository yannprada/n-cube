extends Camera3D

const BUTTON_SENSITIVITY: float = 0.1
const Z_MIN: float = 3
const Z_MAX: float = 20


func _process(_delta: float) -> void:
	if Input.is_action_pressed("Zoom In"):
		position.z -= BUTTON_SENSITIVITY
	if Input.is_action_pressed("Zoom Out"):
		position.z += BUTTON_SENSITIVITY
	
	position.z = clamp(position.z, Z_MIN, Z_MAX)
