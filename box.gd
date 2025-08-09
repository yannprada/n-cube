extends Node3D

const SQUARE_SCENE: PackedScene = preload("res://square.tscn")
const MATERIAL: Dictionary[String, Resource] = {
	'blue': preload("res://material/blue.tres"),
	'green': preload("res://material/green.tres"),
	'orange': preload("res://material/orange.tres"),
	'red': preload("res://material/red.tres"),
	'white': preload("res://material/white.tres"),
	'yellow': preload("res://material/yellow.tres"),
}
var coordinates: Vector3

signal drag(box: Node3D, square: Node3D, direction: Vector2)


func _ready() -> void:
	add_side(Vector3(0, 0, 1), Vector3(0, 0, 0), MATERIAL.red)
	add_side(Vector3(0, 0, -1), Vector3(0, PI, 0), MATERIAL.orange)
	add_side(Vector3(-1, 0, 0), Vector3(0, -PI/2.0, 0), MATERIAL.white)
	add_side(Vector3(1, 0, 0), Vector3(0, PI/2.0, 0), MATERIAL.yellow)
	add_side(Vector3(0, 1, 0), Vector3(-PI/2.0, 0, 0), MATERIAL.blue)
	add_side(Vector3(0, -1, 0), Vector3(PI/2.0, 0, 0), MATERIAL.green)


func add_side(coords: Vector3, rot: Vector3, color: Resource) -> void:
	var square = SQUARE_SCENE.instantiate()
	add_child(square)
	square.post_init(coords, rot, color)
	square.drag.connect(on_square_drag)


func on_square_drag(square: Node3D, direction: Vector2i):
	drag.emit(self, square, direction)
