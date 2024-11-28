class_name SpawnPoint
extends Node2D

@export var fleet : FleetData
@export var faction : Ship.Faction = Ship.Faction.PLAYER
@export var enabled : bool = true

func _ready() -> void:
	if enabled:
		fleet.call_deferred("launch", global_position, faction)
