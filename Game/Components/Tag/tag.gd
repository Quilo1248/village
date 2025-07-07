extends Button

signal toggled_tag(bool, int, String)
@export var index : int
@export var tag : Tag

func _ready():
	update_tag()


func update_tag():
	text = tag.title
	tooltip_text = tag.description
	set_button_colors(tag.background_color,tag.text_color)


func set_button_colors(background_color: Color, text_color: Color) -> void:
	var states := [
		"normal",
		"hover",
		"pressed",
		"hover_pressed",
		"disabled",
		"focus"
	]

	for state in states:
		var sb := get_theme_stylebox(state)
		if sb is StyleBoxFlat:
			var sb_new := sb.duplicate() as StyleBoxFlat

			var final_bg_color := background_color
			if state == "hover":
				final_bg_color = background_color.lightened(0.1)
			elif state == "pressed" or state == "hover_pressed":
				final_bg_color = background_color.darkened(0.1)

			sb_new.bg_color = final_bg_color
			sb_new.border_color = final_bg_color

			add_theme_stylebox_override(state, sb_new)

	var font_color_roles := [
		"font_color",
		"font_hover_color",
		"font_pressed_color",
		"font_hover_pressed_color",
		"font_disabled_color",
		"font_focus_color"
	]

	for role in font_color_roles:
		add_theme_color_override(role, text_color)

	modulate = Color(1, 1, 1, 1)


func _on_toggled(toggled_on: bool) -> void:
	emit_signal("toggled_tag", toggled_on, tag)
