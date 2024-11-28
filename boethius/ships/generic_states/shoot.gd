class_name ShootState
extends ShipState

var target : Node2D
var shoot_angle_threshhold : float = TAU / 360 #radians
var estimated_target_radius : float = 10
var estimated_shot_radius : float = 0
var total_radius : float = estimated_target_radius + estimated_shot_radius

func _init() -> void:
	id = "shoot"

func process_state(delta : float) -> void:
	if not is_instance_valid(target):
		state_machine.set_state(state_machine.previous_state_id)
		return
	
	#compute shoot threshhold
	var distance_to_target : float = get_ship().global_position.distance_to(target.global_position)
	shoot_angle_threshhold = asin(total_radius / distance_to_target)
	var direction_to_target : Vector2 = get_ship().global_position.direction_to(target.global_position)
	if abs(get_ship().current_direction.angle_to(direction_to_target)) <= shoot_angle_threshhold:
		get_ship().shoot()
	else:
		get_ship().rotate_toward_direction(direction_to_target, delta)
	consider_changing_state()
		
		
func consider_changing_state() -> void:
	if not get_ship().ship_area.get_visible_enemies().has(target):
		state_machine.set_state(state_machine.previous_state_id)
	
