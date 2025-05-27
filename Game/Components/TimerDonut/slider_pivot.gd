extends Node2D
#this node will be responsible for pointing in the direction of 
#the mouse when the sliderbutton is pushed down in Set mode
#it will then compute and pass the value (hours, minutes, seconds) up to DonutTimer
#and point in the direction of the value in other modes

## Makes the SliderPivot point toward the mouse and returns the converted time.
## returns a dictionary{"hours", "minutes", "seconds"}
func point_mouse():
	look_at(get_global_mouse_position())
	rotation_degrees += 90
	
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


func point_value(hours, minutes, seconds):
	pass


func _on_slider_button_button_held() -> void:
	point_mouse()
