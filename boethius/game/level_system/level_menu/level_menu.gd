class_name LevelMenu
extends Control

var level_manager : LevelManager
@export var button_holder : Control
@export var level_button_scene : PackedScene


func _ready() -> void:
	deactivate()
	

func activate() -> void:
	visible = true

	
	
func deactivate() -> void:
	visible = false



func build_menu() -> void:
	for level in level_manager.level_list:
		if level.included_in_menu:
			var b : LevelButton = set_up_level_button(level)
			button_holder.add_child(b)
			
			
func set_up_level_button(level : LevelData) -> LevelButton:
	var b : LevelButton = level_button_scene.instantiate()
	b.level_data = level
	b.level_menu = self
	return b


func level_selected(level : LevelData) -> void:
	deactivate()
	level_manager.open_level_by_index(level.index)
