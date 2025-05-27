extends Node
#it is this nodes responsibility to set all the colors of the DisplayItems to the right
#colors when the update_colors function is called

@export var colors : Array[Color]
@onready var donut_value_display: TextureProgressBar = $"../../DonutValueDisplay"
@onready var button_sprite: Sprite2D = $"../../DonutValueDisplay/SliderPivot/SliderButton/ButtonSprite"


func update_colors(hours : int, minutes : int, seconds : int):
	var laps = clamp(hours, 0, colors.size() - 2)
	button_sprite.modulate = colors[laps + 1]
	donut_value_display.tint_under = colors[laps]
	donut_value_display.tint_progress = colors[laps + 1]
