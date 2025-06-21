extends CanvasLayer

const TAG = preload("res://Game/Components/Tag/tag.tscn")
var selected_tags : Array[Tag]
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
		tag.index = i
		tag.tag = tags[i]
		
		tag.toggled_tag.connect(button_child_toggled)
		tags_container.add_child(tag)


func _on_tag_editor_tag_created() -> void:
	refresh()


func button_child_toggled(toggled : bool, tag : Tag):
	
	if toggled:
		selected_tags.append(tag)
	else:
		selected_tags.erase(tag)
	
	print(selected_tags)
