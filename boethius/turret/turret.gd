class_name Turret
extends CharacterBody2D

@export var faction : Ship.Faction
@export var sight_range : float = 500

@onready var turret_area = $TurretArea

var target : Node2D
var current_direction = Vector2.RIGHT

@export var rotation_speed = 180

func _ready() -> void:
	if get_parent() is Ship:
		faction = get_parent().faction
		if faction == Ship.Faction.PLAYER:
			$Sprite2D.frame = 2
		else:
			$Sprite2D.frame = 3
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

func rotate_to_target(target,delta):
	var dir = global_position.direction_to(target.global_position)
	rotate_toward_direction(dir,delta)
	global_rotation = current_direction.angle()
	shoot()

func assess_targets() -> void:
	if not turret_area.get_visible_enemies().is_empty():
		target = turret_area.get_visible_enemies()[0]
