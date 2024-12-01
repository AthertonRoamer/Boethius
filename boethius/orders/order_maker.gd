class_name OrderMaker
extends Node2D

@export var enemy_defend_point : Node2D = self
@export var player_defend_point : Node2D = self


func _ready() -> void:
	Main.world.beginning_game.connect(_on_setup)
	
	
func _on_setup() -> void:
	order_enemies()
	order_players()
	
	
func order_players() -> void:
	print(Main.world.ship_database.get_ships_by_faction(Ship.Faction.PLAYER))
	for player in Main.world.ship_database.get_ships_by_faction(Ship.Faction.PLAYER):
		order_player(player)
	
	
func order_player(ship : Ship) -> void:
	ship.order.defend_point(player_defend_point.global_position)
	
	
func order_enemies() -> void:
	for player in Main.world.ship_database.get_ships_by_faction(Ship.Faction.ENEMY):
		order_enemy(player)
	
	
func order_enemy(ship : Ship) -> void:
	ship.order.defend_point(enemy_defend_point.global_position)
