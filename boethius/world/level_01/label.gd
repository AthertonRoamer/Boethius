extends Label


func _ready() -> void:
	Main.world.starting.connect(_on_setup)
	
	
func _on_setup() -> void:
	hide()
