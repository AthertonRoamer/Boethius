class_name BasicShip
extends Ship

@onready var gun1 = $gun1
@onready var gun2 = $gun2


func _ready() -> void:
	super()
	if faction == Faction.ENEMY:
		$ship_sprite.frame = 1
		$damage_shader.frame = 1
	else:
		$ship_sprite.frame = 0
		$damage_shader.frame = 0

func shoot():
	var mouse_pos = get_global_mouse_position() 
	var direction_to_mouse = (mouse_pos - global_position).normalized()
	gun1.projectile_direction = direction_to_mouse
	gun2.projectile_direction = direction_to_mouse
	gun1.fire()
	gun2.fire()


func _on_animation_player_animation_finished(_anim_name: StringName) -> void:
	match _anim_name:
		"dmg"   : $AnimationPlayer.play("RESET")
		"death" : queue_free()


func die() -> void:
	dying = true
	reset_visuals()
	$AnimationPlayer.play("death")


func take_damage(damage : float, _damage_type : String = "none") -> void:
	$AnimationPlayer.play("dmg")
	health -= damage
