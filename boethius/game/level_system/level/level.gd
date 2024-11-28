class_name Level
extends World

@export var command_mode_camera : Camera2D
var command_mode : CommandMode
var command_mode_scene : PackedScene = preload("res://game/command_mode/command_mode.tscn")
var ship_database : ShipDatabase = ShipDatabase.new()
var outcome_tracker : OutcomeTracker = OutcomeTracker.new()

func _init() -> void:
	Main.world = self

func _ready() -> void:
	command_mode = command_mode_scene.instantiate()
	command_mode.level = self
	add_child(command_mode)
	add_child(outcome_tracker)
