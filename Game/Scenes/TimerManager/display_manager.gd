extends Node

enum TimerState {
	SET,
	TIMER,
	STOPWATCH,
}
@onready var donut_timer: Container = $"../StackComponents/DonutTimer"
@onready var time_display: Label = $"../StackComponents/DonutTimer/TimeDisplay"
@onready var selector: Control = $"../StackComponents/Selector"
@onready var start: Button = $"../StackComponents/CenterContainer/Start"
@onready var stop: Button = $"../StackComponents/CenterContainer/Stop"
@onready var coins_display: Label = $"../StackComponents/CoinsDisplay"
@onready var selected_tags_display: VBoxContainer = $"../StackComponents/SelectedTagsDisplay"


func update_displays(h, m, s):
	donut_timer.update_displays()
	time_display.update_display(h, m, s)
	coins_display.update_display()
	selected_tags_display.update_displays()

	hide_displays()
	

func hide_displays():
	if not donut_timer.timer_active:
		selector.show()
		time_display.show()
		donut_timer.show()
		start.show()
		stop.hide()
	else:
		selector.hide()
		start.hide()
		stop.show()
