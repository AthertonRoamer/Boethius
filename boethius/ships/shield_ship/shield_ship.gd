class_name ShieldShip
extends Ship

@onready var gun1 = $gun1
@onready var gun2 = $gun2



func _ready() -> void:
	super()
	if faction == Faction.ENEMY:
		set_collision_mask_value(5,true)
		$ship_sprite.frame = 9
		$damage_shader.frame = 9
	else:

		set_collision_mask_value(4,true)

		$ship_sprite.frame = 8
		$damage_shader.frame = 8


func shoot():
	gun1.fire()
	gun2.fire()


func begin_shooting_constantly() -> void:
	gun1.begin_firing_constantly()
	gun2.begin_firing_constantly()
	
	
func stop_shooting_constantly() -> void:
	gun1.stop_firing_constantly()
	gun2.stop_firing_constantly()


func _on_animation_player_animation_finished(_anim_name: StringName) -> void:
	match _anim_name:
		"dmg"   : $AnimationPlayer.play("RESET")


func take_damage(damage : float, _damage_type : String = "none") -> void:
	health -= damage
	if under_player_control:
		Hud.healthbar.value = health
		if health < (max_health/2.0):
			Hud.low_health_warning()
	$AnimationPlayer.play("dmg")
	$damage.play()
