class_name Idle
extends ShipState

func _init() -> void:
	id = "idle"

func consider_changing_state() -> void:
	if not get_ship().ship_area.get_visible_enemies().is_empty():
		if state_machine.get_state("shoot") != null:
			state_machine.get_state("shoot").target = get_ship().ship_area.get_visible_enemies()[0]
			state_machine.set_state("shoot")
			
			
func process_state(_delta: float) -> void:
	consider_changing_state()
