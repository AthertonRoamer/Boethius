class_name State
extends Node

@export var id : String = "state"
@export var first_active_state : bool = false

var state_machine : StateMachine
var active : bool = false

func _ready() -> void:
	if get_parent() is StateMachine:
		state_machine = get_parent()
		state_machine.register_new_state(self)
	else:
		push_warning("State should be a child of a StateMachine")


func activate() -> void:
	active = true


func deactivate() -> void:
	active = false


func process_state(_delta : float) -> void:
	pass
	
	
