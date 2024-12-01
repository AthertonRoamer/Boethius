class_name Level
extends World

signal setup_complete

@export var command_mode_camera : Camera2D
var command_mode : CommandMode
var command_mode_scene : PackedScene = preload("res://game/command_mode/command_mode.tscn")
var ship_database : ShipDatabase = ShipDatabase.new()
var outcome_tracker : OutcomeTracker = OutcomeTracker.new()
@onready var shop : Shop = $Shop
var phase_index : int = -1
var movement_permitted : bool = false

@export var friendly_spawn : SpawnPoint 
@export var enemy_spawn : SpawnPoint

func _init() -> void:
	Main.world = self


func _ready() -> void:
	command_mode = command_mode_scene.instantiate()
	command_mode.level = self
	add_child(command_mode)
	add_child(outcome_tracker)
	setup_complete.emit()
	reslove_next_phase()
	
	
func reslove_next_phase() -> void:
	phase_index += 1
	match phase_index:
		0: #shop phase
			get_tree().paused = true
			shop.activate()
		1: #spawn 
			shop.deactivate()
			friendly_spawn.fleet = shop.player_fleet
			friendly_spawn.spawn()
			enemy_spawn.spawn()
			reslove_next_phase()
		2: #plan phase
			get_tree().paused = false
			command_mode.pre_game_activate()
		3:
			movement_permitted = true
			command_mode.pre_game_deactivate()
			get_tree().paused = false
	
