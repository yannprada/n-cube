extends Node3D

const ARROW_SCENE: PackedScene = preload("res://arrow.tscn")
const size: int = 3


#func _ready() -> void:
	## Create one arrow for each face(6), layer(6), direction(2)
	#for vector in [
		#Vector3i.UP, Vector3i.DOWN, 
		#Vector3i.LEFT, Vector3i.RIGHT, 
		#Vector3i.BACK, Vector3i.FORWARD
	#]:
		#for vector2 in [
			#Vector3i.UP, Vector3i.DOWN, 
			#Vector3i.LEFT, Vector3i.RIGHT, 
			#Vector3i.BACK, Vector3i.FORWARD
		#]:
			#var normal = vector.cross(vector2)
			#print(normal)
