extends CircleState
class_name DefendState

func _init() -> void:
	super()
	id = "defend"


func consider_changing_state() -> void:
	if not get_ship().ship_area.get_visible_enemies().is_empty():
		if state_machine.get_state("shoot") != null:
			state_machine.get_state("shoot").target = get_ship().ship_area.get_visible_enemies()[0]
			state_machine.set_state("shoot")
