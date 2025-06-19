extends CanvasLayer

const TAG = preload("res://Game/Components/Tag/tag.tscn")
@onready var tags_container: HFlowContainer = $Panel/VBoxContainer/ScrollTags/TagsContainer


func popup():
	refresh()
	show()


func _on_x_pressed() -> void:
	hide()


func refresh():
	for child in tags_container.get_children():
		if child.is_in_group("tag"):
			child.queue_free()
	
	SaveLoad._load()
	var tags = SaveLoad.SaveFileData.tags
	
	for i in tags.size():
		var tag = TAG.instantiate()
		tag.title = tags[i].title
		tag.description = tags[i].description
		tag.background_color = tags[i].background_color
		tag.text_color = tags[i].text_color
		
		tags_container.add_child(tag)


func _on_tag_editor_tag_created() -> void:
	refresh()
