class_name BoidState
extends ShipState

var boid_center_point : Vector2 = Vector2(600, 300)
var boid_radius : float = 100

var next_direction : Vector2 = Vector2.RIGHT

var boundary_correction_rotation : float = 2
var boundary_correction_determinant : float = 0.95

var boundary_correction_sign : int = 1
var allowed_angle_deviance : float = 80

var thrust_determinant : float = -0.5

func _init() -> void:
	id = "boid_state"
	
	
func _ready() -> void:
	super()
	randomize()
	if randi_range(0, 1):
		boundary_correction_sign = -1
	allowed_angle_deviance *= boundary_correction_sign
	

func process_state(delta : float) -> void:
	next_direction = get_ship().current_direction
	var ldesired_direction : Vector2 = Vector2.RIGHT
	if get_ship().global_position.distance_to(boid_center_point) > boid_radius:
		ldesired_direction = get_ship().global_position.direction_to(boid_center_point).rotated(deg_to_rad(allowed_angle_deviance))
		if get_ship().auto_uses_space_physics:
			#adjust desired direction for physics
			ldesired_direction += -get_ship().velocity.normalized()
			ldesired_direction = ldesired_direction.normalized()
		if next_direction.normalized().dot(ldesired_direction) < boundary_correction_determinant:
			#next_direction = correct_toward_center(next_direction, delta)
			next_direction = correct_toward_desired_direction(next_direction, ldesired_direction, delta)
	else:
		ldesired_direction = next_direction
	get_ship().current_direction = next_direction
	if get_ship().current_direction.dot(ldesired_direction) > thrust_determinant:
		get_ship().thrust(delta)
		
		
func correct_toward_center(direction : Vector2, delta : float) -> Vector2:
	var correction_factor : float = get_ship().global_position.distance_to(boid_center_point) / boid_radius
	return direction.rotated(correction_factor * boundary_correction_rotation * delta * boundary_correction_sign)
	
	
func correct_toward_desired_direction(current_direction : Vector2, ldesired_direction : Vector2, delta : float) -> Vector2:
	var rsign : int = sign(current_direction.angle_to(ldesired_direction))
	if rad_to_deg(abs(current_direction.angle_to(ldesired_direction))) < boundary_correction_rotation * delta:
		return ldesired_direction #if you have more than enough rotation speed to get to the desired direction, you just rotate straight to it and not past it
	return current_direction.rotated(boundary_correction_rotation * delta * rsign)
