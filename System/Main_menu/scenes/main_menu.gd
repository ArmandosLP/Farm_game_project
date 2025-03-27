extends PanelContainer

func _ready():
	var config = SaveSystem.read_config_file()
	if config.fullscreen:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)


func _on_new_game_pressed():
	InventoryManager.initialize()
	EconomyManager.initialize()
	get_tree().change_scene_to_file("res://Map/Mundo_de_pruebas.tscn")

func _on_load_game_pressed():
	get_tree().change_scene_to_file("res://Map/Mundo_de_pruebas.tscn")
	SaveSystem.load_game()
	

const OPTIONS_MENU = preload("res://System/Main_menu/scenes/options_menu.tscn")
func _on_options_pressed():
	add_child(OPTIONS_MENU.instantiate())


func _on_leave_pressed():
	get_tree().quit()
