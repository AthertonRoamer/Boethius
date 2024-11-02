class_name ShipStateMachine
extends StateMachine

var ship : Ship

func _ready() -> void:
	super()
	if get_parent() is Ship:
		ship = get_parent()
	else:
		push_warning("Ship state machine is not a child of a ship")
		active = false
