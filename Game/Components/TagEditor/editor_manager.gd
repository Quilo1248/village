extends HBoxContainer

@onready var tag: Button = $TagColorManager/Tag
@onready var description: TextEdit = $TagTitlesManager/Description


func _on_title_text_changed(new_text: String) -> void:
	tag.title = new_text
	tag.update_tag()


func _on_description_text_changed() -> void:
	tag.description = description.text
	tag.update_tag()
