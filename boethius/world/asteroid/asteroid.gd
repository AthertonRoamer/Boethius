extends CharacterBody2D


@export var explosion_scene : PackedScene

@export var inertia : float
@export var friction : float
@export var max_speed : float

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
	add_to_group("knockable")
	add_to_group("crashable")

func _physics_process(delta: float) -> void:
	var dir : Vector2 = velocity.normalized()
	var speed : float = velocity.length()
	speed -= friction
	speed = max(0, speed)
	speed = min(speed, max_speed)
	velocity = dir * speed
	#move_and_slide()

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

func take_damage(damage : float, _damage_type : String = "none") -> void:
	health -= damage
	$damage.play() 

func take_knockback(knock : Vector2) -> void:
	#velocity += knock/inertia
	pass

func die() -> void:
	var explosion = explosion_scene.instantiate()
	explosion.global_position = global_position
	if is_instance_valid(Main.world):
		Main.world.add_child(explosion)
	queue_free()


func _on_sound_timer_timeout() -> void:
	sound_ready = true
