extends Node2D
#this node will be responsible for pointing in the direction of 
#the mouse when the sliderbutton is pushed down in Set mode
#it will then compute and pass the value (hours, minutes, seconds) up to DonutTimer
#and point in the direction of the value in other modes

signal time_just_set(hours, minutes, seconds)
@export var snap := 6.0 # degrees
@onready var color_manager: Node = $"../../DisplayManager/ColorManager"

## Makes the SliderPivot point toward the mouse and returns the converted time.
## returns a dictionary{"hours", "minutes", "seconds"}
func point_mouse():
	look_at(get_global_mouse_position())
	rotation_degrees += 90
	rotation_degrees = clamp(rotation_degrees, 0, (color_manager.colors.size() - 1) * 360)
	if snap != 0: # No Divide by zero
		rotation_degrees = floor(rotation_degrees / snap) * snap
	
	var hours : int
	var minutes : int
	var seconds : int
	
	hours = floor(rotation_degrees / 360)
	minutes = int(floor(rotation_degrees / 6)) % 60
	seconds = int(floor(rotation_degrees * 10)) % 60
	
	return {
		"hours" : hours,
		"minutes" : minutes,
		"seconds" : seconds,
	}


## Takes inputs : hours, minutes, seconds [br]
## then points itself to where that would be.
func point_value(hours : int, minutes : int, seconds : int):
	var total_seconds = 0
	total_seconds += hours * 60 * 60
	total_seconds += minutes * 60
	total_seconds += seconds
	rotation_degrees = total_seconds / 10 # 1 degree is 10 seconds


func _on_slider_button_button_held() -> void:
	var time_now = point_mouse()
	emit_signal("time_just_set", time_now["hours"], time_now["minutes"], time_now["seconds"])
