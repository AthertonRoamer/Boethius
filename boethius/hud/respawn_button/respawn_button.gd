extends Button


func _ready() -> void:
	hide()

func _on_pressed() -> void:
	get_tree().paused = false
	if is_instance_valid(Main.game):
		Main.game.level_manager.reload_active_level()
	hide()
