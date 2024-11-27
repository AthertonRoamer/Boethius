extends GPUParticles2D


func _ready() -> void:
	if get_parent().get_parent() is Ship:
		if get_parent().get_parent().faction == get_parent().get_parent().Faction.ENEMY:
			queue_free()

func _process(_delta: float) -> void:
	visible = get_parent().get_parent().visual_data.get_item_value("thrusting")
