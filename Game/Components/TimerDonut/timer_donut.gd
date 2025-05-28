extends AspectRatioContainer
#this node will be responsible for setting the states and managing what happens in each state
#it will accept calls from outside to start/stop but that's it.
#when it recives start/stop it will pass it on to the timer and set states 
#handle every thing that needs to happen each timer tick
#then it will tell the DisplayManager to update

signal time_updated (hours, minutes, seconds)
enum TimerState {
	SET,
	TIMER,
	STOPWATCH,
}
var current_state = TimerState.SET
var total_seconds : int = 0
var total_minutes : int = 0
var total_hours : int = 0
var current_seconds : int = 0
var current_minutes : int = 0
var current_hours : int = 0
@onready var display_manager: Node = $DisplayManager
@onready var color_manager: Node = $DisplayManager/ColorManager
@onready var timer: Timer = $Timer
@onready var slider_pivot: Node2D = $DonutValueDisplay/SliderPivot


func _ready() -> void:
	update_displays()


func update_displays(): 
	display_manager.update_all_displays(current_hours, current_minutes, current_seconds)


func set_time(hours, minutes, seconds):
	current_hours = hours
	current_minutes = minutes
	current_seconds = seconds
	slider_pivot.point_value(hours, minutes, seconds)
	
	update_displays()

func _on_slider_pivot_time_just_set(hours: Variant, minutes: Variant, seconds: Variant) -> void:
	current_hours = hours
	current_minutes = minutes
	current_seconds = seconds
	update_displays()
	emit_signal("time_updated", current_hours, current_minutes, current_seconds)


func start_timer(mode : TimerState):
	timer.start()
	current_state = mode
	
	total_seconds = current_seconds
	total_minutes = current_minutes
	total_hours = current_hours


func  stop_timer():
	timer.stop()


func _on_timer_timeout() -> void:
	tick()


func tick():
	if current_state == TimerState.TIMER:
		add_time(1)
	
	if current_state == TimerState.STOPWATCH:
		add_time(-1)
	
	if timer_finished():
			stop_timer()
	
	update_displays()


func add_time(seconds):
	current_seconds += seconds
	if current_seconds > 59:
		current_minutes += 1
		current_seconds = 0
	if current_seconds < 0:
		current_seconds = 59
		current_minutes -= 1
	
	if current_minutes > 59:
		current_hours += 1
		current_minutes = 0
	if current_minutes < 0:
		current_hours -= 1
		current_minutes = 59


func timer_finished():
	if current_hours <= 0 \
	and current_minutes <= 0 \
	and current_seconds < 0 \
	and current_state == TimerState.TIMER:
		return true
	
	if current_hours >= color_manager.colors.size() \
	and current_state == TimerState.STOPWATCH:
		return true
	
	return false
