class_name HeavyA
extends Ship

@onready var gun1 = $gun1
@onready var gun2 = $gun2
@export var rot_mouse_speed = 90

func _ready() -> void:
	obstacle_detector.ray_length = 100
	super()
	if faction == Faction.ENEMY:
		$ship_sprite.frame = 3
		$damage_shader.frame = 3
	else:
		$ship_sprite.frame = 1
		$damage_shader.frame = 1

func register_player_input(delta : float) -> void:
	var mouse_pos = get_global_mouse_position() 
	var direction_to_mouse = (mouse_pos - global_position).normalized()
	#current_direction = direction_to_mouse 
	rotate_toward_direction(direction_to_mouse, delta, rot_mouse_speed)

	if Input.is_action_pressed("ship_thrust"):
		physics_thrust(delta)
	else:
		visual_data.set_item("thrusting", false)

	if Input.is_action_pressed("ship_boost"):
		boost(delta)
	elif Input.is_action_just_released("ship_boost") and boosting:
		visual_data.set_item("boosting", false)
		stop_boost()
	if Input.is_action_pressed("ship_shoot"):
		shoot()


func shoot():
	gun1.fire()
	gun2.fire()


func _on_animation_player_animation_finished(_anim_name: StringName) -> void:
	match _anim_name:
		"dmg"   : $AnimationPlayer.play("RESET")
		"death" : queue_free()


func take_damage(damage : float, _damage_type : String = "none") -> void:
	$AnimationPlayer.play("dmg")
	health -= damage
