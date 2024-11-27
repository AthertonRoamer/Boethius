class_name LevelManager
extends Node

@export var level_list : Array[PackedScene]
var active_level_scene : PackedScene
var active_level : Level

var level_index : int = 0

func _ready() -> void:
	if level_list.size() >= 1 and level_list[0] != null and level_list[0].can_instantiate():
		open_level(level_list[0])
	else:
		push_warning("Level Manager has no Levels")


func open_level(level_scene : PackedScene) -> void:
	var level : Level = level_scene.instantiate()
	active_level_scene = level_scene
	active_level = level
	add_child(active_level)
	
	
func close_active_level() -> void:
	active_level.queue_free()
	
	
func reload_active_level() -> void:
	close_active_level()
	open_level(active_level_scene)
	
	
func transfer_to_next_level() -> void:
	level_index += 1
	if level_list.size() >= level_index + 1 and level_list[level_index] != null and level_list[level_index].can_instantiate():
		close_active_level()
		open_level(level_list[level_index])
	else:
		if is_instance_valid(Main.main):
			close_active_level()
			Main.main.exit_game_to_menu()
		else:
			push_warning("No level level to load")
			
			
func load_level_by_index(level_num : int) -> void:
	if level_list.size() >= level_num + 1 and level_list[level_num] != null and level_list[level_num].can_instantiate():
		level_index = level_num
		close_active_level()
		open_level(level_list[level_index])
	else:
		push_warning("Level manager given invalid level index to switch to")
		
	
