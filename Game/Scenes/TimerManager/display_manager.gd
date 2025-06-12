extends Node

enum TimerState {
	SET,
	TIMER,
	STOPWATCH,
}
@onready var donut_timer: AspectRatioContainer = $"../DonutTimer"
@onready var time_display: Label = $"../DonutTimer/TimeDisplay"
@onready var selector: Control = $"../Selector"
@onready var start: Button = $"../Start"
@onready var stop: Button = $"../Stop"
@onready var coins_display: Label = $"../CoinsDisplay"

func update_displays(h, m, s):
	donut_timer.update_displays()
	time_display.update_display(h, m, s)
	coins_display.update_display()

	hide_displays(donut_timer.current_state)
	

func hide_displays(state : TimerState):
	if state == TimerState.SET:
		selector.show()
		time_display.show()
		donut_timer.show()
		start.show()
		stop.hide()
	else:
		selector.hide()
		start.hide()
		stop.show()
