extends Area2D
class_name PlayerInteractionDetectorComponent

var player_inside:bool = false

func _on_tree_entered():
	owner.set_meta(&"PlayerInteractionDetectorComponent",self)

func _on_tree_exited():
	if owner != null:
		owner.remove_meta(&"PlayerInteractionDetectorComponent")

func set_player_inside(state : bool):
	player_inside = state
	if owner != null:
		if state:
			if owner.has_method("player_entered_area"):
				owner.player_entered_area()
		else:
			if owner.has_method("player_exited_area"):
				owner.player_exited_area()
