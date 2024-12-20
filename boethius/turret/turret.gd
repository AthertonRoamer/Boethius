class_name Turret
extends CharacterBody2D

@export var faction : Ship.Faction
@export var sight_range : float = 500

@onready var turret_area = $TurretArea
@export var explosion_scene : PackedScene


var target : Node2D
var current_direction = Vector2.RIGHT

@export var rotation_speed = 180

@export var max_health : int = 1000
@export var starting_health : int = 1000

var health : float = starting_health:

	set(v):
		if v <= 0:
			health = 0
			die()
		elif v > max_health:
			health = v
		else:
			health = v

func _ready() -> void:
	if get_parent() is Ship or get_parent() is SpaceStation:
		faction = get_parent().faction
		if faction == Ship.Faction.PLAYER:
			$Sprite2D.frame = 2
			#set_collision_layer_value(5, true)
			#set_collision_mask_value(5, true)
		else:
			$Sprite2D.frame = 3
			#set_collision_layer_value(4, true)
			#set_collision_mask_value(4, true)
	if is_instance_valid(turret_area):
		turret_area.sight_range = sight_range

func rotate_toward_direction(target_direction : Vector2, delta : float, rotation_speed_deg : float = rotation_speed) -> void:
	var rsign : int = sign(current_direction.angle_to(target_direction))
	var rspeed : float = deg_to_rad(rotation_speed_deg)
	if abs(current_direction.angle_to(target_direction)) < rspeed * delta:
		current_direction = target_direction #if you have more than enough rotation speed to get to the desired direction, you just rotate straight to it and not past it
	else:
		current_direction = current_direction.rotated(rspeed * delta * rsign)

func _process(delta: float) -> void:
	assess_targets()
	if is_instance_valid(target):
		rotate_to_target(target,delta)


func shoot():
	$gun.fire()

func rotate_to_target(ntarget, delta):
	var dir = global_position.direction_to(ntarget.global_position)
	rotate_toward_direction(dir,delta)
	global_rotation = current_direction.angle()
	shoot()

func assess_targets() -> void:
	if not turret_area.get_visible_enemies().is_empty():
		target = turret_area.get_visible_enemies()[0]


func take_damage(damage : float, _damage_type : String = "none") -> void:
	health -= damage

func die() -> void:
	var explosion = explosion_scene.instantiate()
	explosion.global_position = global_position
	if is_instance_valid(Main.world):
		Main.world.add_child(explosion)
	queue_free()
