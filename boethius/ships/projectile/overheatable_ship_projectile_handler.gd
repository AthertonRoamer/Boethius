class_name OverHeatableShipProjectileHandler
extends ShipProjectileHandler

signal just_overheated
signal cool_down_completed

var overheated : bool = false


@export var time_required_to_overheat : float = 3
@export var time_spent_shooting : float = 0
@export var cool_down_rate : float = 0.2
@export var full_cool_down_time : float = 2.5
var overheat_timer : Timer

func _ready() -> void:
	super()
	overheat_timer = Timer.new()
	add_child(overheat_timer)
	overheat_timer.wait_time = full_cool_down_time
	overheat_timer.timeout.connect(_on_overheat_timer_timeout)
	overheat_timer.one_shot = true

	
	if is_instance_valid(Main.world.command_mode):
		Main.world.command_mode.entered_ship.connect(_on_ship_entered)
	
	
	

func _process(delta: float) -> void:
	#update time values here
	super(delta) 
	
	if not overheated:
		if firing_constantly:
			time_spent_shooting += delta
			Hud.overheatbar.value = time_spent_shooting
			if time_spent_shooting >= time_required_to_overheat:
				overheated = true
				overheat_timer.start()
				just_overheated.emit()
				if is_instance_valid(ship) and ship.debug_output:
					print("overheated")
					Hud.overheat_warning()
		else:
			if time_spent_shooting > 0:
				time_spent_shooting = max(0, time_spent_shooting - cool_down_rate)
				Hud.overheatbar.value = time_spent_shooting
	if is_instance_valid(ship) and ship.debug_output and not overheated:
		#print(time_spent_shooting)
		pass
	
	if overheated:
		Hud.overheat_warning()


func can_fire() -> bool:
	return not overheated


func _on_overheat_timer_timeout() -> void:
	overheated = false
	time_spent_shooting = 0
	cool_down_completed.emit()
	if is_instance_valid(ship) and ship.debug_output:
		print("cooled down")
	Hud.overheatbar.value = 0


func _on_ship_entered(ship : Ship) -> void:
	if ship.under_player_control == true:
		Hud.overheatbar.max_value = time_required_to_overheat
		Hud.overheatbar.value = 0
		Hud.boostbar.max_value = ship.full_boost_spent_time
		Hud.boostbar.value = ship.full_boost_spent_time
	#pass
