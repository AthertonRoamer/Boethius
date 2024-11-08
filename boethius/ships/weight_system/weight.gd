class_name Weight
extends RefCounted

var value : float = 0
var normal : Vector2
var ray : RayCast2D

func reset() -> void:
	value = 0
	
	
func register_normal(other_normal : Vector2, weight : float = 1) -> void:
	value += other_normal.dot(normal) * weight
