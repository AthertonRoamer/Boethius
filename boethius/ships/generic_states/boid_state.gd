class_name BoidState
extends ShipState

var boid_center_point : Vector2 = Vector2(600, 300)
var boid_radius : float = 100

#var direction : Vector2 = Vector2.RIGHT
var next_direction : Vector2 = Vector2.RIGHT

var boundary_correction_rotation : float = 10


func _init() -> void:
	id = "boid_state"
	

func process_state(delta : float) -> void:
	next_direction = get_ship().current_direction
	if get_ship().global_position.distance_to(boid_center_point) > boid_radius and next_direction.normalized().dot(get_ship().global_position.direction_to(boid_center_point)) < 0.9:
		next_direction = correct_toward_center(next_direction, delta)
	get_ship().current_direction = next_direction
		
		
func correct_toward_center(direction : Vector2, delta : float) -> Vector2:
	return direction.rotated(boundary_correction_rotation * delta)
