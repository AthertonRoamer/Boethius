class_name ShipDatabase

var ships : Dictionary = {} #form - key: faction, value: Array[Ship]

func register_ship(ship : Ship) -> void:
	if not ships.has(ship.faction):
		ships[ship.faction] = []
	ships[ship.faction].append(ship)
	
	
func remove_ship(ship : Ship) -> void:
	if ships.has(ship.faction):
		ships[ship.faction].erase(ship)
		
		
func get_ships_by_faction(faction : Ship.Faction) -> Array:
	if ships.has(faction):
		return ships[faction]
	else:
		return []
