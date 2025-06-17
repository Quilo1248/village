extends VBoxContainer

signal color_changed(color : Color)
@export var default_color : Color
var current_color := Color.BLACK

@onready var color_picker_button: ColorPickerButton = $ColorPickerButton
@onready var quick_hex: ColorPicker = $QuickHex


func _ready() -> void:
	current_color = default_color
	quick_hex.color = default_color
	color_picker_button.color = default_color

func _on_color_picker_button_color_changed(color: Color) -> void:
	if quick_hex.color != color:
		quick_hex.color = color
		emit_signal("color_changed", color)


func _on_quick_hex_color_changed(color: Color) -> void:
	if color_picker_button.color != color:
		color_picker_button.color = color
		emit_signal("color_changed", color)
