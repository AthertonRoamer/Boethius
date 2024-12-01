class_name ShipCamera
extends Camera2D


func _ready() -> void:
	enabled = false
	if get_parent() is Ship:
		get_parent().under_player_control_changed.connect(_on_under_player_control_changed)
	
	
func _on_under_player_control_changed(b : bool) -> void:
	enabled = b
