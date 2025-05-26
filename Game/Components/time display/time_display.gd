extends Label


var hours : int = 0
var minutes : int = 5
var seconds : int = 0


func _ready() -> void:
	update_display(hours, minutes, seconds)


func update_display(h, m, s):
	hours = h
	minutes = m
	seconds = s
	
	var formatted_hours = str(hours).pad_zeros(1)
	var formatted_minutes = str(minutes).pad_zeros(2)
	var formatted_seconds = str(seconds).pad_zeros(2)
	
	text = str(formatted_hours, ":", formatted_minutes, ":", formatted_seconds)
