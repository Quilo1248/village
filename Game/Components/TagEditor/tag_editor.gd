extends CanvasLayer

signal selected(canceled : bool, title : String, description : String, background_color : Color, text_color : Color)
signal tag_created

@export var default_tag : Tag
@export var default_title := ""
@export var default_description := ""
@export var default_background_color := Color.BLACK
@export var default_text_color := Color.WHITE

@onready var title: LineEdit = $darken/Panel/VBoxContainer/EditorManager/TagTitlesManager/Title
@onready var description: TextEdit = $darken/Panel/VBoxContainer/EditorManager/TagTitlesManager/Description
@onready var background_color_picker_hex: VBoxContainer = $darken/Panel/VBoxContainer/EditorManager/TagColorManager/BackgroundColor/BackgroundColorPickerHex
@onready var text_color_picker_hex: VBoxContainer = $darken/Panel/VBoxContainer/EditorManager/TagColorManager/TextColor/TextColorPickerHex
@onready var tag: Button = $darken/Panel/VBoxContainer/EditorManager/TagColorManager/Tag


func popup():
	reset_all()
	show()


func _on_cancel_pressed() -> void:
	emit_signal("selected", true, "", "", Color.BLACK, Color.WHITE)
	hide()


func _on_save_pressed() -> void:
	emit_signal("selected", false, title.text, description.text, background_color_picker_hex.current_color, text_color_picker_hex.current_color)
	emit_signal("tag_created")
	hide()


func reset_all():
	#color pickers
	background_color_picker_hex.default_color = default_background_color
	background_color_picker_hex.reset()
	text_color_picker_hex.default_color = default_text_color
	text_color_picker_hex.reset()
	#text
	title.clear()
	title.text = default_title
	description.clear()
	description.text = default_description
	#tag display
	tag.tag = default_tag
	tag.update_tag()
