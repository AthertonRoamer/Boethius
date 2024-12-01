class_name ShipInfo
extends SubMenu

var ship_data : ShipData = preload("res://ships/basic_ship/basic_ship_data.tres")

func _ready() -> void:
	menu_name = ship_data.name
	$ScrollContainer/HBoxContainer/VBoxContainer/TextureRect.texture = ship_data.ship_image
	$ScrollContainer/HBoxContainer/VBoxContainer/PriceLabel.text = "Price: " + str(ship_data.ship_price)
	$ScrollContainer/HBoxContainer/VBoxContainer/NameLabel.text = ship_data.name
	$ScrollContainer/HBoxContainer/VBoxContainer/ShortD.text = ship_data.short_description
	$ScrollContainer/HBoxContainer/VBoxContainer/HealthLabel.text = "Health: " + ship_data.health
	$ScrollContainer/HBoxContainer/VBoxContainer/DamageLabel.text = "Damage: " + ship_data.dmg
	$ScrollContainer/HBoxContainer/VBoxContainer/FullD.text = "Full Description:\n" + ship_data.full_description
