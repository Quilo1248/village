extends CanvasLayer

signal selected(canceled : bool, title : String, description : String, background_color : Color, text_color : Color)
signal tag_created
@onready var title: LineEdit = $darken/Panel/VBoxContainer/EditorManager/TagTitlesManager/Title
@onready var description: TextEdit = $darken/Panel/VBoxContainer/EditorManager/TagTitlesManager/Description
@onready var background_color_picker_hex: VBoxContainer = $darken/Panel/VBoxContainer/EditorManager/TagColorManager/BackgroundColor/BackgroundColorPickerHex
@onready var text_color_picker_hex: VBoxContainer = $darken/Panel/VBoxContainer/EditorManager/TagColorManager/TextColor/TextColorPickerHex
@onready var tag: Button = $darken/Panel/VBoxContainer/EditorManager/TagColorManager/Tag


func popup():
	title.clear()
	title.text = "Tag"
	description.clear()
	background_color_picker_hex.reset()
	text_color_picker_hex.reset()
	tag.update_tag()
	show()


func _on_cancel_pressed() -> void:
	emit_signal("selected", true, "", "", Color.BLACK, Color.WHITE)
	hide()


func _on_save_pressed() -> void:
	emit_signal("selected", false, title.text, description.text, background_color_picker_hex.current_color, text_color_picker_hex.current_color)
	emit_signal("tag_created")
	hide()
