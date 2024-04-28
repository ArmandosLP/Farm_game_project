extends CanvasLayer
class_name Conversation_Displayer

@export var visible_characters := 0.0 
@onready var animation_player = %AnimationPlayer
@onready var text_displayer = %TextDisplayer
@onready var button_list = %Button_list
@onready var face_image = %Face_image

var advertise_when_finished_displaying_text = false

func _process(delta):
	text_displayer.visible_characters = int(visible_characters)
	if advertise_when_finished_displaying_text == true and visible_characters > text_displayer.text.length():
		Conversation.finished_displaying_text()
		advertise_when_finished_displaying_text = false
