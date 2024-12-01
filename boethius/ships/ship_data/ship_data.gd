class_name ShipData
extends Resource

@export var ship_scene : PackedScene
@export var ship_price : int = 100
@export var ship_image : Texture 
@export var name : String = "Fighter"
@export var health : String = "100"
@export var dmg : String = "10"
@export_multiline var short_description : String = "A really great member of the fleet"
@export_multiline var full_description : String = ""

func spawn(position : Vector2 = Vector2.ZERO, faction : Ship.Faction = Ship.Faction.PLAYER) -> void:
	var ship : Ship = ship_scene.instantiate()
	ship.global_position = position
	ship.faction = faction
	Main.world.add_child(ship)
