class_name CommandMode
extends Node2D

signal enabled_changed(enabled : bool)
signal entered_ship(ship : Ship)
signal exited_ship(ship : Ship)

var level : Level
var enabled : bool = false

var selected_ships : Array[Ship]

var faction: Ship.Faction = Ship.Faction.PLAYER

var occupied_ship : Ship = null

@export var selected_color : Color = Color.WHITE
@export var occupied_color : Color = Color.BLUE

var not_available = false

func enter() -> void:
	if not enabled and not not_available:
		enabled = true
		level.command_mode_camera.enabled = true
		Hud.deactivate()
		enabled_changed.emit(enabled)
		if is_instance_valid(occupied_ship):
			if occupied_ship.under_player_control:
				occupied_ship.under_player_control = false
				exited_ship.emit(occupied_ship)


func exit() -> void:
	if enabled and is_instance_valid(occupied_ship):
		enabled = false
		level.command_mode_camera.enabled = false
		deselect_all_ships()
		queue_redraw()
		enabled_changed.emit(enabled)
		occupied_ship.under_player_control = true
		entered_ship.emit(occupied_ship)
		Hud.activate()
		occupied_ship.set_up_HUD()
		
func select_ship(ship : Ship) -> void:
	deselect_all_ships()
	ship.selected = true
	selected_ships.append(ship)
	
	
func add_new_selected_ship(ship : Ship) -> void:
	ship.selected = true
	if not selected_ships.has(ship):
		selected_ships.append(ship)
	
	
func deselect_ship(ship : Ship) -> void:
	if is_instance_valid(ship):
		ship.selected = false
	selected_ships.erase(ship)
	
	
func deselect_all_ships() -> void:
	for ship in selected_ships:
		if is_instance_valid(ship):
			ship.selected = false
	selected_ships.clear()
	
	
func set_occupied_ship(ship : Ship) -> void:
	occupied_ship = ship
	
	
func _input(event) -> void:
	if event.is_action_pressed("toggle_command_mode"):
		if enabled:
			exit()
		else:
			enter()



func _process(_delta: float) -> void:
	if enabled:
		queue_redraw()
		
		
func _draw() -> void:
	if enabled:
		for ship in selected_ships:
			if is_instance_valid(ship):
				draw_circle(to_local(ship.global_position), ship.radius + 20, selected_color, false)
		if is_instance_valid(occupied_ship):
			draw_circle(to_local(occupied_ship.global_position), occupied_ship.radius + 10, occupied_color, false)
			
			
func _ready() -> void:
	enter()
			
