class_name State
extends Node

@export var id : String = "state"
@export var first_active_state : bool = false

var state_machine : StateMachine
var active : bool = false
var satisfied : bool = false



func _ready() -> void:
	if get_parent() is StateMachine:
		state_machine = get_parent()
		state_machine.register_new_state(self)
	else:
		push_warning("State should be a child of a StateMachine")


func activate() -> void:
	active = true
	satisfied = false


func deactivate() -> void:
	active = false
	if not satisfied:
		state_machine.past_states.push_back(id)


func process_state(_delta : float) -> void:
	pass
	
	
