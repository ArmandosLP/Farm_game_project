extends StaticBody2D
class_name Rock

var health : int = 1

func tool_interaction(_tool):
	health -= 1
	if health <= 0:
		queue_free()
