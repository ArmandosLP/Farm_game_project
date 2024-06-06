extends Control

@onready var preloads : PlayerSpritePreloads = %Preloads
@onready var character_sprites : PlayerSprite = %CharacterSprites

var style : int
var color : int
func _ready():
	color = 0
	style = 0

func _on_left_button_up():
	if preloads.CHARACTER_IDLE_HAIRSTYLES_ALL.size() - 1 > style:
		style += 1
	else:
		style = 0
	character_sprites.hair.texture = preloads.CHARACTER_IDLE_HAIRSTYLES_ALL[style][color]



func _on_right_button_up():
	if style > 0:
		style -= 1
	else:
		style = preloads.CHARACTER_IDLE_HAIRSTYLES_ALL.size() - 1
	character_sprites.hair.texture = preloads.CHARACTER_IDLE_HAIRSTYLES_ALL[style][color]


func _on_left_2_button_up():
	if preloads.CHARACTER_IDLE_HAIRSTYLES_ALL[style].size() - 1 > color:
		color += 1
	else:
		color = 0
	character_sprites.hair.texture = preloads.CHARACTER_IDLE_HAIRSTYLES_ALL[style][color]


func _on_right_2_button_up():
	if color > 0:
		color -= 1
	else:
		color = preloads.CHARACTER_IDLE_HAIRSTYLES_ALL[style].size() - 1
	character_sprites.hair.texture = preloads.CHARACTER_IDLE_HAIRSTYLES_ALL[style][color]

