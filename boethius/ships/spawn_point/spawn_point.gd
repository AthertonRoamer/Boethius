class_name SpawnPoint
extends Node2D

@export var fleet : FleetData

func _ready() -> void:
	fleet.call_deferred("launch", global_position)
