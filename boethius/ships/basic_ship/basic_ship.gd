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
		"death" : queue_free()






func take_damage(damage : float, _damage_type : String = "none") -> void:
	$AnimationPlayer.play("dmg")
	health -= damage
	
	
#func _draw() -> void:
	#if not under_player_control:
		#draw_line(Vector2.ZERO, current_direction.rotated(-rotation) * 10000, Color.ORANGE)
	
	
#func _process(_delta: float) -> void:
	#if not under_player_control:
		#queue_redraw()
