extends CanvasLayer

@export var respawn_button : Button
@export var shieldbar : ProgressBar
@export var healthbar : ProgressBar 
@export var overheatbar : ProgressBar
@export var healthpanel : Panel
@export var boostbar : ProgressBar

@export var overheat : Label

func _ready() -> void:
	deactivate()


func activate() -> void:
	$ControlShip.visible = true
	layer = 2


func deactivate() -> void:
	$ControlShip.visible = false
	layer = -1

var overheatable = true
func overheat_warning():
	if $overheat_animator.current_animation != "overheat_warning":
		$overheat_animator.play("overheat_warning")
		$overheat_timer.start()

func low_health_warning():
	if $health_animator.current_animation != "low_health":
		$health_animator.play("low_health")

func reset_animations():
	$health_animator.play("RESET")
	$overheat_animator.play("RESET")
	%overheatbar.value = 0
	%healthbar.value = 0
	%shieldbar.value = 0


func _on_overheat_timer_timeout() -> void:
	pass # Replace with function body.
