class_name BasicShip
extends Ship

@onready var gun1 = $gun1
@onready var gun2 = $gun2


func shoot():
	var mouse_pos = get_global_mouse_position() 
	var direction_to_mouse = (mouse_pos - global_position).normalized()
	gun1.projectile_direction = direction_to_mouse
	gun2.projectile_direction = direction_to_mouse
	gun1.fire()
	gun2.fire()
