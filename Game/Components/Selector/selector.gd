extends Control

signal selection_changed
var selected := "CountDown" # using this 'CountDown'/'CountUp' to align with the timer donut script
@onready var timer: Button = $HBoxContainer/Timer
@onready var stop_watch: Button = $HBoxContainer/StopWatch


func _on_timer_toggled(toggled_on: bool) -> void:
	if toggled_on :
		timer.disabled = true
		stop_watch.disabled = false
	stop_watch.button_pressed = false
	
	selected = "CountDown"
	emit_signal("selection_changed", selected)


func _on_stop_watch_toggled(toggled_on: bool) -> void:
	if toggled_on :
		stop_watch.disabled = true
		timer.disabled = false
	timer.button_pressed = false
	
	selected = "CountUp"
	emit_signal("selection_changed", selected)
