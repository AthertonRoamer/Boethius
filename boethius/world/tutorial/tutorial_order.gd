extends OrderMaker

#func order_players() -> void:
	#for player in Main.world.ship_database.get_ships_by_faction(Ship.Faction.PLAYER):
		#if player != Main.world.command_mode.occupied_ship:
			#order_player(player)
		#else:
			#player.order.idle()
	
	
func order_player(ship : Ship) -> void:
	print("here")
	print(player_defend_point.global_position)
	ship.order.go_to_point(player_defend_point.global_position)
