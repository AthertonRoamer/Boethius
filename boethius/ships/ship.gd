class_name Ship
extends CharacterBody2D

#Quality ideas:

#ship physical capabilities
#speed, health/shield, firepower, manueverability, ammunition, gun angle, fuel

#general data
#type_name, faction

#ai weights
#agression, loneliness, courage/fear, max range to fire, ideal range to fire
#priorities - hit big ships first, hit small ships first

@export var under_player_control : bool = false
@export var auto_uses_space_physics : bool = false

@export_group("Physics")
@export var friction : float = 200

@export_group("Ship mechanics")
@export var thrust_accel : float = 750
@export var rotation_speed : float = 360 #degrees per second
@export var max_speed : float = 360

@export var boost_accel : float = 1750
@export var boost_max_speed : float = 1000
@export var speed_interpolation_rate : float = 5.0
var boosting : bool = false

@export var max_health : int = 100
@export var starting_health : int = 100
var health : int = starting_health

var current_veloctiy : Vector2 = Vector2.ZERO
var current_direction : Vector2 = Vector2.RIGHT

var visual_data : VisualDataManager = VisualDataManager.new()

var state_machine : ShipStateMachine
var ship_area : ShipArea


func _ready() -> void:
	
	state_machine = get_node_or_null("ShipStateMachine")
	if not is_instance_valid(state_machine):
		push_warning("Ship has no state machine")
	current_direction = Vector2.RIGHT.rotated(rotation)


func _physics_process(delta) -> void:
	if under_player_control:
		register_player_input(delta)
		compute_physics(delta)
		
	else:
		process_independenly(delta)
		$Camera2D.enabled = false
		
		if auto_uses_space_physics:
			physics_thrust(delta)
			compute_physics(delta)
		else:
			thrust()


	velocity = current_veloctiy
	move_and_slide()

	update_rotation()


func compute_physics(delta : float) -> void:
	var dir : Vector2 = current_veloctiy.normalized()
	var speed : float = current_veloctiy.length()
	#apply friction
	speed -= friction * delta
	speed = max(0, speed)
	
	#enforce max speed
	if boosting: 
		speed = min(speed, boost_max_speed) 
	else:
		print(speed)
		if speed > max_speed:
			speed = lerp(speed, max_speed, speed_interpolation_rate * delta)
		else:
			speed = min(speed, max_speed)
	
	current_veloctiy = dir * speed


func register_player_input(delta : float) -> void:
	var mouse_pos = get_global_mouse_position() 
	var direction_to_mouse = (mouse_pos - global_position).normalized()
	current_direction = direction_to_mouse

	if Input.is_action_pressed("ship_thrust"):
		physics_thrust(delta)
	else:
		visual_data.set_item("thrusting", false)
	
	if Input.is_action_pressed("ship_boost"): 
		boost(delta) 
	elif Input.is_action_just_released("ship_boost") and boosting: 
		visual_data.set_item("boosting", false)
		stop_boost()


func boost(delta : float) -> void: 
	#print("boost") 
	boosting = true 
	current_veloctiy += current_direction * boost_accel * delta 
	visual_data.set_item("thrusting", true)
	visual_data.set_item("boosting", true)


func stop_boost() -> void: 
	#print("boost stop") 
	boosting = false


func process_independenly(delta : float) -> void:
	if is_instance_valid(state_machine):
		state_machine.process_state(delta)


func update_rotation() -> void:
	rotation = current_direction.angle() 


func physics_thrust(delta) -> void:
	current_veloctiy += current_direction * thrust_accel * delta
	visual_data.set_item("thrusting", true)


func thrust() -> void:
	current_veloctiy = current_direction * max_speed
	visual_data.set_item("thrusting", true)


func take_damage(damage : int, damage_type : String = "none", _damager : Node = null) -> void:
	health -= damage

func die() -> void:
	pass
