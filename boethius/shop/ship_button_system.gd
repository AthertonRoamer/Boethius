class_name ShipButtonSystem
extends VBoxContainer

var shop : Shop
var ship_data : ShipData = load("res://ships/basic_ship/basic_ship_data.tres")
var count : int = 0:
	set(v):
		count = v
		$HBoxContainer2/VBoxContainer/HBoxContainer/Count.text = str(count)

func _ready() -> void:
	$HBoxContainer2/VBoxContainer/TextureRect.texture = ship_data.ship_image


func _on_up_pressed() -> void:
	if shop.purchase_ship(ship_data):
		count += 1
		shop.info_holder.open_menu(ship_data.name)


func _on_down_pressed() -> void:
	if shop.depurchase_ship(ship_data):
		count -= 1
		shop.info_holder.open_menu(ship_data.name)
		
		
func _gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			shop.info_holder.open_menu(ship_data.name)
