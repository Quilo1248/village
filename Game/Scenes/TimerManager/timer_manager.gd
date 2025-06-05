extends Control

@onready var donut_timer: AspectRatioContainer = $DonutTimer
@onready var time_display: Label = $DonutTimer/TimeDisplay
@onready var display_manager: Node = $DisplayManager
@onready var selector: Control = $Selector


func _on_donut_timer_time_updated(hours: Variant, minutes: Variant, seconds: Variant) -> void:
	display_manager.update_displays(hours, minutes, seconds)


func _on_selector_selection_changed(selection) -> void:
	if selection == "TIMER":
		selection = "SET"
	else:
		donut_timer.set_time(0, 0, 0)
		display_manager.update_displays(0, 0, 0)
	donut_timer.current_state = donut_timer.TimerState[selection]


func _on_start_pressed() -> void:
	donut_timer.start_timer(donut_timer.TimerState[selector.selected])
	display_manager.update_displays(donut_timer.current_hours, donut_timer.current_minutes, donut_timer.current_seconds)
