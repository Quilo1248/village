extends CanvasLayer

signal closed
const TAG = preload("res://Game/Components/Tag/tag.tscn")
var selected_tags : Array[Tag]
@onready var tags_container: HFlowContainer = $Panel/VBoxContainer/ScrollTags/TagsContainer
@onready var favorite_tags_container: HBoxContainer = $Panel/VBoxContainer/ScrollFavoriteTags/FavoriteTagsContainer
@onready var edit: Button = $Panel/VBoxContainer/ActionsBar/Edit
# external
@onready var selected_tags_display: VBoxContainer = $"../StackComponents/SelectedTagsDisplay"
@onready var donut_timer: AspectRatioContainer = $"../StackComponents/DonutTimer"


func popup():
	refresh()
	show()


func _on_x_pressed() -> void:
	selected_tags_display.selected_tags = selected_tags
	selected_tags_display.update_displays()
	donut_timer.tags = selected_tags
	hide()


func refresh():
	# wipe previous children
	for child in tags_container.get_children():
		if child.is_in_group("tag"):
			child.queue_free()
	
	for child in favorite_tags_container.get_children():
		if child.is_in_group("tag"):
			child.queue_free()
	# get tags
	SaveLoad._load()
	var tags = SaveLoad.SaveFileData.tags
	
	# spawn in all tags
	var pinned_tags : Array[Button]
	
	for i in tags.size():
		var tag = TAG.instantiate()
		tag.index = i
		tag.tag = tags[i]
		if tags[i] in selected_tags:
			tag.button_pressed = true
		
		if tag.tag.pinned:
			var p_tag = TAG.instantiate()
			p_tag.index = i
			p_tag.tag = tags[i]
			p_tag.button_pressed = tag.button_pressed
			
			tag.toggled.connect(Callable(p_tag, "connected_tag_toggled"))
			p_tag.toggled.connect(Callable(tag, "connected_tag_toggled"))
			
			favorite_tags_container.add_child(p_tag)
			pinned_tags.append(tag)
		
		tag.toggled_tag.connect(button_child_toggled)
		tags_container.add_child(tag)
	


func _on_tag_editor_tag_created() -> void:
	refresh()


func button_child_toggled(toggled : bool, tag : Tag):
	
	if toggled:
		selected_tags.append(tag)
	else:
		selected_tags.erase(tag)
	
	if selected_tags.size() == 1:
		edit.show()
	else:
		edit.hide()


func _on_trash_pressed() -> void:
	var t = get_used_and_unused_tags()
	
	if all_in(selected_tags, t.unused):
		for tag in selected_tags:
			SaveLoad.SaveFileData.tags.erase(tag)
		selected_tags.clear()
		SaveLoad._save()
		refresh()
	else: 
		print("nuh uh")


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


func _on_favorite_pressed() -> void:
	for i in selected_tags:
		i.pinned = true
	SaveLoad._save()
	refresh()


func _on_un_favorite_pressed() -> void:
	for i in selected_tags:
		i.pinned = false
	SaveLoad._save()
	refresh()
