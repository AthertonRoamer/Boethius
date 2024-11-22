extends Node2D


func _process(_delta: float) -> void:
	global_position = get_global_mouse_position()
	queue_redraw()
	
	
func _draw() -> void:
	draw_circle(Vector2.ZERO, 150, Color.ORANGE, false)
	draw_circle(Vector2.ZERO, 300, Color.ORANGE, false)
