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
var timer_active := false
var total_seconds : int = 0
var total_minutes : int = 0
var total_hours : int = 0
var current_seconds : int = 0
var current_minutes : int = 0
var current_hours : int = 0
var unix_start : float
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
	timer_active = true
	current_state = mode
	
	total_seconds = current_seconds
	total_minutes = current_minutes
	total_hours = current_hours
	unix_start = Time.get_unix_time_from_system()


func  stop_timer(interupted : bool):
	#stop
	timer.stop()
	timer_active = false
	
	#save
	var current_session_save = Session.new()
	current_session_save.unix_start = unix_start
	current_session_save.unix_end = Time.get_unix_time_from_system()
	
	if not interupted:
		current_session_save.manual_stop = false
		if current_state == TimerState.TIMER:
			current_session_save.mode = "TIMER"
			SaveLoad.SaveFileData.coins += total_minutes + (total_hours * 60)
		if current_state == TimerState.STOPWATCH: #this technically is impossible!
			SaveLoad.SaveFileData.coins += current_minutes + (current_hours * 60)
	if interupted:
		current_session_save.manual_stop = true
		if current_state == TimerState.TIMER:
			current_session_save.mode = "TIMER"
			
			var start_time_seconds = total_hours * 3600 + total_minutes * 60 + total_seconds
			var remaining_time_seconds = current_hours * 3600 + current_minutes * 60 + current_seconds
			var elapsed_seconds = start_time_seconds - remaining_time_seconds
			var earned_minutes = int(elapsed_seconds / 60)
			
			SaveLoad.SaveFileData.coins += earned_minutes
		if current_state == TimerState.STOPWATCH:
			current_session_save.mode = "STOPWATCH"
			SaveLoad.SaveFileData.coins += current_minutes + (current_hours * 60)
	
	SaveLoad.SaveFileData.sessions.append(current_session_save)
	SaveLoad._save()
	
	#reset
	if current_state == TimerState.STOPWATCH:
		current_state = TimerState.STOPWATCH
	else:
		current_state = TimerState.SET
	current_hours = total_hours
	current_minutes = total_minutes
	current_seconds = total_seconds


func _on_timer_timeout() -> void:
	tick()


func tick():
	var unix_now = Time.get_unix_time_from_system()
	
	var ct = time_between(unix_start, unix_now) # ct for current time
	var total_time_in_seconds = (total_hours * 3600) + (total_minutes * 60) + total_seconds
	var rt = total_time_in_seconds - ct.total_seconds
	
	if current_state == TimerState.TIMER:
		current_seconds = int(rt % 60)
		current_minutes = int((rt % 3600) / 60)
		current_hours = int (rt / 3600)
		
	
	if current_state == TimerState.STOPWATCH:
		current_seconds = ct.seconds
		current_minutes = ct.minutes
		current_hours = ct.hours
	
	if current_state == TimerState.TIMER and rt < 0:
			stop_timer(false)
			
	
	update_displays()
	emit_signal("time_updated", current_hours, current_minutes, current_seconds)


func time_between(start_unix: int, end_unix: int) -> Dictionary:
	var duration = abs(end_unix - start_unix)
	return {
	"total_seconds": int(duration),
	"seconds": int(duration) % 60,
	"minutes": int(duration / 60) % 60,
	"hours": int(duration / 3600)
}
