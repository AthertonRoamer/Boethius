extends CanvasLayer

@export var respawn_button : Button

func _ready() -> void:
	deactivate()
	
	
func activate() -> void:
	visible = true
	layer = 2
	
	
func deactivate() -> void:
	visible = false
	layer = -1
