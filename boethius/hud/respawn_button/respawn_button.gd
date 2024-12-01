extends Button


func _ready() -> void:
	hide()

func _on_pressed() -> void:
	
	if is_instance_valid(Main.game):
		Main.game.level_manager.reload_active_level()
	get_tree().paused = false
	hide()
