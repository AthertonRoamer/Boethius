class_name VisibleShipWeightDegugger
extends WeightDebugger

func _ready() -> void:
	weight_system = get_parent().weight_system
	
	
func _process(_delta: float) -> void:
	queue_redraw()
	global_rotation = 0


func _draw() -> void:
	var highest_weight : Weight = weight_system.get_heaviest_weight()
	for weight in weight_system.weights:
			#draw_line(Vector2.ZERO, weight.normal * scale_factor, circle_color, 1.0)
			var color : Color = Color.GREEN if weight.value > 0 else Color.RED
			if weight.blocked:
				draw_line(Vector2.ZERO, weight.normal * 0.5 * scale_factor, Color.ORANGE, 1.0)
			else:
				if weight == highest_weight:
					color = highest_color
				draw_line(Vector2.ZERO, weight.normal * abs(weight.value) * scale_factor, color, 1.0)
