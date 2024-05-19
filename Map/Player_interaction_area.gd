extends Area2D

func _on_body_entered(body):
	if body.has_meta("PlayerInteractionDetectorComponent"):
		body.get_meta("PlayerInteractionDetectorComponent").set_player_inside(true)
		
func _on_body_exited(body):
	if body.has_meta("PlayerInteractionDetectorComponent"):
		body.get_meta("PlayerInteractionDetectorComponent").set_player_inside(false)
