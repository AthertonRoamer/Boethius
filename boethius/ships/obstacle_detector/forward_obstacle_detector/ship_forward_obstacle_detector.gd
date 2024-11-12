class_name ShipForwardObstacleDetector
extends Node2D

@export var extra_ray_count : int = 5 #per side - value of one means total of 3 rays
@export var ray_gap : float = 5 #degrees
@export var ray_length : float = 200

var rays : Dictionary = {}
var ray_data : Dictionary = {}

func _ready() -> void:
	#add rays
	#add front ray
	add_ray()
	#add right rays
	for i in range(1, extra_ray_count + 1):
		add_ray(i * ray_gap)
	#add left rays
	for i in range(1, extra_ray_count + 1):
		add_ray(-i * ray_gap)
		
		
func _process(_delta: float) -> void:
	update_ray_data()


func update_ray_data() -> void:
	for angle in rays:
		var ray : RayCast2D = rays[angle]
		if not ray.is_colliding():
			ray_data[angle] = -1 #signifies not colliding
		else:
			ray_data[angle] = ray.get_collision_point().length()
			
			
func is_front_blocked() -> bool:
	return not ray_data[0] == -1
	
	
func is_right_blocked() -> bool:
	for angle in rays:
		if angle > 0:
			if angle != -1:
				return true
	return false
	
	
func is_left_blocked() -> bool:
	for angle in rays:
		if angle < 0:
			if angle != -1:
				return true
	return false


func add_ray(angle_from_center : float = 0) -> void:
	var dir : Vector2 = Vector2.RIGHT.rotated(deg_to_rad(angle_from_center))
	var point : Vector2 = dir * ray_length
	var ray : RayCast2D = RayCast2D.new()
	ray.target_position = point
	add_child(ray)
	#register ray
	rays[angle_from_center] = ray
