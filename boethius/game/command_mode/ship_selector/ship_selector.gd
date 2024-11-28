class_name ShipSelector
extends Area2D

@export var command_mode : CommandMode
@export var preselect_color : Color = Color.WHITE

func _ready() -> void:
	if is_instance_valid(command_mode):
		command_mode.enabled_changed.connect(_on_enabled_changed)

func _process(_delta: float) -> void:
	global_position = get_global_mouse_position()
	if command_mode.enabled:
		queue_redraw()
	
	
func _input(event: InputEvent) -> void:
	if command_mode.enabled:
		if event.is_action_pressed("add_selected_ship"):
			add_selected_ship()
		elif event.is_action_pressed("select_ship"):
			select_ship()
		elif event.is_action_pressed("set_occupied_ship"):
			set_occupied_ship()
			
			
func set_occupied_ship() -> void:
	for body in get_overlapping_bodies():
		if body is Ship and body.faction == command_mode.faction:
			command_mode.set_occupied_ship(body)
			break
		
	
	
func select_ship() -> void:
	for body in get_overlapping_bodies():
		if body is Ship and body.faction == command_mode.faction:
			if body.selected:
				command_mode.deselect_ship(body)
			else:
				command_mode.select_ship(body)
			break
	
	
func add_selected_ship() -> void:
	for body in get_overlapping_bodies():
		if body is Ship and not body.selected and body.faction == command_mode.faction:
			command_mode.add_new_selected_ship(body)
			break
			
			
func _draw() -> void:
	if command_mode.enabled:
		for body in get_overlapping_bodies():
			if body is Ship and body.faction == command_mode.faction:
				draw_circle(to_local(body.global_position), body.radius + 20, preselect_color, false)
				break
				

func _on_enabled_changed(_enabled) -> void:
	queue_redraw()
