extends StaticBody2D


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
	add_to_group("damageable")

func take_damage(damage : float, _damage_type : String = "none") -> void:
	health -= damage

func die() -> void:
	queue_free()
