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

@export var under_player_control : bool = true

@export_group("Physics")
@export var friction : float = 200

@export_group("Ship mechanics")
@export var thrust_accel : float = 440
@export var rotation_speed : float = 360 #degrees per second
@export var max_speed : float = 350

var current_veloctiy : Vector2 = Vector2.ZERO
var current_direction : Vector2 = Vector2.RIGHT

var visual_data : VisualDataManager = VisualDataManager.new()

var state_machine : ShipStateMachine
var ship_area : ShipArea


func _ready() -> void:
	state_machine = get_node_or_null("ShipStateMachine")
	if not is_instance_valid(state_machine):
		push_warning("Ship has no state machine")
		

func _physics_process(delta) -> void:
	if under_player_control:
		register_player_input(delta)
	else:
		process_independenly(delta)
		thrust(delta)
		
	compute_physics(delta)
		
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
	speed = min(speed, max_speed)
	
	current_veloctiy = dir * speed
	
	
func register_player_input(delta : float) -> void:
	if Input.is_action_pressed("ship_rotate_clockwise"):
		current_direction = current_direction.rotated(deg_to_rad(rotation_speed * delta))
	if Input.is_action_pressed("ship_rotate_counterclockwise"):
		current_direction = current_direction.rotated(deg_to_rad(-rotation_speed * delta))
	if Input.is_action_pressed("ship_thrust"):
		current_veloctiy += current_direction * thrust_accel * delta
	visual_data.set_item("thrusting", Input.is_action_pressed("ship_thrust"))
	
	
func process_independenly(delta : float) -> void:
	if is_instance_valid(state_machine):
		state_machine.process_state(delta)
	
	
func update_rotation() -> void:
	rotation = current_direction.angle() 
	
	
func thrust(delta) -> void:
	current_veloctiy += current_direction * thrust_accel * delta
	visual_data.set_item("thrusting", true)
