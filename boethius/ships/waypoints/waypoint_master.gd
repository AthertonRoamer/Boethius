class_name WayPointMaster
extends Node2D

signal added_waypoint(waypoint : WayPoint)
signal deleted_waypoint(waypoint : WayPoint)
signal active_changed(active : bool)

var waypoint_scene : PackedScene = preload("res://ships/waypoints/waypoint.tscn")
var active : bool = true:
	set(b):
		if active != b:
			active = b
			active_changed.emit(active)
			visible = active

var building_chain : bool = false
var last_waypoint_in_chain : WayPoint

var moving_waypoint : bool = false

var selected_waypoint : WayPoint

var command_mode : CommandMode

func _ready() -> void:
	if get_parent() is CommandMode:
		command_mode = get_parent()
	else:
		push_warning("WaypointMaster isnt a child of a command mode")
		

func place_waypoint(wposition : Vector2) -> void:
	var w : WayPoint = waypoint_scene.instantiate()
	w.global_position = wposition
	w.master = self
	add_child(w)
	added_waypoint.emit(w)
	if is_instance_valid(last_waypoint_in_chain): #this point is part of a longer chain
		last_waypoint_in_chain.next_waypoint = w
		w.last_waypoint = last_waypoint_in_chain
	else: #this point is the first in the chain
		for ship in command_mode.selected_ships:
			ship.order.follow_waypoint(w)
		command_mode.deselect_all_ships()
	building_chain = true
	last_waypoint_in_chain = w
	queue_redraw()
	
	
func _input(event : InputEvent) -> void:
	if active and not command_mode.ship_selector.ship_detected:
		if event.is_action_pressed("place_waypoint"):
			if not has_selected_waypoint():
				place_waypoint(get_global_mouse_position())
			else:
				if not is_instance_valid(selected_waypoint.last_waypoint) and selected_waypoint != last_waypoint_in_chain and building_chain:
					last_waypoint_in_chain.next_waypoint = selected_waypoint
					selected_waypoint.last_waypoint = last_waypoint_in_chain
					last_waypoint_in_chain = null
					building_chain = false
					queue_redraw()
				elif not building_chain:
					moving_waypoint = true
				for ship in command_mode.selected_ships:
					ship.order.follow_waypoint(selected_waypoint)
				command_mode.deselect_all_ships()
		if event.is_action_pressed("enter_chain"):
			if not building_chain and has_selected_waypoint() and not moving_waypoint:
				if not is_instance_valid(selected_waypoint.next_waypoint):
					building_chain = true
					last_waypoint_in_chain = selected_waypoint
		if event.is_action_released("place_waypoint"):
			if moving_waypoint and not is_instance_valid(selected_waypoint.next_waypoint):
				building_chain = true
				last_waypoint_in_chain = selected_waypoint
			moving_waypoint = false
					
					
		if event.is_action_pressed("delete_waypoint"):
			if not building_chain:
				delete_selected_waypoint()
		if event.is_action_pressed("exit_chain"):
			building_chain = false
			last_waypoint_in_chain = null
			queue_redraw()
		if event is InputEventMouseMotion:
			if building_chain:
				queue_redraw()
			if moving_waypoint:
				selected_waypoint.global_position = get_global_mouse_position()
				selected_waypoint.queue_redraw()
				if is_instance_valid(selected_waypoint.last_waypoint):
					selected_waypoint.last_waypoint.queue_redraw()
			
			
func has_selected_waypoint() -> bool:
	return selected_waypoint != null and is_instance_valid(selected_waypoint)
	
	
func delete_selected_waypoint() -> void:
	if has_selected_waypoint():
		deleted_waypoint.emit(selected_waypoint)
		selected_waypoint.delete()


func register_selected_waypoint(waypoint : WayPoint, to_be_selected : bool = true) -> void:
	if not to_be_selected: #deselecting
		if waypoint == selected_waypoint and not moving_waypoint:
			selected_waypoint.selected = false
			selected_waypoint = null
	else: #selecting
		if not has_selected_waypoint() and active:
			#if building_chain and is_instance_valid(waypoint.next_waypoint):
				#return
			selected_waypoint = waypoint
			selected_waypoint.selected = true
			
			
func _draw() -> void:
	if building_chain:
		draw_line(last_waypoint_in_chain.global_position, get_global_mouse_position(), last_waypoint_in_chain.color, 1, true)
