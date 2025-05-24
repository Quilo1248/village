extends Button


var held : bool = false
@onready var offset: Node2D = $".."
@onready var donut_display: TextureProgressBar = $"../.."


func _ready() -> void:
	offset.global_position = donut_display.global_position + donut_display.size * donut_display.scale / Vector2(2,2)
	offset.rotation_degrees = -60


func _on_button_down() -> void:
	held = true


func _on_button_up() -> void:
	held = false


func _process(delta: float) -> void:
	if not held:
		return
	else:
		offset.look_at(get_global_mouse_position())
		offset.rotation_degrees = clamp(offset.rotation_degrees, -60, \
		((donut_display.colors.size() - 1) * 360) - 90)
		
		donut_display.set_value_minutes((offset.rotation_degrees + 90)/6)
