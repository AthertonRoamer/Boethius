class_name BoidState
extends ShipState

var boid_center_point : Vector2 = Vector2(600, 300)
var boid_radius : float = 50

var next_direction : Vector2 = Vector2.RIGHT

var boundary_correction_rotation : float = 1
var boundary_correction_determinant : float = 0.8 #0 requires the ship to at least be at a right angle to the center, 1 requires it to go directly to the center

var boundary_correction_sign : int = 1

func _init() -> void:
	id = "boid_state"
	
	
func _ready() -> void:
	super()
	randomize()
	if randi_range(0, 1):
		boundary_correction_sign = -1
	

func process_state(delta : float) -> void:
	next_direction = get_ship().current_direction
	if get_ship().global_position.distance_to(boid_center_point) > boid_radius:
		if next_direction.normalized().dot(get_ship().global_position.direction_to(boid_center_point)) < boundary_correction_determinant:
			next_direction = correct_toward_center(next_direction, delta)
	get_ship().current_direction = next_direction
		
		
func correct_toward_center(direction : Vector2, delta : float) -> Vector2:
	var correction_factor : float = get_ship().global_position.distance_to(boid_center_point) / boid_radius
	return direction.rotated(correction_factor * boundary_correction_rotation * delta * boundary_correction_sign)
