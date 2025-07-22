extends Node
#it is this nodes responsibility to make sure eveything (DonutValueDisplay, SliderPivot, SliderButton, ButtonSprite)
#is displayed properly after calling the update_display function
#as part of the function it will call to the ColorManager to manage the colors of the displays

#get all displays
@onready var donut_timer: AspectRatioContainer = $".."
@onready var donut_value_display: TextureProgressBar = $"../SizeDonut/DonutValueDisplay"
@onready var size_donut: Node2D = $"../SizeDonut"
@onready var slider_pivot: Node2D = $"../SizeDonut/DonutValueDisplay/SliderPivot"
@onready var slider_button: Button = $"../SizeDonut/DonutValueDisplay/SliderPivot/SliderButton"
@onready var button_sprite: Sprite2D = $"../SizeDonut/DonutValueDisplay/SliderPivot/SliderButton/ButtonSprite"
#get helpers
@onready var color_manager: Node = $ColorManager


func _ready() -> void:
	await get_tree().create_timer(0.0).timeout
	var s = min(donut_timer.size.x, donut_timer.size.y)
	size_donut.position = Vector2(donut_timer.size.x / 2,donut_timer.size.y / 2)
	var actual_size = clamp(s/600, 0, 1)
	size_donut.scale = Vector2(actual_size, actual_size)



func  update_all_displays(hours : int, minutes : int, seconds : int):
	donut_value_display.set_value_msh(minutes, seconds, hours, color_manager.colors.size())
	slider_pivot.point_value(hours, minutes, seconds)
	color_manager.update_colors(hours, minutes, seconds)
	await get_tree().create_timer(0.0).timeout
	var s = min(donut_timer.size.x, donut_timer.size.y)
	size_donut.position = Vector2(donut_timer.size.x / 2,donut_timer.size.y / 2)
	var actual_size = clamp(s/600, 0, 1)
	size_donut.scale = Vector2(actual_size, actual_size)
