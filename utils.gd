extends Node


func get_closest_axis(vector: Vector3) -> Vector3i:
	## Get the closest axis (RIGHT, LEFT, ...) to the given vector
	
	if abs(vector.x) > max(abs(vector.y), abs(vector.z)):
		return Vector3i.RIGHT if vector.x > 0 else Vector3i.LEFT
	
	elif abs(vector.y) > max(abs(vector.x), abs(vector.z)):
		return Vector3i.UP if vector.y > 0 else Vector3i.DOWN
	
	elif abs(vector.z) > max(abs(vector.x), abs(vector.y)):
		return Vector3i.BACK if vector.z > 0 else Vector3i.FORWARD
	
	return Vector3i.ZERO
