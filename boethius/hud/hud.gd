extends CanvasLayer

@export var respawn_button : Button
@export var shieldbar : ProgressBar
@export var healthbar : ProgressBar 
@export var overheatbar : ProgressBar
@export var healthpanel : Panel

@export var overheat : Label

func _ready() -> void:
	deactivate()



func activate() -> void:
	self.visible = true
	layer = 2


func deactivate() -> void:
	self.visible = false
	layer = -1

func overheat_warning():
	pass

func low_health_warning():
	if $AnimationPlayer.current_animation != "low_health":
		$AnimationPlayer.play("low_health")

func reset_animations():
	$AnimationPlayer.play("RESET")
