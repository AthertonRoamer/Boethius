class_name SpaceStation
extends SpaceObject



@export var faction : Ship.Faction = Ship.Faction.ENEMY

func _ready() -> void:
	if faction == Ship.Faction.PLAYER:
		$Sprite2D.frame = 0
	else:
		$Sprite2D.frame = 1
