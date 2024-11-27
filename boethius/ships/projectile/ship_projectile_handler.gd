class_name ShipProjectileHandler
extends ProjectileHandler

@export var bullet_faction : Ship.Faction = Ship.Faction.PLAYER
var ship : Ship

func set_up_projectile() -> Projectile:
	var p : Projectile = super()
	p.set("faction", bullet_faction)
	p.direction = ship.current_direction
	return p
	
	
func _ready() -> void:
	if get_parent() is Ship:
		ship = get_parent()
	else:
		push_warning("Ship projectile handler isnt a child of a ship")
