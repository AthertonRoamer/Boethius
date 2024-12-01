extends GPUParticles2D


#
#func _ready() -> void:
	##print("hi")
	#$AnimationPlayer.play("blow up")
var cam = false
func blow_up():
	$AnimationPlayer.play("blow up")
	$Camera2D.enabled = false


func blow_up_cam():
	cam = true
	$AnimationPlayer.play("blow up")
	Main.world.command_mode.not_available = true
	$Camera2D.enabled = true

func _on_animation_player_animation_finished(_anim_name: StringName) -> void:
	if cam:
		Main.world.command_mode.not_available = false
		Main.world.command_mode.enter()
		Main.world.outcome_tracker.handle_event(OutcomeTracker.Event.SHIP_DESTROYED)
	queue_free()
