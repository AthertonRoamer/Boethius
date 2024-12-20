class_name Game
extends Node

@onready var level_manager : LevelManager = $LevelManager
@onready var level_menu : LevelMenu = $LevelMenu
@export var open_to_menu : bool = false

#this is THE game
func get_active_level() -> Level:
	return level_manager.active_level


func get_command_mode() -> CommandMode:
	if get_active_level() == null:
		return null
	else:
		return get_active_level().command_mode
	
	
func _ready() -> void:
	Main.game = self
	level_menu.level_manager = level_manager
	level_menu.build_menu()
	if not open_to_menu:
		level_manager.open_first_level()
	else:
		level_menu.activate()
	
