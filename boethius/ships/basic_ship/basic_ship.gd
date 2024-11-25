class_name BasicShip
extends Ship

@onready var gun1 = $gun1
@onready var gun2 = $gun2


func shoot():
	if under_player_control:
		var mouse_pos = get_global_mouse_position() 
		var direction_to_mouse = (mouse_pos - global_position).normalized()
		gun1.projectile_direction = direction_to_mouse
		gun2.projectile_direction = direction_to_mouse
	else:
		gun1.projectile_direction = current_direction
		gun2.projectile_direction = current_direction
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
	#$AnimationPlayer.play("dmg")
	health -= damage
	
	
#func _draw() -> void:
	#if not under_player_control:
		#draw_line(Vector2.ZERO, current_direction.rotated(-rotation) * 10000, Color.ORANGE)
	
	
#func _process(_delta: float) -> void:
	#if not under_player_control:
		#queue_redraw()
