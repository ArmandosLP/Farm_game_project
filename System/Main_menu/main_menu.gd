extends PanelContainer


func _on_leave_pressed():
	get_tree().quit()

func _on_new_game_pressed():
	InventoryManager.initialize()
	get_tree().change_scene_to_file("res://Map/Mundo_de_pruebas.tscn")

func _on_load_game_pressed():
	pass # Replace with function body.

func _on_options_pressed():
	pass # Replace with function body.
