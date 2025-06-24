extends CanvasLayer

signal closed
const TAG = preload("res://Game/Components/Tag/tag.tscn")
var selected_tags : Array[Tag]
@onready var tags_container: HFlowContainer = $Panel/VBoxContainer/ScrollTags/TagsContainer
@onready var selected_tags_display: VBoxContainer = $"../SelectedTagsDisplay"
@onready var donut_timer: AspectRatioContainer = $"../DonutTimer"


func popup():
	refresh()
	show()


func _on_x_pressed() -> void:
	selected_tags_display.selected_tags = selected_tags
	selected_tags_display.update_displays()
	donut_timer.tags = selected_tags
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
		if tags[i] in selected_tags:
			tag.button_pressed = true
		
		tag.toggled_tag.connect(button_child_toggled)
		tags_container.add_child(tag)


func _on_tag_editor_tag_created() -> void:
	refresh()


func button_child_toggled(toggled : bool, tag : Tag):
	
	if toggled:
		selected_tags.append(tag)
	else:
		selected_tags.erase(tag)
	


func _on_trash_pressed() -> void:
	var t = get_used_and_unused_tags()
	
	if all_in(selected_tags, t.unused):
		print("pass")
	else: print("nuh uh")


func get_used_and_unused_tags() -> Dictionary:
	SaveLoad._load()
	var all_tags: Array[Tag] = SaveLoad.SaveFileData.tags
	var all_sessions: Array[Session] = SaveLoad.SaveFileData.sessions
	
	var used_tags := {} # Dictionary as a set this allows us to get constant time
	
	for session in all_sessions:
		for tag in session.tags:
			used_tags[tag] = true
	
	var used := []
	var unused := []
	
	for tag in all_tags:
		if used_tags.has(tag):
			used.append(tag)
		else:
			unused.append(tag)
	
	return {
		"used": used,
		"unused": unused
	}


func all_in(listA: Array, listB: Array) -> bool:
	var dictB = {}
	for item in listB:
		dictB[item] = true
	for item in listA:
		if not dictB.has(item):
			return false
	return true
