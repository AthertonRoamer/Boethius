class_name LaserShootState
extends ShootState

func deactivate() -> void:
	super()
	get_ship().release_laser()


func process_state(delta : float) -> void:
	if not is_instance_valid(target):
		state_machine.set_state(state_machine.previous_state_id)
		return
	
	#compute shoot threshhold
	var distance_to_target : float = get_ship().global_position.distance_to(target.global_position)
	shoot_angle_threshhold = asin(estimated_target_radius / distance_to_target)
	var direction_to_target : Vector2 = get_ship().global_position.direction_to(target.global_position)
	if abs(get_ship().current_direction.angle_to(direction_to_target)) <= shoot_angle_threshhold:
		get_ship().shoot()
	else:
		get_ship().release_laser()
		get_ship().rotate_toward_direction(direction_to_target, delta)
	consider_changing_state()
