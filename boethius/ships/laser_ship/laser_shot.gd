extends OverHeatableShipProjectileHandler


func fire() -> void:
	$laser.is_casting = true

func release_laser() -> void:
	$laser.is_casting = false


func begin_shooting_constantly():
	pass

func stop_shooting_constantly():
	pass
