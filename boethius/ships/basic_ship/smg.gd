class_name SmgShooter
extends ProjectileHandler

@export var shot_interval = 0.2
var time_since_last_shot = 0.0
var shooting = false

func set_up_projectile() -> Projectile:
	var new_projectile = super()
	
	new_projectile.wielder = $".."
	new_projectile.rotation = projectile_direction.angle()
	return new_projectile


func fire() -> void:
	shooting = true
	if time_since_last_shot >= shot_interval:
		smg_fire()


func _physics_process(delta: float) -> void:
	#if shooting:
	time_since_last_shot += delta


func smg_fire():
	time_since_last_shot = 0.0
	var new_projectile = set_up_projectile()
	Main.world.add_child(new_projectile)
