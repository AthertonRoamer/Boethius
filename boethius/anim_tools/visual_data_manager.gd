class_name VisualDataManager
extends RefCounted

var data : Array = []

func set_item(item_name : String, item_value : bool) -> void:
	var has_item : bool = data.has(item_name)
	if has_item == item_value:
		return
	
	if has_item:
		data.erase(item_name)
	else:
		data.append(item_name)
			
			
func get_item_value(item_name : String) -> bool:
	return data.has(item_name)
