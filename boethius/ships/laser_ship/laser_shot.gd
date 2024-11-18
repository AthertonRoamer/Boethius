extends Node

func fire() -> void:
	$laser.is_casting = true

func release_laser() -> void:
	$laser.is_casting = false
