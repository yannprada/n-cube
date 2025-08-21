extends HBoxContainer

@export var _name: String = '<Name>:'
@export var value: float = 0
@export var value_min: float = 0
@export var value_max: float = 10
@export var value_increment: float = 1
@export var value_digits: int = 0


func _ready() -> void:
	%Name.text = _name
	update_display()


func _on_add_pressed() -> void:
	value += value_increment
	value = min(value, value_max)
	update_display()


func _on_subtract_pressed() -> void:
	value -= value_increment
	value = max(value, value_min)
	update_display()


func update_display() -> void:
	%ValueDisplay.text = '%.*f' % [value_digits, value]
