extends CanvasLayer

const TAG = preload("res://Game/Components/Tag/tag.tscn")
var selected_tags : Array[Dictionary]
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
		tag.index = i
		
		tag.toggled_tag.connect(button_child_toggled)
		tags_container.add_child(tag)


func _on_tag_editor_tag_created() -> void:
	refresh()


func button_child_toggled(toggled : bool, index : int, title : String):
	var tag_dictionary = {
		"Index" : index,
		"Title" : title
}
	
	if toggled:
		selected_tags.append(tag_dictionary)
	else:
		selected_tags.erase(tag_dictionary)
	
	print(selected_tags)
