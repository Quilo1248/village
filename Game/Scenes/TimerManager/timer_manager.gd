extends Control


var timer_active := false
@onready var donut_display: TextureProgressBar = $DonutDisplay
@onready var time_display: Label = $DonutDisplay/TimeDisplay
@onready var selector: Control = $Selector
@onready var second_increment_timer: Timer = $SecondIncrementTimer
@onready var start: Button = $Start
@onready var stop: Button = $Stop


func _on_selector_selection_changed(selection) -> void:
	if selection == "CountUp":
		donut_display.set_stop_watch_mode()
	elif selection == "CountDown":
		donut_display.set_timer_mode()


func _on_donut_display_value_changed(value: float) -> void:
	var h = donut_display.total_hours
	var m = donut_display.total_minutes % 60
	var s = donut_display.total_seconds
	time_display.update_display(h, m, s)


func timer_activate():
	donut_display.timer_mode = selector.selected
	second_increment_timer.start()
	
	timer_active = true
	selector.hide()
	start.hide()
	stop.show()


func timer_deactivate():
	donut_display.timer_mode = selector.selected
	second_increment_timer.stop()
	
	timer_active = false
	selector.show()
	start.show()
	stop.hide()
	
	donut_display.reset_timer()


func _on_start_pressed() -> void:
	timer_activate()


func _on_second_increment_timer_timeout() -> void:
	donut_display.tick()


func _on_stop_pressed() -> void:
	timer_deactivate()


func _on_donut_display_timer_finished() -> void:
	timer_deactivate()
