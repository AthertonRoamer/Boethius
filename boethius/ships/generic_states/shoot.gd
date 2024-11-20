class_name ShootState
extends ShipState

var target : Node2D
var shoot_angle_threshhold : float = 1 #degrees

func process_state(delta : float) -> void:
	#TODO abort if target is invalid
	var direction_to_target : Vector2 = get_ship().global_position.direction_to(target.global_position)
	if abs(get_ship().current_direction.angle_to(direction_to_target)) <= shoot_angle_threshhold:
		get_ship().shoot()
	else:
		get_ship().rotate_toward_direction(direction_to_target, delta)
	
