class_name InfoHolder
extends SubMenuHolder

func refresh_sub_menus() -> void:
	menus.clear()
	load_sub_menus()
	initialize_sub_menus()
	if get_child_count() > 0:
		open_menu((get_child(0) as SubMenu).menu_name)
