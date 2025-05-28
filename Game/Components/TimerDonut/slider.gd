extends Button
#this node will be responsible for alarming SliderPivot to look at the mouse in SET mode
#and be responible for doing nothing but look good in other states
@onready var donut_timer: AspectRatioContainer = $"../../.."

signal button_held
var held:= false


func _on_button_down() -> void:
	held = true


func _on_button_up() -> void:
	held = false


func _process(delta: float) -> void:
	if held and donut_timer.current_state == donut_timer.TimerState.SET:
		emit_signal("button_held")
