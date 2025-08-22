extends PanelContainer

@export var value: float = 0
@export var _min: float = 0
@export var _max: float = 10
@export var increment: float = 1
@export var digits: int = 0


func _ready() -> void:
	update_display()


func _on_add_pressed() -> void:
	value = clamp(value + increment, _min, _max)
	update_display()


func _on_subtract_pressed() -> void:
	value = clamp(value - increment, _min, _max)
	update_display()


func update_display() -> void:
	%ValueDisplay.text = ' %.*f ' % [digits, value]
