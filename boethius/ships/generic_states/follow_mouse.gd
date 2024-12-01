class_name FollowMouseState
extends CircleState

func _init() -> void:
	super()
	radius = 100
	outer_radius = 200
	id = "follow_mouse"
	
func process_state(delta : float) -> void:
	center_point = get_ship().get_global_mouse_position()
	super(delta)
	
