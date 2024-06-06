extends Node2D
class_name PlayerSprite

@onready var animation_player = %AnimationPlayer
func _ready():
	animation_player.play("Idle_down")

@onready var body = %body
@onready var legs = %legs
@onready var shoes = %shoes
@onready var shirt = %shirt
@onready var jacket = %jacket
@onready var acessories = %acessories
@onready var hair = %hair
