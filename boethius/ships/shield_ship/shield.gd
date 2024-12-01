extends CharacterBody2D



@export var max_health : int = 1000
@export var starting_health : int = 1000
@export var allignment : Ship.Faction = Ship.Faction.ENEMY

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
	add_to_group("crashable")
	if allignment == Ship.Faction.PLAYER:
		$shield_image.frame = 0
		set_collision_layer_value(5,true)
	else:
		$shield_image.frame = 1
		set_collision_layer_value(4,true)


func take_damage(damage : float, _damage_type : String = "none") -> void:
	health -= damage


func die() -> void:
	deactivate()


func activate():
	$AnimationPlayer.play("activate")


func deactivate():
	$AnimationPlayer.play("deactivate")


var sound_ready = true
func play_hit_sound():
	if sound_ready:
		$hit.play()
		sound_ready = false
		$sound_timer.start()


func play_crash_sound():
	if sound_ready:
		$destroy.play()
		sound_ready = false
		$sound_timer.start()


func _on_sound_timer_timeout() -> void:
	sound_ready = true
