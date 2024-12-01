extends Node
class_name OutcomeTracker

signal won
signal lost

enum Event {SHIP_DESTROYED}

var resolved : bool = false

func handle_event(event : Event) -> void:
	match event:
		Event.SHIP_DESTROYED:
			handle_ship_destroyed()
	check_for_outcome()
			
			
func handle_ship_destroyed() -> void:
	check_for_outcome()
	
	
func check_for_outcome() -> void:
	if Main.world.ship_database.get_ships_by_faction(Ship.Faction.ENEMY).is_empty():
		announce_win()
	elif Main.world.ship_database.get_ships_by_faction(Ship.Faction.PLAYER).is_empty():
		announce_loss()
	
	
func announce_win() -> void:
	if not resolved:
		resolved = true
		won.emit()
		if is_instance_valid(Main.game):       
			Main.game.level_manager.transfer_to_next_level()
	
	
func announce_loss() -> void:
	if not resolved:
		resolved = true
		lost.emit()
		Hud.respawn_button.show()
		get_tree().paused = true
