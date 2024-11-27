class_name Main
extends Node

static var world : World
static var main : Main

@export var menu_scene : PackedScene
@export var game_scene : PackedScene

var game : Node
var menu : Control


func _ready() -> void:
	main = self
	load_main_menu()
	

func load_main_menu() -> void:
	menu = menu_scene.instantiate()
	add_child(menu)
	
	
func close_menu() -> void:
	if is_instance_valid(menu):
		menu.queue_free()
	
	
func load_game() -> void:
	if game_scene != null:
		close_menu()
		game = game_scene.instantiate()
		add_child(game)
		
		
func exit_game_to_menu() -> void:
	if is_instance_valid(game):
		#Hud.visible = false
		game.queue_free()
		load_main_menu()
