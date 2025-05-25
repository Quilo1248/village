extends TextureProgressBar


var timer_mode := "Set" # modes are 'Set', 'CountDown', 'CountUp'
var total_seconds : int = 0
var total_minutes : int = 5
var total_hours : int = 0
@export var colors : Array[Color]
@onready var button: Sprite2D = $offset/slider/Button
@onready var slider: Button = $offset/slider


func _ready() -> void:
	set_value_minutes(5)


func set_value_minutes(minutes : float):
	minutes = clamp(floor(minutes), 5, (colors.size() - 1) * 60)
	var laps = floor(minutes/60)
	var relitive_value = int(minutes) % 60
	total_minutes = minutes
	total_hours = laps
	total_seconds = (minutes - floor(minutes)) * 60
	
	value = relitive_value
	
	set_colors()


func set_value_time(seconds : int, minutes : int, hours : int):
	var laps = hours
	value = float(minutes + seconds/60.0)
	set_colors()


func set_colors():
	if total_hours > colors.size() - 1 : return # please don't overflow
	tint_under = colors[clamp(total_hours, 0, colors.size())]
	tint_progress = colors[clamp(total_hours + 1, 1, colors.size() - 1)]
	if total_seconds > 0 or total_minutes > 0: # we dont want the button to update at the top
		button.modulate = colors[clamp(total_hours + 1, 1, colors.size() - 1)]


func tick():
	if timer_mode == "Set": return
	
	if timer_mode == "CountUp":
		add_second_to_total_time()
		if total_hours > colors.size() - 2:
			reset_timer()
		set_value_time(total_seconds, total_minutes, total_hours)
		slider.offset.rotation_degrees = float(total_minutes + total_seconds/60.0) * 6.0 - 90.0
		slider.clamp_slider(timer_mode)
	
	if timer_mode == "CountDown":
		remove_second_from_total_time()
		if total_hours < 0:
			reset_timer()
		set_value_time(total_seconds, total_minutes, total_hours)
		slider.offset.rotation_degrees = float(total_minutes + total_seconds/60.0) * 6.0 - 90.0
		slider.clamp_slider(timer_mode)


func add_second_to_total_time():
	total_seconds += 1
	if total_seconds >= 60:
		total_seconds = 0
		total_minutes += 1
		if total_minutes >= 60:
			total_minutes = 0
			total_hours += 1


func remove_second_from_total_time():
	total_seconds -= 1
	if total_seconds <= -1:
		total_seconds = 59
		total_minutes -= 1
		if total_minutes <= -1:
			total_minutes = 59
			total_hours -= 1


func reset_timer():
	total_seconds = 0
	total_minutes = 5
	total_hours = 0
	timer_mode = "Set"
	set_colors()
