extends Button
class_name Conversation_button

var option : Option

func _ready():
	text = option.text

func _on_button_up():
	Conversation.option_was_chosen(option)
