class_name ShipInfo
extends SubMenu

var ship_data : ShipData = preload("res://ships/basic_ship/basic_ship_data.tres")

func _ready() -> void:
	menu_name = ship_data.name
	$ScrollContainer/VBoxContainer/TextureRect.texture = ship_data.ship_image
	
