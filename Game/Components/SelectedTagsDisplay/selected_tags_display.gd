extends VBoxContainer

@export var selected_tags_index : Array[int]
@onready var selected_tag_display_1: Label = $SelectedTagDisplay1
@onready var selected_tag_display_2: Label = $SelectedTagDisplay2
@onready var selected_tag_display_3: Label = $SelectedTagDisplay3


func update_displays():
	
	if selected_tags_index.size() > 3:
		selected_tag_display_3.text = str(selected_tags_index.size() - 2)
