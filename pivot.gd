extends Node3D

const ROTATION_ANGLE: float = -PI/2
const TWEEN_DURATION: float = 0.25

var previous_angle: float = 0.0


func tween_rotate(axis: Vector3) -> Tween:
	var tween = create_tween()
	tween.tween_method(_rotate_inner.bind(axis), 0.0, ROTATION_ANGLE, TWEEN_DURATION)
	return tween


func _rotate_inner(new_angle: float, axis: Vector3) -> void:
	rotate(axis, new_angle - previous_angle)
	previous_angle = new_angle


func reset() -> void:
	previous_angle = 0.0
	%Pivot.transform.basis = Basis()
