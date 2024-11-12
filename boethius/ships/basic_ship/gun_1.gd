class_name SmgShooter
extends ProjectileHandler


func set_up_projectile() -> Projectile:
	var new_projectile = super()
	
	new_projectile.wielder = $".."
	
	return new_projectile
