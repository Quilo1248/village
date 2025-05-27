extends AspectRatioContainer
#this node will be responsible for setting the states and managing what happens in each state
#it will accept calls from outside to start/stop but that's it.
#when it recives start/stop it will pass it on to the timer and set states 
#handle every thing that needs to happen each timer tick
#then it will tell the DisplayManager to update

enum TimerState {
	SET,
	TIMER,
	STOPWATCH,
}
var current_state = TimerState.SET
@onready var display_manager: Node = $DisplayManager


func _on_slider_pivot_time_just_set(hours: Variant, minutes: Variant, seconds: Variant) -> void:
	display_manager.update_all_displays(hours, minutes, seconds)
