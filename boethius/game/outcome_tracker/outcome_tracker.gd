extends Node
class_name OutcomeTracker

signal won
signal lost

enum Event {SHIP_DESTROYED}

var resolved : bool = false
var explosions : int = 0
var should_announce_loss : bool = false
var should_announce_win : bool = false

func handle_event(event : Event) -> void:
	match event:
		Event.SHIP_DESTROYED:
			handle_ship_destroyed()
	check_for_outcome()
			
			
func handle_ship_destroyed() -> void:
	check_for_outcome()
	
	
func check_for_outcome() -> void:
	if Main.world.ship_database.get_ships_by_faction(Ship.Faction.ENEMY).is_empty() and not should_announce_loss:
		if explosions == 0:
			announce_win()
		else:
			should_announce_win = true
	elif Main.world.ship_database.get_ships_by_faction(Ship.Faction.PLAYER).is_empty() and not should_announce_win:
		if explosions == 0:
			announce_loss()
		else:
			should_announce_loss = true
			
			
func _process(delta: float) -> void:
	if explosions <= 0:
		if should_announce_loss:
			announce_loss()
		elif should_announce_win:
			announce_win()
	
	
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
