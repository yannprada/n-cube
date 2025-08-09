extends Node3D

var coordinates: Vector3i
var highlighted: bool = false

signal drag(square: Node3D, direction: Vector2)


func post_init(coords: Vector3i, rot: Vector3, color: Resource):
	coordinates = coords
	rotation = rot
	%Surface.set_surface_override_material(0, color)


func _on_static_body_3d_mouse_entered() -> void:
	%Highlight.show()
	highlighted = true


func _on_static_body_3d_mouse_exited() -> void:
	%Highlight.hide()
	highlighted = false


func _unhandled_input(event: InputEvent) -> void:
	## Handle dragging
	if (
		highlighted and event is InputEventMouseMotion and 
		Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT)
	):
		drag.emit(self, event.relative)
