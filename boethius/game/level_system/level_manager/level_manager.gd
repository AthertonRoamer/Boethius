class_name LevelManager
extends Node

@export var open_level_on_load : bool = true
@export var level_list : Array[LevelData]

var active_level_scene : PackedScene
var active_level : Level

var level_index : int = 0

func _ready() -> void:
	update_level_data()
	if not open_level_on_load:
		return
	open_first_level()
	
	
func update_level_data() -> void:
	var menu_idx : int = 0
	var idx : int = 0
	for level_datum in level_list:
		if level_datum.included_in_menu:
			menu_idx += 1
			if level_datum.level_name == "":
				level_datum.level_name = str(menu_idx)
		level_datum.index = idx
		idx += 1
				
		
func open_first_level() -> void:
	if level_list.size() >= 1 and level_list[0].level_scene != null and level_list[0].level_scene.can_instantiate():
		open_level(level_list[0].level_scene)
	else:
		push_warning("Level Manager has no Levels")


func open_level(level_scene : PackedScene) -> void:
	var level : Level = level_scene.instantiate()
	active_level_scene = level_scene
	active_level = level
	add_child(active_level)
	
	
func close_active_level() -> void:
	if is_instance_valid(active_level):
		active_level.queue_free()
	active_level = null
	
	
func reload_active_level() -> void:
	close_active_level()
	open_level(active_level_scene)
	
	
func transfer_to_next_level() -> void:
	level_index += 1
	if level_list.size() >= level_index + 1 and level_list[level_index].level_scene != null and level_list[level_index].level_scene.can_instantiate():
		close_active_level()
		#open_level(level_list[level_index])
		call_deferred("open_level", level_list[level_index].level_scene)
	else:
		if is_instance_valid(Main.main):
			close_active_level()
			Main.main.exit_game_to_menu()
		else:
			push_warning("No level level to load")
			
			
func open_level_by_index(level_num : int) -> void:
	if level_list.size() >= level_num + 1 and level_list[level_num].level_scene != null and level_list[level_num].level_scene.can_instantiate():
		level_index = level_num
		close_active_level()
		open_level(level_list[level_index].level_scene)
	else:
		push_warning("Level manager given invalid level index to switch to")
		
		
func get_level_name_by_index(idx : float) -> String:
	var level : LevelData = level_list[idx]
	if level.level_name != "":
		return level.level_name
	var level_num : int = 1
	for i in range(0, idx - 1):
		if level_list[i].included_in_menu:
			level_num += 1
	return str(level_num)
		
	
