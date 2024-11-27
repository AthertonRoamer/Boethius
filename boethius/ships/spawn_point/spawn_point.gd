class_name SpawnPoint
extends Node2D

@export var fleet : FleetData
@export var faction : Ship.Faction = Ship.Faction.PLAYER

func _ready() -> void:
	fleet.call_deferred("launch", global_position, faction)
