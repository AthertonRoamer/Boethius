class_name Main
extends Node

static var world : Level
static var main : Main
static var game : Game


@export var menu_scene : PackedScene
@export var game_scene : PackedScene

var menu : Control


func _ready() -> void:
	main = self
	load_main_menu()
	

func load_main_menu() -> void:
	#print("here3")
	if is_instance_valid(menu):
		menu.queue_free()
		push_warning("found an example of menu issue")
	menu = menu_scene.instantiate()
	add_child(menu)
	
	
func close_menu() -> void:
	#print("here1")
	if is_instance_valid(menu):
		#print("here2")
		menu.queue_free()
	
	
func load_game() -> void:
	if game_scene != null:
		close_menu()
		game = game_scene.instantiate()
		add_child(game)
		
		
func exit_game_to_menu() -> void:
	if is_instance_valid(game):
		game.queue_free()
	load_main_menu()
