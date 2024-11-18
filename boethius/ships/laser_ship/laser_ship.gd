class_name LaserShip
extends Ship

@onready var gun1 = $gun1

var aim_mode = false
@export var aim_speed = 90.0

func shoot():
	gun1.fire()
	
	
func release_laser() -> void:
	gun1.release_laser()


func register_player_input(delta : float) -> void:
	if aim_mode:
		var mouse_pos = get_global_mouse_position() 
		var direction_to_mouse = global_position.direction_to(mouse_pos) 
		var rsign : float = sign(current_direction.angle_to(direction_to_mouse))
		if abs(current_direction.angle_to(direction_to_mouse)) < deg_to_rad(aim_speed) * delta:
			current_direction = direction_to_mouse
		else:
			current_direction = current_direction.rotated(deg_to_rad(aim_speed) * delta * rsign)
		#rotation = lerp_angle(rotation, target_rotation, aim_speed * delta)
	else:
		var mouse_pos = get_global_mouse_position() 
		var direction_to_mouse = (mouse_pos - global_position).normalized()
		current_direction = direction_to_mouse

	if Input.is_action_pressed("ship_thrust"):
		physics_thrust(delta)
	else:
		visual_data.set_item("thrusting", false)
	
	if Input.is_action_pressed("ship_boost"): 
		boost(delta)
	elif Input.is_action_just_released("ship_boost") and boosting: 
		visual_data.set_item("boosting", false)
		stop_boost()
	
	if Input.is_action_pressed("ship_shoot"):
		aim_mode = true
		shoot()
	else:
		aim_mode = false
		release_laser()
