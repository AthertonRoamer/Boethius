class_name CommandCamera
extends Camera2D

var starting_zoom : Vector2
var starting_pos : Vector2
var speed : float = 500

func _ready() -> void:
	starting_pos = position
	starting_zoom = zoom
	Main.world.setup_complete.connect(_on_setup)
	
	
func _on_setup() -> void:
	Main.world.command_mode.enabled_changed.connect(_on_command_mode_enabled_changed)
	

func _process(delta: float) -> void:
	var direction : Vector2 = Vector2.ZERO
	if Main.world.command_mode.enabled:
		if Input.is_action_pressed("camera_down"):
			direction += Vector2.DOWN
		if Input.is_action_pressed("camera_up"):
			direction += Vector2.UP
		if Input.is_action_pressed("camera_left"):
			direction += Vector2.LEFT
		if Input.is_action_pressed("camera_right"):
			direction += Vector2.RIGHT
		direction = direction.normalized()
		position += direction * speed * delta
		
		
func reset() -> void:
	zoom = Vector2(0.5, 0.5)
	position = starting_pos
	
	
func _on_command_mode_enabled_changed(e : bool) -> void:
	if e:
		reset()
