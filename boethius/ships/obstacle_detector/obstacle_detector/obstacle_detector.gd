class_name ObstacleDetector
extends Node2D

@export var ray_count : int = 16
@export var ray_length : float = 300

var rays : Array[RayCast2D]

func _ready() -> void:
	var angle : float = 2 * PI / ray_count
	for i in range(ray_count):
		add_ray(angle * i)
		
		
func _process(_delta: float) -> void:
	global_rotation = 0


func add_ray(angle : float = 0) -> void:
	var dir : Vector2 = Vector2.RIGHT.rotated(angle)
	var point : Vector2 = dir * ray_length
	var ray : RayCast2D = RayCast2D.new()
	ray.set_collision_mask_value(1, false)
	ray.set_collision_mask_value(2, true)
	ray.target_position = point
	add_child(ray)
	rays.append(ray)
	
	
func get_colliding_rays() -> Array[RayCast2D]:
	return rays.filter(is_ray_colliding)
	
	
func is_ray_colliding(ray : RayCast2D) -> bool:
	return ray.is_colliding()
