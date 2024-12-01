class_name FollowWaypoint
extends ShipState

func _init() -> void:
	id = "follow_waypoint"
	
	
var waypoint : WayPoint
var following : bool = false
var waypoint_achieved_radius : float = 150


func _ready() -> void:
	super()
	Main.world.setup_complete.connect(_on_setup)
	#Main.world.command_mode.waypoint_master.deleted_waypoint.connect(_on_waypoint_deleted)
	

	
func _on_setup() -> void:
	#print("here in waypoint")
	Main.world.command_mode.waypoint_master.deleted_waypoint.connect(_on_waypoint_deleted)
	pass


func select_desired_direction() -> void:
	if is_instance_valid(waypoint):
		if get_ship().global_position.distance_to(waypoint.global_position) <= waypoint_achieved_radius:
			if waypoint.has_next_waypoint() and waypoint.next_waypoint != waypoint:
				waypoint = waypoint.next_waypoint
			else:
				following = false
		desired_direction = get_ship().global_position.direction_to(waypoint.global_position)
	else:
		following = false
	
	
func set_waypoint(new_waypoint : WayPoint) -> void:
	following = true
	waypoint = new_waypoint
	
	
func consider_changing_state() -> void:
	
	if not get_ship().ship_area.get_visible_enemies().is_empty():
		if state_machine.get_state("shoot") != null:
			state_machine.get_state("shoot").target = get_ship().ship_area.get_visible_enemies()[0]
			state_machine.set_state("shoot")
	elif not following:
		satisfied = true
		var ns = state_machine.past_states.pop_back()
		state_machine.set_state(ns)


func _on_waypoint_deleted(wp : WayPoint) -> void:
	if wp == waypoint:
		if waypoint.has_next_waypoint() and waypoint != waypoint.next_waypoint:
			waypoint = waypoint.next_waypoint
		else:
			following = false
