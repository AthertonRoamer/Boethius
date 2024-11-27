class_name MissileShip
extends Ship

@onready var gun1 = $gun1
@onready var gun2 = $gun2
@onready var gun3 = $gun3
@onready var gun4 = $gun4
@onready var gun5 = $gun5
@onready var gun6 = $gun6


func shoot():
	var mouse_pos = get_global_mouse_position() 
	var direction_to_mouse = (mouse_pos - global_position).normalized()
	gun1.projectile_direction = direction_to_mouse
	gun2.projectile_direction = direction_to_mouse
	gun3.projectile_direction = direction_to_mouse
	gun4.projectile_direction = direction_to_mouse
	gun5.projectile_direction = direction_to_mouse
	gun6.projectile_direction = direction_to_mouse
	
	gun1.fire()
	gun2.fire()
	gun3.fire()
	gun4.fire()
	gun5.fire()
	gun6.fire()
