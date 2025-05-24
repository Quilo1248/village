extends TextureProgressBar


var total_minutes : int = 5
@export var colors : Array[Color]
@onready var button: Sprite2D = $offset/slider/Button

func _ready() -> void:
	set_value_minutes(5)

func set_value_minutes(minutes : float):
	minutes = clamp(minutes, 5, (colors.size() - 1) * 60)
	total_minutes = minutes
	var laps = floor(minutes/60)
	var relitive_value = int(minutes) % 60
	
	value = relitive_value
	
	tint_under = colors[clamp(laps, 0, colors.size())]
	tint_progress = colors[clamp(laps + 1, 1, colors.size() - 1)]
	
	button.modulate = colors[clamp(laps + 1, 1, colors.size() - 1)]
