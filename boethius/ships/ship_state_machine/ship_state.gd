class_name ShipState
extends State

var desired_direction : Vector2 = Vector2.RIGHT #the literal direction the ship is trying to go right now, after obstacles and everything has been taken into account

func get_ship() -> Ship:
	return state_machine.ship


func process_state(delta : float) -> void: 
	#here is an outline of the logic that should work for basically every state
	#most of the code indicated to be here is already implemented in the boid_state, but putting it in 
	#this format will make coding future states way easier
	get_ship().weight_system.reset_weights()
	select_desired_direction()
	apply_obstacle_data()
	desired_direction = get_direction_from_weight_system()
	if should_rotate():
		get_ship().rotate_toward_direction(desired_direction, delta)
	if should_thrust():
		get_ship().thrust(delta)
	
	
func select_desired_direction() -> void:
	#this is going to be different for every state
	pass 
	
	
func apply_seperation() -> void:
	#I intend to actually put generic seperation logic here
	pass
	
	
func apply_obstacle_data() -> void:
	for blocked_ray in get_ship().obstacle_detector.get_colliding_rays():
		get_ship().weight_system.register_blocked_normal(blocked_ray.target_position.normalized())


func get_direction_from_weight_system() -> Vector2:
	#update weight system
	get_ship().weight_system.register_normal(desired_direction)
	return get_ship().weight_system.get_heaviest_weight().normal
	
	
func should_thrust(thrust_determinant : float = get_ship().thrust_determinant) -> bool: 
	return get_ship().current_direction.dot(desired_direction) > thrust_determinant
	
	
func should_rotate() -> bool:
	return not desired_direction.is_equal_approx(get_ship().current_direction)
