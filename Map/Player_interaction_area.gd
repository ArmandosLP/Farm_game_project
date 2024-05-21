extends Area2D

func _on_area_entered(area):
	if area.owner.has_meta("PlayerInteractionDetectorComponent"):
		area.owner.get_meta("PlayerInteractionDetectorComponent").set_player_inside(true)
	pass 

func _on_area_exited(area):
	if area.owner.has_meta("PlayerInteractionDetectorComponent"):
		area.owner.get_meta("PlayerInteractionDetectorComponent").set_player_inside(false)
