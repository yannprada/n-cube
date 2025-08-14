extends Node3D


func _ready() -> void:
	generate()


func generate(size: int = 3) -> void:
	## Generate a Rubik's Cube and the Arrows to manipulate it.
	var offset = (size / 2.0 - 0.5) * -1
	for i in size:
		for j in size:
			for k in size:
				var faces_normals: Array[Vector3i] = []
				var values = {0: -1, size-1: 1}
				for n in values:
					if i == n:
						faces_normals.append(Vector3i(values[n], 0, 0))
					if j == n:
						faces_normals.append(Vector3i(0, values[n], 0))
					if k == n:
						faces_normals.append(Vector3i(0, 0, values[n]))
				var pos = Vector3(i + offset, j + offset, k + offset)
				%RubiksCube.add_box(pos, faces_normals)
				if len(faces_normals) > 1:
					%Arrows.add_arrows(pos, faces_normals)
