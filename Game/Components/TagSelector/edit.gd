extends Button

@onready var tag_selector: CanvasLayer = $"../../../.."
@onready var tag_editor: CanvasLayer = $"../../TagEditor"

func _on_pressed() -> void:
	tag_editor.default_title = tag_selector.selected_tags[0].title
	tag_editor.default_description = tag_selector.selected_tags[0].description
	tag_editor.default_background_color = tag_selector.selected_tags[0].background_color
	tag_editor.default_text_color = tag_selector.selected_tags[0].text_color
	tag_editor.default_tag = tag_selector.selected_tags[0]
	
	tag_editor.popup()


func _on_tag_editor_selected(canceled: bool, title: String, description: String, background_color: Color, text_color: Color) -> void:
	if not canceled:
		if tag_selector.selected_tags.size() == 1:
			tag_selector.selected_tags[0].title = title
			tag_selector.selected_tags[0].description = description
			tag_selector.selected_tags[0].background_color = background_color
			tag_selector.selected_tags[0].text_color = text_color
			
			SaveLoad._save()
			tag_selector.refresh()
