extends PanelContainer
class_name Conversation_button

@onready var button_text = %Button_text
var selected : bool = false
var option : Option
@onready var textura_marco = %Textura_marco

func _ready():
	button_text.text = option.text

func _input(event):
	if selected and event.is_action_released("Mouse_left_click"):
		Conversation.option_was_chosen(option)
		
func _on_mouse_entered():
	textura_marco.set_self_modulate(Color(1, 1, 0.725))
	selected = true
	
func _on_mouse_exited():
	textura_marco.set_self_modulate(Color(1, 1, 1))
	selected = false
