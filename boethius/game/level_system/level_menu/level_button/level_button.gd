class_name LevelButton
extends Control

var level_menu : LevelMenu
var level_data : LevelData
@export var button : Button

func _ready() -> void:
	if level_data == null:
		push_warning("Level button has no data")
		return
	configure()
	button.pressed.connect(_on_button_pressed)
	
	
func configure() -> void:
	button.text = level_data.level_name
	
	
func _on_button_pressed() -> void:
	level_menu.level_selected(level_data)
