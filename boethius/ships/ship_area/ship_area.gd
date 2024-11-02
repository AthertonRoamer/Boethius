class_name ShipArea
extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if get_parent() is Ship:
		get_parent().ship_area = self
