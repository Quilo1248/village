extends Button

@onready var tag_selector: CanvasLayer = $"../../../.."
@onready var tag_editor: CanvasLayer = $"../../TagEditor"

func _on_pressed() -> void:
	tag_editor.popup()


func _on_tag_editor_selected(canceled: bool, title: String, description: String, background_color: Color, text_color: Color) -> void:
	if not canceled:
		pass
