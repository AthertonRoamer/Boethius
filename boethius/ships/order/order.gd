class_name Order

var ship : Ship

func follow_waypoint(waypoint : WayPoint) -> void:
	if ship.state_machine.get_state("follow_waypoint") != null:
		ship.state_machine.get_state("follow_waypoint").set_waypoint(waypoint)
		ship.state_machine.set_state("follow_waypoint")
	else:
		push_warning("ship: " + str(ship) + "doesnt have follow waypoint state configured")


func go_to_point(point):
	if ship.state_machine.get_state("circle") != null:
		ship.state_machine.get_state("circle").center_point = point
		ship.state_machine.set_state("circle")
		
		
func defend_point(point):
	if ship.state_machine.get_state("defend") != null:
		ship.state_machine.get_state("defend").center_point = point
		ship.state_machine.set_state("defend")
	
