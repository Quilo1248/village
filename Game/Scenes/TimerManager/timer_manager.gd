extends Control

@onready var donut_timer: AspectRatioContainer = $DonutTimer
@onready var time_display: Label = $DonutTimer/TimeDisplay
@onready var display_manager: Node = $DisplayManager
@onready var selector: Control = $Selector
@onready var start: Button = $Start


func _ready() -> void:
	pass


func _on_donut_timer_time_updated(hours: Variant, minutes: Variant, seconds: Variant) -> void:
	display_manager.update_displays(hours, minutes, seconds)
	start_button_disable(selector.selected)


func _on_selector_selection_changed(selection) -> void:
	if selection == "TIMER":
		selection = "SET"
		
	else:
		donut_timer.set_time(0, 0, 0)
		display_manager.update_displays(0, 0, 0)
	donut_timer.current_state = donut_timer.TimerState[selection]
	start.disabled = false
	
	if selection == "SET":
		start_button_disable(selection)


func _on_start_pressed() -> void:
	donut_timer.start_timer(donut_timer.TimerState[selector.selected])
	display_manager.update_displays(donut_timer.current_hours, donut_timer.current_minutes, donut_timer.current_seconds)


func _on_stop_pressed() -> void:
	donut_timer.stop_timer(true)
	display_manager.update_displays(donut_timer.current_hours, donut_timer.current_minutes, donut_timer.current_seconds)


func start_button_disable(selection):
	if donut_timer.current_seconds > 0 or donut_timer.current_minutes > 0 or donut_timer.current_hours > 0:
		start.disabled = false
	else:
		start.disabled = true
