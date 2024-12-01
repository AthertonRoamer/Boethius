class_name Order

var ship : Ship

func follow_waypoint(waypoint : WayPoint) -> void:
	if ship.state_machine.get_state("follow_waypoint") != null:
		ship.state_machine.get_state("follow_waypoint").set_waypoint(waypoint)
		ship.state_machine.set_state("follow_waypoint")
	else:
		push_warning("ship: " + str(ship) + "doesnt have follow waypoint state configured")
