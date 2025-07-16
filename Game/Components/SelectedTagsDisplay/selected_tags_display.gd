extends VBoxContainer

const TAG = preload("res://Game/Components/Tag/tag.tscn")
@export var selected_tags : Array[Tag]
@export var tags_to_display : int = 3
var min_size : Vector2 = Vector2(0, 31)

func update_displays():
	# clear children
	for child in get_children():
		child.queue_free()
	
	var win_size = DisplayServer.window_get_size()
	tags_to_display = floor((win_size.y / 5) / 32)
	
	# if there are less tags than tags we need to display
	# we can just add all the tags like a normal human
	if selected_tags.size() <= tags_to_display:
		for tag in selected_tags:
			var new_tag_display = TAG.instantiate()
			new_tag_display.disabled = true
			new_tag_display.custom_minimum_size = min_size
			new_tag_display.tag = tag
			add_child(new_tag_display)
	# if there are more then where gonna
	# chop the last one off and add a "+N" display instead.
	if selected_tags.size() > tags_to_display:
		for i in range(tags_to_display - 1):
			var new_tag_display = TAG.instantiate()
			new_tag_display.disabled = true
			new_tag_display.custom_minimum_size = min_size
			new_tag_display.tag = selected_tags[i]
			add_child(new_tag_display)
		
		var new_tag_display = TAG.instantiate()
		new_tag_display.disabled = true
		new_tag_display.custom_minimum_size = min_size
		
		var new_tag_res = Tag.new()
		new_tag_res.background_color = Color.BLACK
		new_tag_res.text_color = Color.WHITE
		new_tag_res.title = "+" + str(selected_tags.size() - (tags_to_display - 1))
		
		# Lambda functions still feel like magic to me
		var overflow_titles = selected_tags \
		.slice(tags_to_display - 1, selected_tags.size()) \
		.map(func(t): return t.title)
		new_tag_res.description = ", ".join(overflow_titles)
		
		new_tag_display.tag = new_tag_res
		add_child(new_tag_display)
