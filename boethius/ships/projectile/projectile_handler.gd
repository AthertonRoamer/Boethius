class_name ProjectileHandler
extends Node

@export var projectile_scene : PackedScene #should extend Projectile
@export var fire_position_node : Node2D

var projectile_direction : Vector2 = Vector2.RIGHT

var firing_constantly : bool = false

func set_up_projectile() -> Projectile:
	var new_projectile : Projectile = projectile_scene.instantiate()
	new_projectile.global_position = get_fire_position()
	new_projectile.direction = projectile_direction
	return new_projectile


func fire() -> void:
	if can_fire():
		fire_projectile()
		
		
func fire_projectile() -> void:
	var new_projectile = set_up_projectile()
	Main.world.add_child(new_projectile)


func get_fire_position() -> Vector2:
	return fire_position_node.global_position 
	
	
func can_fire() -> bool:
	return true


func begin_firing_constantly() -> void:
	firing_constantly = true
	
	
func stop_firing_constantly() -> void:
	firing_constantly = false
	
	
func _process(_delta: float) -> void:
	if firing_constantly:
		fire()
