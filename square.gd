extends Node3D


const ROTATION: Dictionary[Vector3i, Vector3] = {
	Vector3(0, 0, 1): Vector3(0, 0, 0),
	Vector3(0, 0, -1): Vector3(0, PI, 0),
	Vector3(-1, 0, 0): Vector3(0, -PI/2.0, 0),
	Vector3(1, 0, 0): Vector3(0, PI/2.0, 0),
	Vector3(0, 1, 0): Vector3(-PI/2.0, 0, 0),
	Vector3(0, -1, 0): Vector3(PI/2.0, 0, 0),
}
const COLOR: Dictionary[Vector3i, Resource] = {
	Vector3(0, 0, 1): preload("res://material/red.tres"),
	Vector3(0, 0, -1): preload("res://material/orange.tres"),
	Vector3(-1, 0, 0): preload("res://material/white.tres"),
	Vector3(1, 0, 0): preload("res://material/yellow.tres"),
	Vector3(0, 1, 0): preload("res://material/blue.tres"),
	Vector3(0, -1, 0): preload("res://material/green.tres"),
}
var coordinates: Vector3i
var highlighted: bool = false

signal drag(square: Node3D, direction: Vector2)


func post_init(coords: Vector3i):
	coordinates = coords
	rotation = ROTATION[coords]
	%Surface.set_surface_override_material(0, COLOR[coords])


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
