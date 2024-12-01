extends OverHeatableShipProjectileHandler


func fire_projectile() -> void:
	if !overheated:
		$laser.is_casting = true

func release_laser() -> void:
	$laser.is_casting = false


func begin_firing_constantly():
	if !overheated:
		firing_constantly = true
		fire()
		$"../shoot".play()
		$"../beam".play()

func stop_firing_constantly():
	super()
	release_laser()
	$"../beam".stop()


func _process(delta: float) -> void:
	#update time values here
	super(delta) 
	
	if not overheated:
		if firing_constantly:
			time_spent_shooting += delta
			Hud.overheatbar.value = time_spent_shooting
			if time_spent_shooting >= time_required_to_overheat:
				overheated = true
				stop_firing_constantly()
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
