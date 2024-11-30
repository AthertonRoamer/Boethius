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
