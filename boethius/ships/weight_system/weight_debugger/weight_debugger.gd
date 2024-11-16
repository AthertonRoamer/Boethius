class_name WeightDebugger
extends Node2D

@export var circle_color : Color
@export var highest_color : Color
var weight_system : WeightSystem = WeightSystem.new()
@export var scale_factor : float = 200

func _process(_delta: float) -> void:
	position = get_window().size / 2
	weight_system.reset_weights()
	weight_system.register_normal(get_local_mouse_position().normalized())
	weight_system.register_blocked_normal(Vector2.RIGHT)
	queue_redraw()
	
	
	
	
func _draw() -> void:
	draw_rect(Rect2(-position.x, -position.y, 2000, 2000), Color.BLACK)
	draw_circle(Vector2.ZERO, scale_factor, circle_color, false)
	var highest_weight : Weight = weight_system.get_heaviest_weight()
	for weight in weight_system.weights:
		if not weight.blocked:
			draw_line(Vector2.ZERO, weight.normal * scale_factor, circle_color, 1.0)
			var color : Color = Color.GREEN if weight.value > 0 else Color.RED
			if weight == highest_weight:
				color = highest_color
			draw_line(Vector2.ZERO, weight.normal * abs(weight.value) * scale_factor, color, 1.0)
