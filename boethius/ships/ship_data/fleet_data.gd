class_name FleetData
extends Resource

@export var ships : Array[ShipData]

func launch(position : Vector2 = Vector2.ZERO, faction : Ship.Faction = Ship.Faction.PLAYER) -> void:
	var radius_factor : float = 25
	var radius : float = ships.size() * radius_factor
	var angle : float = TAU/ships.size()
	var current_angle : float = 0
	for ship in ships:
		ship.spawn(position + radius * Vector2.RIGHT.rotated(current_angle), faction)
		current_angle += angle
	
	
