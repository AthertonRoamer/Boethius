extends GPUParticles2D


func _process(_delta: float) -> void:
	if get_parent() is Ship:
		if get_parent().faction == get_parent().Faction.ENEMY:
			visible = get_parent().visual_data.get_item_value("boosting")
