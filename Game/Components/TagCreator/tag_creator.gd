extends Button

@export var TagCreator : CanvasLayer


func _on_pressed() -> void:
	TagCreator.popup()


func _on_tag_editor_selected(canceled: bool, title: String, description: String, background_color: Color, text_color: Color) -> void:
	if canceled:
		return
	else:
		var new_tag = Tag.new()
		new_tag.title = title
		new_tag.description = description
		new_tag.background_color = background_color
		new_tag.text_color = text_color
		new_tag.pinned = true
		
		SaveLoad.SaveFileData.tags.append(new_tag)
		SaveLoad._save()
