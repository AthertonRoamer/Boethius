class_name WeightSystem
extends RefCounted

var weight_count : int = 16
var weights : Array[Weight]

func _ready() -> void:
	#create weights
	var angle : float = 2 * PI / weight_count
	for i in range(weight_count):
		add_weight(Vector2.RIGHT.rotated(angle * i))
	
	
func add_weight(v : Vector2) -> void:
	var weight : Weight = Weight.new()
	weight.normal = v
	weights.append(weight)
	
	
func register_normal(normal : Vector2, weight : float = 1) -> void:
	for w in weights:
		w.register_normal(normal, weight)
		
		
func reset_weights() -> void:
	for w in weights:
		w.reset()


func get_heaviest_weight(tiebreaker : Vector2 = Vector2.ZERO) -> Weight:
	tiebreaker = tiebreaker.normalized()
	var heaviest : Weight = weights[0]
	for w in weights:
		if tiebreaker == Vector2.ZERO:
			if w.value > heaviest.value:
				heaviest = w
		else:
			if w.value > heaviest.value:
				heaviest = w
			elif is_equal_approx(w.value, heaviest.value):
				if abs(w.normal.angle_to(tiebreaker)) < abs(heaviest.normal.angle_to(tiebreaker)):
					heaviest = w
	return heaviest
