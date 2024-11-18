class_name ShipArea
extends Area2D

var sight_range : float = 1:
	set(v):
		sight_range = v
		$CollisionShape2D.scale.x = v
		$CollisionShape2D.scale.y = v

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if get_parent() is Ship:
		get_parent().ship_area = self
