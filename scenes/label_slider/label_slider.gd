extends VBoxContainer

@export var title: String
@export var value: float = 0
@export var _min: float = 0
@export var _max: float = 10
@export var increment: float = 1
@export var rounded: bool


func _ready() -> void:
	%Title.text = title
	%HSlider.value = value
	%HSlider.min_value = _min
	%HSlider.max_value = _max
	%HSlider.step = increment
	%HSlider.rounded = rounded
	update_display()


func _on_value_changed(_value: float) -> void:
	value = _value
	update_display()


func update_display() -> void:
	if rounded:
		%ValueDisplay.text = '%d' % [value]
	else:
		%ValueDisplay.text = '%f' % [value]
