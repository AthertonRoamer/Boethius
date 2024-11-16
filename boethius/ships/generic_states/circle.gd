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
	elif distance_to_center > radius:
		var rsign : int = -sign(get_ship().current_direction.angle_to(get_ship().global_position.direction_to(center_point)))
		desired_direction = get_ship().global_position.direction_to(center_point).rotated(deg_to_rad(preferred_angle_deviance * rsign))
	if not desired_direction.is_equal_approx(get_ship().current_direction):
		if get_ship().auto_uses_space_physics and not desired_direction.is_equal_approx(get_ship().velocity.normalized()):
				#adjust desired direction for physics
				desired_direction += -get_ship().velocity.normalized()
				desired_direction = desired_direction.normalized()
			
			
func should_rotate() -> bool:
	return get_ship().current_direction.normalized().dot(desired_direction) < boundary_correction_determinant and super()
