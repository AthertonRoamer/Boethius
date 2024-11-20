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

@export var debug_output : bool = false

@export var under_player_control : bool = false
@export var auto_uses_space_physics : bool = false

@export_group("Ship Components")


@export_group("Physics")
@export var friction : float = 200



@export var max_health : int = 100
@export var starting_health : int = 100
var health : float = starting_health:

	set(v):
		if v <= 0:
			health = 0
			die()
		elif v > max_health:
			health = v
		else:
			health = v

@export_group("Ship mechanics")
@export var thrust_accel : float = 750
@export var max_speed : float = 360
@export var no_thrust_max_speed : float = 600


@export var boost_accel : float = 1750
@export var boost_max_speed : float = 1000
@export var speed_interpolation_rate : float = 5.0
@export var rotation_speed : float = 360
@export var sight_range : float = 300
var thrust_determinant : float = -0.1 #determines how close ai has to be to target direction to thrust
var boosting : bool = false

var dying = false

var current_veloctiy : Vector2 = Vector2.ZERO
var current_direction : Vector2 = Vector2.RIGHT

var visual_data : VisualDataManager = VisualDataManager.new()

var state_machine : ShipStateMachine
var ship_area : ShipArea
var obstacle_detector : ObstacleDetector = ObstacleDetector.new()
var weight_system : WeightSystem = WeightSystem.new()


func _ready() -> void:

	add_child(obstacle_detector)
	add_to_group("damageable")
	
	add_to_group("knockable")
	
	set_collision_mask_value(1, false)
	set_collision_mask_value(2, true)

	state_machine = get_node_or_null("ShipStateMachine")
	if not is_instance_valid(state_machine):
		push_warning("Ship has no state machine")
	current_direction = Vector2.RIGHT.rotated(rotation)
	
	if is_instance_valid(ship_area):
		ship_area.sight_range = sight_range

func _physics_process(delta) -> void:
	reset_visuals()
	if under_player_control:
		if !dying:
			register_player_input(delta)
			compute_physics(delta)


	else:
		process_independenly(delta)
		$Camera2D.enabled = false

		if auto_uses_space_physics:
			#physics_thrust(delta)
			compute_physics(delta)
		else:
			#thrust_without_physics()
			pass


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
		#print(speed)
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
	if Input.is_action_pressed("ship_shoot"):
		shoot()



func boost(delta : float) -> void:
	#print("boost")
	boosting = true
	current_veloctiy += current_direction * boost_accel * delta
	if !dying:
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
	if !dying:
		visual_data.set_item("thrusting", true)



func thrust_without_physics() -> void:
	current_veloctiy = current_direction * no_thrust_max_speed
	if !dying:
		visual_data.set_item("thrusting", true)


func thrust(delta) -> void:
	if auto_uses_space_physics or under_player_control:
		physics_thrust(delta)
	else:
		thrust_without_physics()


func rotate_toward_direction(target_direction : Vector2, delta : float, rotation_speed_deg : float = rotation_speed) -> void:
	var rsign : int = sign(current_direction.angle_to(target_direction))
	var rspeed : float = deg_to_rad(rotation_speed_deg)
	if abs(current_direction.angle_to(target_direction)) < rspeed * delta:
		current_direction = target_direction #if you have more than enough rotation speed to get to the desired direction, you just rotate straight to it and not past it
	current_direction = current_direction.rotated(rspeed * delta * rsign)


func reset_visuals() -> void:
	visual_data.set_item("thrusting", false)
	visual_data.set_item("boosting", false)


func take_knockback(knock : Vector2) -> void:
	current_veloctiy += knock
	#print("boom")


func take_damage(damage : float, _damage_type : String = "none") -> void:
	health -= damage


func die() -> void:
	dying = true
	reset_visuals()
	#current_veloctiy = Vector2.ZERO
	queue_free()


func shoot():
	pass
