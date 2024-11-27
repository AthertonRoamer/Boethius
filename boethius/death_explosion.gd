extends GPUParticles2D



func _ready() -> void:
	#print("hi")
	$AnimationPlayer.play("blow up")



func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	queue_free()
