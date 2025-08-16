extends Node3D

const AXES = [Vector3.UP, Vector3.DOWN, Vector3.LEFT, Vector3.RIGHT, Vector3.BACK, Vector3.FORWARD]

var exterior_positions: Array[Vector3]


func set_tween_duration(tween_duration: float) -> void:
	%Pivot.tween_duration = tween_duration


func zoom(direction: int) -> void:
	%Camera.zoom(direction)


func generate(size: int = 3) -> void:
	## Generate a Rubik's Cube and the Arrows to manipulate it.
	exterior_positions = []
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
				if len(faces_normals) > 0:
					exterior_positions.append(pos)


func scramble(moves: int) -> void:
	if %RubiksCube.get_child_count() == 0:
		return
	
	for n in moves:
		var pos = exterior_positions[randi_range(0, exterior_positions.size()-1)]
		var axis = AXES[randi_range(0, AXES.size()-1)]
		var layer = pos * axis.abs()
		var tween = %RubiksCube.rotate_layer(layer, axis)
		await tween.finished


func clear() -> void:
	%RubiksCube.clear()
	%Arrows.clear()
