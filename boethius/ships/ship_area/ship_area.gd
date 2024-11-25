class_name ShipArea
extends Area2D

var sight_range : float = 1:
	set(v):
		sight_range = v
		$CollisionShape2D.scale.x = v
		$CollisionShape2D.scale.y = v
		
var ship : Ship

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if get_parent() is Ship:
		get_parent().ship_area = self
		ship = get_parent()
	else:
		push_warning("Ship area is a child of a non-ship")

func get_visible_enemies() -> Array:
	return get_overlapping_bodies().filter(func(body): return body is Ship and body.faction != ship.faction)
	
	
func get_visible_allies() -> Array:
	return get_visible_ships_by_faction(ship.faction)
	
	
func get_visible_ships_by_faction(faction : Ship.Faction) -> Array:
	return get_overlapping_bodies().filter(func(body): return body is Ship and body.faction == faction)
	
