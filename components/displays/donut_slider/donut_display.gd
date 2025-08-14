@tool
extends Container
class_name CircleDisplay

@export_category("Visuals")
@export var cap_1_enabled : bool = true
@export var cap_2_enabled : bool = true
@export var stroke_width : float:
	set(width):
		stroke_width = width
		target_bg_width = inner_stroke_width
		target_fg_width = stroke_width
@export var inner_stroke_width : float:
	set(width):
		inner_stroke_width = width
		# Update target_bg_width when inner_stroke_width changes too
		# This is important if you expect target_bg_width to reflect inner_stroke_width immediately
		target_bg_width = inner_stroke_width
@export var layer_colors : Array[Color]
@export var anti_alias : bool

@export_category("Animation")
@export var width_speed : float = 5
@export var color_change_speed : float = 5
@export var cap_2_color_change_speed : float = 5

@export_category("Values")
@export var max_laps : int
@export var lap_value : float
@export var value : float:
	set(v):
		value = v
		lap = int(value/ lap_value)
		layer_value = (value - (lap * lap_value)) / lap_value

var radius : float
var layer_value : float
var lap : int:
	set(l):
		if lap == l:
			return
		elif l >= lap: # grow
			lap = l
			current_bg_width = stroke_width 
			current_fg_width = stroke_width
			
			current_bg_color = layer_colors[lap]
			current_fg_color = layer_colors[lap]
			
			target_bg_color = layer_colors[lap]
			target_fg_color = layer_colors[lap + 1]
			target_dot_color = layer_colors[lap + 1]
		elif l <= lap: # shrink
			lap = l
			current_bg_width = inner_stroke_width
			current_fg_width = inner_stroke_width
			
			current_bg_color = layer_colors[lap]
			current_fg_color = layer_colors[lap + 1]
			
			target_bg_color = layer_colors[lap]
			target_fg_color = layer_colors[lap + 1]
			target_dot_color = layer_colors[lap + 1]

var current_bg_width : float
var current_fg_width : float
var target_fg_width : float
var target_bg_width : float
var current_bg_color : Color
var target_bg_color : Color
var current_fg_color : Color
var target_fg_color : Color
var current_dot_color : Color
var target_dot_color : Color

var center : Vector2
var cap_1_position : Vector2
var cap_2_position : Vector2


func _ready() -> void:
	target_bg_color = layer_colors[lap]
	target_fg_color = layer_colors[lap + 1]
	target_dot_color = layer_colors[lap + 1]
	current_dot_color = target_dot_color
	current_bg_color = target_bg_color
	current_fg_color = target_fg_color
	
	current_bg_width = 0
	current_fg_width = 0
	
	queue_redraw()


func _draw() -> void:
	update_display()

func update_display():
	# colors
	var bg_color : Color = current_bg_color
	var fg_color : Color = current_fg_color
	# radius
	radius = min(size.x / 2, size.y /2)
	radius -= stroke_width/2
	radius -= 1 #just for the bleed/anti aliasing
	# misc
	center = size / 2
	var start : float = deg_to_rad(-90)
	var end : float = layer_value
	end = deg_to_rad((end * 360) - 90)
	
	# round cap
	cap_1_position = center + Vector2(cos(start), sin(start)) * radius
	cap_2_position = center + Vector2(cos(end), sin(end)) * radius
	
	# actually draw
	# bg
	draw_circle(center, radius , bg_color, false, current_bg_width, anti_alias)
	# draw the top round cap
	if cap_1_enabled:
		draw_circle(cap_1_position, stroke_width/2, current_fg_color, true, -1, anti_alias)
	# progress
	draw_arc(center, radius, start, end, 128, fg_color, current_fg_width, anti_alias)
	# draw the bottom round cap
	if cap_2_enabled:
		draw_circle(cap_2_position, stroke_width/2, current_dot_color, true, -1, anti_alias)

func update_variables(delta):
	current_bg_width = lerp(current_bg_width, target_bg_width, delta * width_speed)
	current_fg_width = lerp(current_fg_width, target_fg_width, delta * width_speed)
	current_bg_color = current_bg_color.lerp(target_bg_color, delta * color_change_speed)
	current_fg_color = current_fg_color.lerp(target_fg_color, delta * color_change_speed)
	current_dot_color = current_dot_color.lerp(target_dot_color, delta * cap_2_color_change_speed)

func _process(delta: float) -> void:
	update_variables(delta)
	queue_redraw()
