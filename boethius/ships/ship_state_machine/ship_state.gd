class_name ShipState
extends State

var desired_direction : Vector2 = Vector2.RIGHT #the literal direction the ship is trying to go right now, after obstacles and everything has been taken into account
var direction_changed : bool = false

func get_ship() -> Ship:
	return state_machine.ship


func process_state(delta : float) -> void: 
	#here is an outline of the logic that should work for basically every state
	#most of the code indicated to be here is already implemented in the boid_state, but putting it in 
	#this format will make coding future states way easier
	direction_changed = false
	select_desired_direction() #where are we headed
	desired_direction = get_direction_from_weight_system() #go the best route thats not blocked
	if direction_changed:
		adjust_direction_for_physics() #figure out what direction to thrust so we actually go the right way
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
	get_ship().weight_system.reset_weights()
	apply_obstacle_data()
	get_ship().weight_system.register_normal(desired_direction)
	return get_ship().weight_system.get_heaviest_weight().normal
	
	
func should_thrust(thrust_determinant : float = get_ship().thrust_determinant) -> bool: 
	return get_ship().current_direction.dot(desired_direction) > thrust_determinant
	
	
func should_rotate() -> bool:
	return not desired_direction.is_equal_approx(get_ship().current_direction)
	
	
func adjust_direction_for_physics() -> void:
	if not desired_direction.is_equal_approx(get_ship().current_direction) and direction_changed:
		if get_ship().auto_uses_space_physics and not desired_direction.is_equal_approx(get_ship().velocity.normalized()):
				#adjust desired direction for physics
				desired_direction += -get_ship().velocity.normalized()
				desired_direction = desired_direction.normalized()
