extends Control

@onready var donut_timer: AspectRatioContainer = $DonutTimer
@onready var time_display: Label = $DonutTimer/TimeDisplay
@onready var display_manager: Node = $DisplayManager


func _on_donut_timer_time_updated(hours: Variant, minutes: Variant, seconds: Variant) -> void:
	display_manager.update_displays(hours, minutes, seconds)
