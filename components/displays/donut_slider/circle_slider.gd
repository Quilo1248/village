@tool
extends CircleDisplay
class_name CircleSlider

# Interaction
var pressed: bool = false
@export_category("Interaction")
@export var press_tolerance: float = 10.0
@export var enabled: bool = true

# Internal angle tracking (degrees)
var _prev_angle: float = 0.0
# this exists because we need to make 
# the first frame of holding the slider work well and not jump around
var _has_prev_angle: bool = false 
var _total_angle: float = 0.0

# Optional clamp for max laps (uses CircleDisplay.max_laps if set)
func _clamp_total_to_max_laps() -> void:
	if max_laps > 0:
		var min_angle = 0.0
		var max_angle = float(max_laps) * 360.0
		_total_angle = clamp(_total_angle, min_angle, max_angle)

func _input(event: InputEvent) -> void:
	if not enabled:
		return
	if event is InputEventMouseButton:
		if event.pressed:
			var dist = cap_2_position.distance_to(event.position)
			var knob_radius = stroke_width / 2.0
			if dist <= knob_radius + press_tolerance:
				pressed = true
				
				# Keep current slider value instead of snapping to zero
				_total_angle = (value / lap_value) * 360.0
				
				# Initialize previous angle based on mouse position
				var mouse = get_global_mouse_position()
				var ang_rad = atan2(mouse.y - (global_position.y + center.y),
									mouse.x - (global_position.x + center.x))
				_prev_angle = rad_to_deg(ang_rad)
				_has_prev_angle = true
		elif event.is_released():
			pressed = false
			_has_prev_angle = false


func _process(delta: float) -> void:
	if pressed:
		# Compute angle from global mouse to center (degrees)
		var mouse = get_global_mouse_position()
		var ang_rad = atan2(mouse.y - (global_position.y + center.y), mouse.x - (global_position.x + center.x))
		var ang_deg = rad_to_deg(ang_rad)
		
		if not _has_prev_angle:
			_prev_angle = ang_deg
			_has_prev_angle = true
		
		# Signed shortest angular delta in (-180, 180]
		# delta just refers to change since last frame
		var raw_delta = ang_deg - _prev_angle
		var signed_delta = fposmod(raw_delta + 180.0, 360.0) - 180.0
		
		# Accumulate total rotation and optionally clamp by max_laps
		_total_angle += signed_delta
		_clamp_total_to_max_laps()
		
		# Update previous angle for next sample
		_prev_angle = ang_deg
		
		# Compute integer laps and fractional layer_value (0.0..1.0)
		var laps = int(floor(_total_angle / 360.0))
		var angle_in_lap = fposmod(_total_angle, 360.0)
		var percent = angle_in_lap / 360.0
		
		value = (float(laps) + percent) * lap_value
	
	# Let base class handle animated visuals and redraw
	update_variables(delta)
	queue_redraw()
