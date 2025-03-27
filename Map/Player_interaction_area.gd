extends Area2D

func _on_area_entered(area):
	if area.get_parent().has_meta("PlayerInteractionDetectorComponent"):
		area.get_parent().get_meta("PlayerInteractionDetectorComponent").set_player_inside(true)

func _on_area_exited(area):
	if area.get_parent().has_meta("PlayerInteractionDetectorComponent"):
		area.get_parent().get_meta("PlayerInteractionDetectorComponent").set_player_inside(false)
