extends Node

@onready var donut_timer: AspectRatioContainer = $"../DonutTimer"
@onready var time_display: Label = $"../DonutTimer/TimeDisplay"

func update_displays(h, m, s):
	donut_timer.update_displays()
	time_display.update_display(h, m, s)
	
