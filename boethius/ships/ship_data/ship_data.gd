class_name ShipData
extends Resource

@export var ship_scene : PackedScene

func spawn(position : Vector2 = Vector2.ZERO, faction : Ship.Faction = Ship.Faction.PLAYER) -> void:
	var ship : Ship = ship_scene.instantiate()
	ship.global_position = position
	ship.faction = faction
	Main.world.add_child(ship)
