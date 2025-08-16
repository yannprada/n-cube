extends HSlider

@export var message: String = 'Value: %f'


func _ready() -> void:
	_update_label(value)


func _on_value_changed(_value: float) -> void:
	_update_label(_value)


func _update_label(_value: float) -> void:
	%Label.text = message % _value
