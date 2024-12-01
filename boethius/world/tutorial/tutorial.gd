extends Level

@export var ship : Ship

func _init() -> void:
	super()
	outcome_tracker = TutorialOutcomeTracker.new()

func reslove_next_phase() -> void:
	phase_index += 1
	match phase_index:
		0: #shop phase
			#get_tree().paused = true
			#shop.activate()
		#1: #spawn 
			#shop.deactivate()
			#friendly_spawn.fleet = shop.player_fleet
			#friendly_spawn.spawn()
			#enemy_spawn.spawn()
			#reslove_next_phase()
		#2: #plan phase
			#get_tree().paused = false
			#command_mode.pre_game_activate()
		#3:
			friendly_spawn.spawn()
			setup_complete.emit()
			movement_permitted = true
			command_mode.pre_game_deactivate()
			command_mode.occupied_ship = ship
			command_mode.exit()
			get_tree().paused = false
			beginning_game.emit()


func _on_exit_tutorial_pressed() -> void:
	if is_instance_valid(Main.game):       
		Main.game.level_manager.transfer_to_next_level()
