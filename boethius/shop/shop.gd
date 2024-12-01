class_name Shop
extends CanvasLayer

var player_fleet : FleetData = FleetData.new()
var fleet_dict : Dictionary = {} #form - key: ShipData, value: int

var ship_button_system : PackedScene = preload("res://shop/ship_button_system.tscn")
var ship_info_scene : PackedScene = preload("res://shop/ship_info.tscn")

@export var available_ships : Array[ShipData] = []
@export var info_holder : InfoHolder
@export var grid_container : GridContainer

@export var starting_credits : int = 1000
@export var cred_label : CreditsLabel
var credits : int = 1000:
	set(v):
		credits = v
		cred_label.credits = v
		
		
func _ready() -> void:
	credits = starting_credits
	for s in available_ships:
		fleet_dict[s] = 0
		var bs : ShipButtonSystem = ship_button_system.instantiate()
		bs.ship_data = s
		bs.shop = self
		grid_container.add_child(bs)
		var si : ShipInfo = ship_info_scene.instantiate()
		si.ship_data = s
		info_holder.add_child(si)
	info_holder.refresh_sub_menus()

func activate() -> void:
	layer = 3
	show()
	process_mode = PROCESS_MODE_ALWAYS
	
	
func deactivate() -> void:
	layer = -2
	hide()
	process_mode = PROCESS_MODE_DISABLED


func _on_start_game_pressed() -> void:
	#set up fleet data from dict
	for ship in fleet_dict:
		for i in range(0, fleet_dict[ship]):
			player_fleet.ships.append(ship)
	if player_fleet.ships.size() > 0:
		Main.world.reslove_next_phase()
	
	
func purchase_ship(ship : ShipData) -> bool:
	if credits >= ship.ship_price:
		credits -= ship.ship_price
		fleet_dict[ship] += 1
		return true
	else:
		return false
		
	
	
func depurchase_ship(ship : ShipData) -> bool:
	if fleet_dict[ship] > 0:
		fleet_dict[ship] -= 1
		credits += ship.ship_price
		return true
	else:
		return false
		
