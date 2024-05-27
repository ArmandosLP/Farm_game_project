extends Node

var player : Player

func _input(event):
	if event.is_action("Stop_key"):
		if player != null:
			SaveSystem.save_game()
			get_tree().quit()
