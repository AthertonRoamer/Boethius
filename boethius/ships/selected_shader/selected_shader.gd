extends Sprite2D

func _ready() -> void:
	visible = false
	#if get_parent() is Ship:
		#get_parent().selected_changed.connect(_on_selected_changed)
		#visible = get_parent().selected
		
		
func _on_selected_changed(selected : bool) -> void:
	visible = selected
