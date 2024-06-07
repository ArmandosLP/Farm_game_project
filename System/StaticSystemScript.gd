extends Node

var player : Player
var map : Node2D

func _input(event):
	if event.is_action("Stop_key"):
		if player != null:
			SaveSystem.save_game()
			get_tree().quit()
