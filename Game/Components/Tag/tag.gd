extends Button


@export var title : String
@export var description : String
@export var background_color : Color
@export var text_color : Color


func _ready():
	update_tag()


func update_tag():
	text = title
	tooltip_text = description
	# Colors
	_set_state_color("normal", background_color)
	_set_state_color("hover", background_color.lightened(0.1))
	_set_state_color("pressed", background_color.darkened(0.15))
	_set_state_color("focus", background_color.lightened(0.1))
	_set_state_color("disabled", background_color.darkened(0.2))
	
	add_theme_color_override("font_color", text_color)
	add_theme_color_override("font_hover_color", text_color.lightened(0.1))
	add_theme_color_override("font_pressed_color", text_color.darkened(0.15))
	add_theme_color_override("font_hover_pressed_color", text_color)
	add_theme_color_override("font_focus_color", text_color.lightened(0.1))
	add_theme_color_override("font_disabled_color", text_color.darkened(0.2))


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
