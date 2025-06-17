extends VBoxContainer

var current_color := Color.BLACK
@onready var color_picker_button: ColorPickerButton = $ColorPickerButton
@onready var quick_hex: ColorPicker = $QuickHex


func _on_color_picker_button_color_changed(color: Color) -> void:
	if quick_hex.color != color:
		quick_hex.color = color


func _on_quick_hex_color_changed(color: Color) -> void:
	if color_picker_button.color != color:
		color_picker_button.color = color
