extends PanelContainer




func _on_new_game_pressed():
	InventoryManager.initialize()
	get_tree().change_scene_to_file("res://Map/Mundo_de_pruebas.tscn")

func _on_load_game_pressed():
	SaveSystem.load_game()
	get_tree().change_scene_to_file("res://Map/Mundo_de_pruebas.tscn")

const OPTIONS_MENU = preload("res://System/Main_menu/options_menu.tscn")
func _on_options_pressed():
	add_child(OPTIONS_MENU.instantiate())


func _on_leave_pressed():
	get_tree().quit()
