class_name CircleState
extends ShipState

var center_point : Vector2 = Vector2(600, 300)
var radius : float = 150
var outer_radius : float = 500

var boundary_correction_determinant : float = 0.95 

var preferred_angle_deviance : float = 80

var thrust_determinant : float = -0.5

func _init() -> void:
	id = "circle_state"
	
	
func select_desired_direction() -> void:
	desired_direction = get_ship().current_direction
	var distance_to_center : float = get_ship().global_position.distance_to(center_point)
	
	if distance_to_center > outer_radius:
		desired_direction = get_ship().global_position.direction_to(center_point)
		direction_changed = true
	elif distance_to_center > radius:
		var rsign : int = -sign(get_ship().current_direction.angle_to(get_ship().global_position.direction_to(center_point)))
		desired_direction = get_ship().global_position.direction_to(center_point).rotated(deg_to_rad(preferred_angle_deviance * rsign))
		direction_changed = true
	#adjust_direction_for_physics()


func should_rotate() -> bool:
	return get_ship().current_direction.normalized().dot(desired_direction) < boundary_correction_determinant and super()
