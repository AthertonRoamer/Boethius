class_name Game
extends Node

@onready var level_manager : LevelManager = $LevelManager

#this is THE game
func get_active_level() -> Level:
	return level_manager.active_level
	
	
func get_command_mode() -> CommandMode:
	if get_active_level() == null:
		return null
	else:
		return get_active_level().command_mode
