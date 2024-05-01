extends Node2D

@onready var animation_player = %AnimationPlayer


func _on_area_2d_body_entered(body):
	if body.name == "Player":
		animation_player.play("Hide")

func _on_area_2d_body_exited(body):
	pass
	animation_player.play("Show")
