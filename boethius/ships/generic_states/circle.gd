class_name CircleState
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
	id = "circle_state"
	
	
func _ready() -> void:
	super()
	randomize()
	if randi_range(0, 1):
		boundary_correction_sign = -1
	allowed_angle_deviance *= boundary_correction_sign
