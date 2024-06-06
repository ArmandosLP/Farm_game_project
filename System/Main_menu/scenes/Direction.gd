extends HBoxContainer

@onready var preloads : PlayerSpritePreloads = %Preloads
@onready var character_sprites : PlayerSprite = %CharacterSprites

var index := 0

var direction : Dictionary = {
	0: "Idle_down",
	1: "Idle_right",
	2: "Idle_up",
	3: "Idle_left"
	}

func _on_left_button_up():
	if index > 0:
		index -= 1
	else:
		index = 3
	character_sprites.animation_player.play(direction[index])

func _on_right_button_up():
	if index < 3:
		index += 1
	else:
		index = 0
	character_sprites.animation_player.play(direction[index])
