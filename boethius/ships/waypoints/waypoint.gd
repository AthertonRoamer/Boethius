class_name WayPoint
extends Node2D

signal deleted

@export var color : Color = Color.WHITE
@export var selected_color : Color = Color.WHITE

var selected : bool = false:
	set(b):
		if selected != b:
			selected = b
			queue_redraw()
			
var radius : float = 8
var triangle_radius : float = 12
var select_radius : float = 24
var master : WayPointMaster

var next_waypoint : WayPoint:
	set(v):
		next_waypoint = v
		queue_redraw()
		
var last_waypoint : WayPoint

var triangle : PackedVector2Array = []
var triangle_outline : PackedVector2Array = []

func _ready() -> void:
	if get_local_mouse_position().length() <= select_radius:
		if not selected:
			master.register_selected_waypoint(self, true)
			
	#construct equilateral triangle
	var head : Vector2 = Vector2.RIGHT * triangle_radius
	triangle.append(head)
	triangle.append(head.rotated(TAU/3))
	triangle.append(head.rotated(TAU * 2/3))
	triangle_outline = triangle.duplicate()
	triangle_outline.append(head)


func _draw() -> void:
	if selected:
		draw_circle(Vector2.ZERO, radius + 5, selected_color, false, 2, true)
	if is_instance_valid(next_waypoint):
		draw_line(Vector2.ZERO, to_local(next_waypoint.global_position), color, 1, true)
		
		draw_set_transform(Vector2.ZERO, to_local(next_waypoint.global_position).angle())
		draw_colored_polygon(triangle, color)
		draw_polyline(triangle_outline, color, 1.0, true)
	else:
		draw_circle(Vector2.ZERO, radius, color, true, -1, true)
		
		
func delete() -> void:
	if is_instance_valid(last_waypoint):
		last_waypoint.next_waypoint = null
	if is_instance_valid(next_waypoint):
		next_waypoint.last_waypoint = null
	deleted.emit()
	queue_free()
	
	
func _input(event: InputEvent) -> void:
	if master.active:
		if event is InputEventMouseMotion:
			if get_local_mouse_position().length() <= select_radius:
				if not selected:
					master.register_selected_waypoint(self, true)
			else:
				if selected:
					master.register_selected_waypoint(self, false)
					
					
func has_next_waypoint() -> bool:
	return is_instance_valid(next_waypoint)
	
	
func has_last_waypoint() -> bool:
	return is_instance_valid(last_waypoint)
