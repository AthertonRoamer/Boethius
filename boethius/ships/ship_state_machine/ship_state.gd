class_name ShipState
extends State

var desired_direction : Vector2 = Vector2.RIGHT

func get_ship() -> Ship:
	return state_machine.ship


func _process_state(delta : float) -> void: 
	#here is an outline of the logic that should work for basically every state
	#most of the code indicated to be here is already implemented in the boid_state, but putting it in 
	#this format will make coding future states way easier
	apply_real_target_direction()
	apply_seperation()
	apply_obstacle_data()
	desired_direction = get_direction_from_weight_system()
	rotate_ship()
	if should_thrust():
		get_ship().thrust(delta)
	
	
func apply_real_target_direction() -> void:
	#this is going to be different for every state
	pass 
	
	
func apply_seperation() -> void:
	#I intend to actually put generic seperation logic here
	pass
	
	
func apply_obstacle_data() -> void:
	#I intend to put generic obstacle logic here
	pass


func get_direction_from_weight_system() -> Vector2:
	return get_ship().weight_system.get_heaviest_weight().normal
	
	
func rotate_ship() -> void:
	#generic logic here
	pass
	
	
func should_thrust() -> bool:
	#generic logic here
	return true
