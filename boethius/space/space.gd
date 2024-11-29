extends ParallaxBackground

func _ready() -> void:
	if is_instance_valid(Main.world):
		Main.world.setup_complete.connect(_on_setup_complete)
		
		
func _on_setup_complete() -> void:
	Main.world.command_mode.enabled_changed.connect(_on_command_mode_enabled_changed)
	_on_command_mode_enabled_changed(Main.world.command_mode.enabled)
	
	
	
func _on_command_mode_enabled_changed(enabled : bool) -> void:
	if enabled:
		scale = Vector2(2, 2)
	else:
		scale = Vector2(1, 1)
