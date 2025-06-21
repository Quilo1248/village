extends Button

signal toggled_tag(bool, int, String)
@export var index : int
@export var tag : Tag

func _ready():
	update_tag()


func update_tag():
	text = tag.title
	tooltip_text = tag.description
	# Colors
	_set_state_color("normal", tag.background_color)
	_set_state_color("hover", tag.background_color.lightened(0.1))
	_set_state_color("pressed", tag.background_color.darkened(0.15))
	_set_state_color("focus", tag.background_color.lightened(0.1))
	_set_state_color("disabled", tag.background_color.darkened(0.2))
	
	add_theme_color_override("font_color", tag.text_color)
	add_theme_color_override("font_hover_color", tag.text_color.lightened(0.1))
	add_theme_color_override("font_pressed_color", tag.text_color.darkened(0.15))
	add_theme_color_override("font_hover_pressed_color", tag.text_color)
	add_theme_color_override("font_focus_color", tag.text_color.lightened(0.1))
	add_theme_color_override("font_disabled_color", tag.text_color.darkened(0.2))


func _set_state_color(state: String, bg_color: Color, border_color = null, border_width: float = 0.0) -> void:
	# Grab the stylebox for this button’s state
	var sb = get_theme_stylebox(state)
	if sb is StyleBoxFlat:
		# Duplicate so we don’t modify the shared theme resource
		sb = sb.duplicate()
		# Set background color
		sb.bg_color = bg_color
		# Optionally set border if provided
		if border_color != null:
			sb.border_color = border_color
			sb.border_width = border_width
		# Apply override on this button for the given state
		add_theme_stylebox_override(state, sb)


func _on_toggled(toggled_on: bool) -> void:
	emit_signal("toggled_tag", toggled_on, tag)
