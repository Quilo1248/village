extends Node
#it is this nodes responsibility to make sure eveything (DonutValueDisplay, SliderPivot, SliderButton, ButtonSprite)
#is displayed properly after calling the update_display function
#as part of the function it will call to the ColorManager to manage the colors of the displays

#get all displays
@onready var donut_value_display: TextureProgressBar = $"../DonutValueDisplay"
@onready var slider_pivot: Node2D = $"../DonutValueDisplay/SliderPivot"
@onready var slider_button: Button = $"../DonutValueDisplay/SliderPivot/SliderButton"
@onready var button_sprite: Sprite2D = $"../DonutValueDisplay/SliderPivot/SliderButton/ButtonSprite"
#get helpers
@onready var color_manager: Node = $ColorManager


func  update_all_displays(hours : int, minutes : int, seconds : int):
	donut_value_display.set_value_msh(minutes, seconds, hours, color_manager.colors.size())
	slider_pivot.point_value(hours, minutes, seconds)
	color_manager.update_colors(hours, minutes, seconds)
