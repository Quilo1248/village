extends Button
#this node will be responsible for alarming SliderPivot to look at the mouse in SET mode
#and be responible for doing nothing but look good in other states

signal button_held
var held:= false


func _on_button_down() -> void:
	held = true


func _on_button_up() -> void:
	held = false


func _process(delta: float) -> void:
	if held:
		emit_signal("button_held")
