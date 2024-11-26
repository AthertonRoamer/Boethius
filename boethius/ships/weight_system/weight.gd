class_name Weight
extends RefCounted

var value : float = 0
var normal : Vector2
var blocked : bool = false
var blocked_threshhold_angle : float = 40


func reset() -> void:
	value = 0
	blocked = false
	
	
func register_normal(other_normal : Vector2, weight : float = 1) -> void:
	var new_value : float = (other_normal.dot(normal)) * weight
	if new_value > 0 or true:
		value += new_value


func register_blocked_normal(blocked_normal : Vector2, angle : float = -1) -> void:
	if angle < 0:
		angle = blocked_threshhold_angle
	blocked = abs(normal.angle_to(blocked_normal)) < deg_to_rad(angle) or blocked
