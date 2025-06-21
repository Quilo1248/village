extends VBoxContainer

@onready var tag: Button = $Tag


func _on_background_color_picker_hex_color_changed(color: Color) -> void:
	tag.tag.background_color = color
	update_tag()


func _on_text_color_picker_hex_color_changed(color: Color) -> void:
	tag.tag.text_color = color
	update_tag()


func update_tag():
	tag.update_tag()
