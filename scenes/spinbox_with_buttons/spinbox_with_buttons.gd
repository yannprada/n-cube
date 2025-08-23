extends HBoxContainer

@export var value: float = 0:
	set = set_value
@export var _min: float = 0
@export var _max: float = 10
@export var increment: float = 1
@export var digits: int = 0

signal button_clicked
signal value_changed(value: float)


func set_value(new_value: float) -> void:
	value = clamp(new_value, _min, _max)
	update_display()
	value_changed.emit(value)


func _on_add_pressed() -> void:
	value += increment
	button_clicked.emit()


func _on_subtract_pressed() -> void:
	value -= increment
	button_clicked.emit()


func update_display() -> void:
	%ValueDisplay.text = '%.*f' % [digits, value]
