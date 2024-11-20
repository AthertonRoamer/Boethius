extends GPUParticles2D


func _process(_delta: float) -> void:
	if get_parent() is Ship:
		visible = get_parent().visual_data.get_item_value("boosting")
