class_name StateMachine
extends Node

signal state_changed

@export var active : bool = true 
@export var auto_process : bool = false

var initial_state_id : String = ""
var active_state : State

var states : Dictionary = {}
#form::  key: state_id (String), value: state (EntityState)


func _ready() -> void:
	if states.is_empty():
		push_warning("StateMachine has no states")
		active = false
	if is_instance_valid(active_state):
		active_state.activate()
	else:
		push_warning("StateMachine has no initial state")
		active = false


func register_new_state(new_state : State) -> void:
	if states.keys().has(new_state.id):
		push_warning("State \"" + new_state.id + "\" not registered because another state with the same id is already registered") 
	else:
		states[new_state.id] = new_state
		if new_state.first_active_state:
			if initial_state_id == "":
				initial_state_id = new_state.id
				active_state = new_state
			else:
				push_warning("States \"" + initial_state_id + "\" and \"" + new_state.id + "\" both claim to be first active state. Keeping \"" + active_state.id + "\"")


func set_state(state_id : String = initial_state_id) -> void: #sets state from a state id (String)
	if state_id != "" and states.has(state_id):
		if state_id != active_state.id:
			active_state.deactivate()
			active_state = states[state_id]
			active_state.activate()
			state_changed.emit()
	else:
		push_warning("Attempted to set state to invalid state id: \"" + state_id + "\"")


func _process(delta) -> void:
	if active and auto_process:
		process_state(delta)
		
		
func process_state(delta : float) -> void:
	active_state.process_state(delta)
	
	
func get_state(state_id : String) -> State:
	if states.has(state_id):
		return states[state_id]
	else:
		return null
