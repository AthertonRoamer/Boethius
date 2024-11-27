class_name SmgShooter
extends OverHeatableShipProjectileHandler



@export var shot_interval = 0.2
var time_since_last_shot = 0.0

func set_up_projectile() -> Projectile:
	var new_projectile = super()
	
	new_projectile.wielder = $".."
	new_projectile.rotation = new_projectile.direction.angle()
	return new_projectile


func can_fire() -> bool:
	return super() and time_since_last_shot >= shot_interval


func _physics_process(delta: float) -> void:
	time_since_last_shot += delta


func fire_projectile():
	time_since_last_shot = 0.0
	var new_projectile = set_up_projectile()
	Main.world.add_child(new_projectile)
