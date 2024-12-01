class_name TutorialOutcomeTracker
extends OutcomeTracker


func handle_ship_destroyed() -> void:
	pass
	
	
func check_for_outcome() -> void:
	print("here")
	if Main.world.ship_database.get_ships_by_faction(Ship.Faction.PLAYER).is_empty():
		announce_loss()
	
	
func announce_loss() -> void:
	print("here2")
	lost.emit()
	Hud.respawn_button.show()
	get_tree().paused = true
